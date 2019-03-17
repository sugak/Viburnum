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
  func sendMessage(string: String, to UserID: String, completionHandler: ((Bool, Error?) -> ())?) {
    print(#function)
  }
  
  var online: Bool = false
  
  var myPeer: MCPeerID!
  var displayName = UIDevice.current.name //UserDefaults.standard.string(forKey: "profileName") ?? "User name"
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
  
  
  // Required function for message ID:
  func generateMessageId() -> String {
    let string = "\(arc4random_uniform(UINT32_MAX))+\(Date.timeIntervalSinceReferenceDate)+\(arc4random_uniform(UINT32_MAX))".data(using: .utf8)?.base64EncodedString()
    return string!
  }
  
  
  
}
