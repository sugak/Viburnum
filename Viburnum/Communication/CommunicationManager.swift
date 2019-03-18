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
  
  var listOfBlabbers: [String : Blabber] = [:]
  
  func didFoundUser(userID: String, userName: String?) {
    // If Blabber already exsists, just making him online:
    if let newBlabber = listOfBlabbers[userID] {
      newBlabber.online = true
    } else {
      // If not adding him to the list:
      let newBlabber = Blabber(id: userID, name: userName)
      newBlabber.online = true
      listOfBlabbers[userID] = newBlabber
    }
    DispatchQueue.main.async {
      self.delegate.globalUpdate()
    }
  }
  
  func didLostUser(userID: String) {
    if let userConversation = listOfBlabbers[userID] {
      userConversation.online = false
      listOfBlabbers.removeValue(forKey: userID)
    }
    DispatchQueue.main.async {
      self.delegate.globalUpdate()
    }
  }
  
  func failedToStartBrowsingForUsers(error: Error) {
    print(#function)
  }
  
  func failedToStartAdvertisingForUsers(error: Error) {
    print(#function)
  }
  
  func didReceiveMessage(text: String, fromUser: String, toUser: String) {

    if (listOfBlabbers[fromUser] != nil) {
      listOfBlabbers[fromUser]?.message.append(text)
      listOfBlabbers[fromUser]?.messageType.append(.income)

   //   conversation.messageType.append(.income)
   //   conversation.messageDate.append(Date())
   //   conversation.hasUnreadMessages = true
    } else if (listOfBlabbers[toUser] != nil) {
        listOfBlabbers[toUser]?.message.append(text)
        listOfBlabbers[toUser]?.messageType.append(.outcome)
//      conversation.message.append(text)
//      conversation.messageType.append(.outcome)
//      conversation.messageDate.append(Date())
    }

    DispatchQueue.main.async {
      self.delegate.globalUpdate()
    }


  }
  
  
}
