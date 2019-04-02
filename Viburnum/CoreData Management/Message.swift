//
//  Message.swift
//  Viburnum
//
//  Created by Maksim Sugak on 02/04/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

import Foundation
import CoreData

extension Message {
  static func insertNewMessage(in context: NSManagedObjectContext) -> Message {
    guard let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as? Message else {
      fatalError("Unable to create message entry")
    }
    return message
  }
  static func findMessagesFrom(conversationId: String, in context: NSManagedObjectContext) -> [Message]? {
    let request = FetchRequestManager.shared.fetchMessagesFrom(conversationID: conversationId)
    do {
      let messages = try context.fetch(request)
      return messages
    } catch {
      assertionFailure("Unable to fetch messages")
      return nil
    }
  }
}
