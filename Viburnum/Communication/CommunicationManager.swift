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
      // If Blabber do not exist adding him to the list:
      let newBlabber = Blabber(id: userID, name: userName)
      newBlabber.online = true
      listOfBlabbers[userID] = newBlabber
    }
    DispatchQueue.main.async {
      self.delegate.globalUpdate()
    }
  }
  
  func didLostUser(userID: String) {
    if let newBlabber = listOfBlabbers[userID] {
      newBlabber.online = false
      listOfBlabbers.removeValue(forKey: userID)
    }
    DispatchQueue.main.async {
      self.delegate.globalUpdate()
    }
  }
  
  func failedToStartBrowsingForUsers(error: Error) {
    print(error.localizedDescription)
  }
  
  func failedToStartAdvertisingForUsers(error: Error) {
    print(error.localizedDescription)
  }
  
  func didReceiveMessage(text: String, fromUser: String, toUser: String) {

    // Если сообщение входящее (userID отправителя есть в списке собеседников):
    if (listOfBlabbers[fromUser] != nil) {
      listOfBlabbers[fromUser]?.message.append(text)
      listOfBlabbers[fromUser]?.messageType.append(.income)
      listOfBlabbers[fromUser]?.messageDate.append(Date())
      listOfBlabbers[fromUser]?.hasUnreadMessages = true
      
      // Если сообщение исходящее (UserID получателя есть в списке собеседников):
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
