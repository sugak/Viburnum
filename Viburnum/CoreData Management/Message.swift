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
      fatalError("Can't create Message entry")
    }
    return message
  }
  static func findMessagesFrom(conversationId: String, in context: NSManagedObjectContext) -> [Message]? {
    let request = FetchRequestsManager.shared.fetchMessagesFrom(conversationID: conversationId)
    do {
      let messages = try context.fetch(request)
      return messages
    } catch {
      assertionFailure("Can't fetch messages")
      return nil
    }
  }
}
