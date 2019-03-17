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
  
  private init() {
    self.multiPeerCommunicator = MultiPeerCommunicator()  //Setting up the instance of MultiPeerCommunicator
    self.multiPeerCommunicator.delegate = self  // Setting up the delegate
  }
  
  var conversationDictionary: [String : Blabber] = [:]
  
  func didFoundUser(userID: String, userName: String?) {
    if let userConversation = conversationDictionary[userId] {
      userConversation.online = true
    } else {
      let userConversation = User(userID: userId, name: userName)
      userConversation.online = true
      conversationDictionary[userId] = userConversation
    }
    guard let delegate = delegate else { return }
    DispatchQueue.main.async {
      delegate.updateUserData()
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
