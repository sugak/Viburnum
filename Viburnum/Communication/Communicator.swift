//
//  Communicator.swift
//  Viburnum
//
//  Created by Maksim Sugak on 17/03/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

import Foundation

protocol Communicator {
  func sendMessage(string: String, to UserID: String, completionHandler: ((_ success: Bool, _ error: Error?) -> ())?)
  var delegate: CommunicatorDelegate? {get set}
  var online: Bool {get set}
}
