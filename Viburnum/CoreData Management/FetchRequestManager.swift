//
//  FetchRequestManager.swift
//  Viburnum
//
//  Created by Maksim Sugak on 02/04/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

import Foundation
import CoreData

class FetchRequestsManager {
  static let shared = FetchRequestsManager()
  
  func fetchOnlineUsers() -> NSFetchRequest<User> {
    let request: NSFetchRequest<User> = User.fetchRequest()
    request.predicate = NSPredicate(format: "isOnline == YES")
    return request
  }
  func fetchUserWithID(id: String) -> NSFetchRequest<User> {
    let request: NSFetchRequest<User> = User.fetchRequest()
    request.predicate = NSPredicate(format: "userId == %@", id)
    return request
  }
  func fetchConversations() -> NSFetchRequest<Conversation> {
    let request: NSFetchRequest<Conversation> = Conversation.fetchRequest()
    let dateSortDescriptor = NSSortDescriptor(key: "date", ascending: false)
    let onlineSortDescriptor = NSSortDescriptor(key: "isOnline", ascending: false)
    request.sortDescriptors = [onlineSortDescriptor, dateSortDescriptor]
    return request
  }
  func fetchOnlineConversations() -> NSFetchRequest<Conversation> {
    let request: NSFetchRequest<Conversation> = Conversation.fetchRequest()
    request.predicate = NSPredicate(format: "isOnline == YES")
    return request
  }
  func fetchConversationWith(id: String) -> NSFetchRequest<Conversation> {
    let request: NSFetchRequest<Conversation> = Conversation.fetchRequest()
    request.predicate = NSPredicate(format: "conversationId == %@", id)
    return request
  }
//  func fetchMessagesFrom(conversationID: String) -> NSFetchRequest<Message> {
//    let request: NSFetchRequest<Message> = Message.fetchRequest()
//    request.predicate = NSPredicate(format: "convID == %@", conversationID)
//    let sort = NSSortDescriptor(key: "date", ascending: true)
//    request.sortDescriptors = [sort]
//    return request
//  }
}
