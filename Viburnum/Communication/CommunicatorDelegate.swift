//
//  CommunicatorDelegate.swift
//  Viburnum
//
//  Created by Maksim Sugak on 17/03/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

import Foundation

protocol CommunicatorDelegate: class  {
  // Discovering:
  func didFoundUser(userID: String, userName: String?)
  func didLostUser(userID: String)
  
  // Errors:
  func failedToStartBrowsingForUsers(error: Error)
  func failedToStartAdvertisingForUsers(error: Error)
  
  // Messages:
  func didReceiveMessage(text: String, fromUser: String, toUser: String)
}
