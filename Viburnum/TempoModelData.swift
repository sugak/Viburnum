//
//  TempoModelData.swift
//  Viburnum
//
//  Created by Maksim Sugak on 23/02/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

import Foundation

let sections = ["Online","History"]

let TalkerName = [
  ["Taker 1", "Talker 2", "Talker 3"],
  ["Talker 4", "Talker 5", "Talker 6"]
]

let lastMessage = [
  ["Message 1", nil, "Message 3"],
  ["Message 4", nil, "Message 6"]
]

let ifOnline = [
  [true, true, true],
  [false, false, false]
]

let ifMessageUnread = [
  [true, false, false],
  [true, false, false]
]

let stringDate = [
  ["25.02.2019 14:34","23.02.2019 11:20","22.02.2019 17:55"],
  ["25.02.2019 19:14","20.02.2019 22:50","19.02.2019 12:47"]
]

struct ChatMessage {
  let text: String
  let incomingMessage: Bool
}

let sampleMessages = [
  ChatMessage(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit", incomingMessage: true),
  ChatMessage(text: "Ut enim ad minim veniam", incomingMessage: false),
  ChatMessage(text: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", incomingMessage: true),
  ChatMessage(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit! Lorem ipsum dolor sit amet. ", incomingMessage: false)
]







