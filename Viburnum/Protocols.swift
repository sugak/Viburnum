//
//  Protocols.swift
//  Viburnum
//
//  Created by Maksim Sugak on 22/02/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

import Foundation

protocol ConversationCellConfiguration : AnyObject {
  var name: String? {get set}
  var message: String? {get set}
  var date: Date? {get set}
  var online: Bool {get set}
  var hasUnreadMessages: Bool {get set}
}


