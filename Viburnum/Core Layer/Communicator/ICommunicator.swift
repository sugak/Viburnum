//
//  ICommunicator.swift
//  Viburnum
//
//  Created by Maksim Sugak on 10/04/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

import Foundation

protocol ICommunicator {
  func sendMessage(string: String, to userID: String, completionHandler: ((_ success: Bool, _ error: Error?) -> Void)?)
  var delegate: CommunicatorDelegate? {get set}
  var online: Bool {get set}
}
