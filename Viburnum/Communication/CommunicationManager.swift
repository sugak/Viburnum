//
//  CommunicationManager.swift
//  Viburnum
//
//  Created by Maksim Sugak on 17/03/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class CommunicationManager: CommunicatorDelegate {
  
  static let shared = CommunicationManager() // Making singleton
  var multiPeerCommunicator: MultiPeerCommunicator!
  var delegate: ManagerDelegate! // Delegate to talk to ViewController
  
  private init() {
    self.multiPeerCommunicator = MultiPeerCommunicator()  //Setting up the instance of MultiPeerCommunicator
    self.multiPeerCommunicator.delegate = self  // Setting up the delegate
  }
  
  var conversationDictionary: [String : Blabber] = [:]
  
//  func initilize() {
//    print(#function)
//  }
  
  func didFoundUser(userID: String, userName: String?) {
    if let userConversation = conversationDictionary[userID] {
      userConversation.online = true
    } else {
      let userConversation = Blabber(id: userID, name: userName)
      userConversation.online = true
      conversationDictionary[userID] = userConversation
    }
    DispatchQueue.main.async {
      self.delegate.globalUpdate()
    }
  }
  
  func didLostUser(userID: String) {
    print(#function)
  }
  
  func failedToStartBrowsingForUsers(error: Error) {
    print(#function)
  }
  
  func failedToStartAdvertisingForUsers(error: Error) {
    print(#function)
  }
  
  func didReceiveMessage(text: String, fromUser: String, toUser: String) {
    print(#function)
  }
  
  
}
