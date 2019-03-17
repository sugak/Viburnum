//
//  MultiPeerCommunicator.swift
//  Viburnum
//
//  Created by Maksim Sugak on 17/03/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class MultiPeerCommunicator: NSObject, Communicator {
  var online: Bool = false
  
  var myPeer: MCPeerID!
  var displayName = UserDefaults.standard.string(forKey: "profileName") ?? "User name"
  var serviceBrowser: MCNearbyServiceBrowser!
  var advertiser: MCNearbyServiceAdvertiser!
  weak var delegate: CommunicatorDelegate?
  var activeSessions: [String: MCSession] = [:] // Dictionary of active sessions
  
  override init() {
    // Setting up my peer ID:
    myPeer = MCPeerID(displayName: displayName)
    // Setting up advertiser:
    advertiser = MCNearbyServiceAdvertiser(peer: myPeer, discoveryInfo: ["userName": displayName], serviceType: "tinkoff-chat")
    // Setting up browser:
    serviceBrowser = MCNearbyServiceBrowser(peer: myPeer, serviceType: "tinkoff-chat")
    super.init()
    // Settin up delegates:
    serviceBrowser.delegate = self
    advertiser.delegate = self
    // Let the magic begin:
    advertiser.startAdvertisingPeer()
    serviceBrowser.startBrowsingForPeers()
    
    print("Прошла инициализация соединения...")
  }

  
  func getSession(with peerID: MCPeerID) -> MCSession {
    guard activeSessions[peerID.displayName] == nil else { return activeSessions[peerID.displayName]! }
    let session = MCSession(peer: myPeer, securityIdentity: nil, encryptionPreference: .none)
    
    session.delegate = self
    activeSessions[peerID.displayName] = session
    return activeSessions[peerID.displayName]!
  }
  
  func sendMessage(string: String, to UserID: String, completionHandler: ((Bool, Error?) -> ())?) {
    guard let session = activeSessions[UserID] else {return}
    let preparedMessageToSend = ["eventType" : "TextMessage", "messageId" : generateMessageId(), "text" : string]
    guard let data = try? JSONSerialization.data(withJSONObject: preparedMessageToSend, options: .prettyPrinted) else { return }
    do {
      try session.send(data, toPeers: session.connectedPeers, with: .reliable)
      delegate?.didReceiveMessage(text: string, fromUser: myPeer.displayName, toUser: UserID)
      if let completion = completionHandler {
        completion(true, nil)
      }
    } catch let error {
      if let completion = completionHandler {
        completion(false, error)
      }
    }
  }
  
  
  // Required function for message ID:
  func generateMessageId() -> String {
    let string = "\(arc4random_uniform(UINT32_MAX))+\(Date.timeIntervalSinceReferenceDate)+\(arc4random_uniform(UINT32_MAX))".data(using: .utf8)?.base64EncodedString()
    return string!
  }
  
  
  
}