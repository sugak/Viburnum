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
  
  // Making singleton:
  static let shared = CommunicationManager()
  var multiPeerCommunicator: MultiPeerCommunicator!
  // Delegate to talk to ViewController:
  var delegate: ManagerDelegate!
  
  private init() {
    //Setting up the instance of MultiPeerCommunicator
    self.multiPeerCommunicator = MultiPeerCommunicator()
    // Setting up the delegate
    self.multiPeerCommunicator.delegate = self
  }
  
  // List of conversations associated with their UserIDs:
  var listOfBlabbers: [String : Blabber] = [:]
  
  func didFoundUser(userID: String, userName: String?) {
    print("User found")
    let saveContext = CoreDataStack.shared.saveContext
    saveContext.perform {
      guard let user = User.findOrInsertUser(id: userID, in: saveContext) else { return }
      let conversation = Conversation.findOrInsertConversationWith(id: userID, in: saveContext)
      user.name = userName
      //user.isOnline = true
      conversation.isOnline = true
      conversation.user = user
      CoreDataStack.shared.performSave(context: saveContext, completion: nil)
    }
    
    
//    // If Blabber already exsists, just making him online:
//    if let newBlabber = listOfBlabbers[userID] {
//      newBlabber.online = true
//    } else {
//      // If Blabber do not exist adding him to the list:
//      let newBlabber = Blabber(id: userID, name: userName)
//      newBlabber.online = true
//      listOfBlabbers[userID] = newBlabber
//    }
//    DispatchQueue.main.async {
//      self.delegate.globalUpdate()
//    }
  }
  
  func didLostUser(userID: String) {
    
    let saveContext = CoreDataStack.shared.saveContext
    saveContext.perform {
      let conversation = Conversation.findOrInsertConversationWith(id: userID, in: saveContext)
      conversation.isOnline = false
//      conversation.user?.isOnline = false
      CoreDataStack.shared.performSave(context: saveContext, completion: nil)
    }
    
//    if let newBlabber = listOfBlabbers[userID] {
//      newBlabber.online = false
//      listOfBlabbers.removeValue(forKey: userID)
//    }
//    DispatchQueue.main.async {
//      self.delegate.globalUpdate()
//    }
  }
  
  func failedToStartBrowsingForUsers(error: Error) {
    print(error.localizedDescription)
  }
  
  func failedToStartAdvertisingForUsers(error: Error) {
    print(error.localizedDescription)
  }
  
  func didReceiveMessage(text: String, fromUser: String, toUser: String) {
    // If income message (sener on the list):
    if (listOfBlabbers[fromUser] != nil) {
      listOfBlabbers[fromUser]?.message.append(text)
      listOfBlabbers[fromUser]?.messageType.append(.income)
      listOfBlabbers[fromUser]?.messageDate.append(Date())
      listOfBlabbers[fromUser]?.hasUnreadMessages = true
      
      // If outcome message (receipt on the list):
    } else if (listOfBlabbers[toUser] != nil) {
        listOfBlabbers[toUser]?.message.append(text)
        listOfBlabbers[toUser]?.messageType.append(.outcome)
        listOfBlabbers[toUser]?.messageDate.append(Date())
    }
    guard let delegate = delegate else { return }
    DispatchQueue.main.async {
      delegate.globalUpdate()
    }
  }
}
