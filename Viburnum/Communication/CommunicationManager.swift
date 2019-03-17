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
  func didFoundUser(userID: String, userName: String?) {
    print(#function)
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
