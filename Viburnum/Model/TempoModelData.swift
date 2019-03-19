//
//  TempoModelData.swift
//  Viburnum
//
//  Created by Maksim Sugak on 23/02/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

import Foundation

// Data storage for Communication Homework:
class Blabber: NSObject{
  var id: String
  var name: String?
  var online: Bool
  var message: [String]
  var messageDate: [Date]
  var messageType: [MessageType]
  var hasUnreadMessages: Bool
  
  init(id: String, name: String?) {
    self.id = id
    self.name = name
    self.online = false
    self.message = []
    self.messageDate = []
    self.messageType = []
    self.hasUnreadMessages = false
  }
}

//struct Message {
//  var message: String
//  var type: MessageType
//  var lastMessageDate: Date?
//}

enum MessageType {
  case income
  case outcome
}










// Sections:
let sections = ["Online","History"]

//People in chat list:
let TalkerName = [
  ["Чак Паланик",
   "Льюис Кэролл",
   "Ю Несбё",
   "Хорхе Борхес",
   "Маргаретт Митчел",
   "Олдос Хаксли",
   "Харпер Ли",
   "Джорж Оруэлл",
   "Фредерик Бегбедер",
   "Рэй Брэдбери"],
  
  ["Джеймс Джойс",
   "Фредерик Дар",
   "Чарльз Диккенс",
   "Герман Мелвилл",
   "Джейн Остин",
   "Франц Кафка",
   "Альбер Камю",
   "Виктор Гюго",
   "Джон Милтон",
   "Александр Милн"]
]

//Last messages:
let lastMessage = [
  ["Привет! Это первое сообщение.",
   "Если в мире все бессмысленно, что мешает выдумать какой-нибудь смысл?",
   nil,
   "Кто-то гордится каждой написанной книгой, я – любою прочтённой",
   "На крушении цивилизации можно заработать ничуть не меньше, чем на создании ее",
   "Самое надёжное лекарство от иллюзий – взгляд в зеркало.",
   "Есть у человека нечто такое, что не подчиняется большинству, – это его совесть.",
   "В пятьдесят лет каждый из нас имеет такое лицо, какого заслуживает...",
   nil,
   "Городские часы откуда-то прознали, что их вот-вот придут убивать"],
  
  ["Сановитый, жирный Бык Маллиган возник из лестничного проема",
   "Бывают моменты, когда злятся даже сенбернары",
   "Великие люди редко бывают чрезмерно скрупулезны в одежде",
   nil,
   "Счастье в браке — это всецело дело случая...",
   "Всё несчастье моей жизни происходит от писем или от возможности их писать",
   "Великий вопрос жизни — как жить среди людей",
   "Горе тому, кто любил тела, формы, видимость. Старайтесь любить души",
   "Именно в беде рассчитывать мы вправе на успех, нас в счастье обманувший",
   "Нельзя же чихнуть и не знать, что ты чихнул" ]
]

let ifOnline = [
  [true, true, true, true, true, true, true, true, true, true],
  [false, false, false, false, false, false, false, false, false, false]
]

let ifMessageUnread = [
  [false, false, false, true, true, false, false, true, false, false],
  [false, false, true, false, true, false, true, false, false, true]
]

var stringDate = [
  ["24.02.2019 14:40",
   "23.02.2019 11:20",
   nil,
   "20.02.2019 18:20",
   "20.02.2019 17:12",
   "13.01.2019 23:01",
   "13.01.2019 04:25",
   "12.01.2019 15:12",
   nil,
   "09.01.2019 00:24"],
  
  ["24.02.2019 19:14",
   "20.02.2019 10:50",
   "18.02.2019 10:24",
   nil,
   "12.02.2019 09:30",
   "09.02.2019 21:25",
   "08.02.2019 11:34",
   "06.02.2019 08:47",
   "01.02.2019 19:02",
   "22.01.2019 18:21"]
]

//Chat messages:
struct ChatMessage {
  let text: String
  let incomingMessage: Bool
}

let sampleMessages = [
  ChatMessage(text: "Lorem", incomingMessage: true),
  ChatMessage(text: "Ut enim ad minim veniam", incomingMessage: false),
  ChatMessage(text: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", incomingMessage: true),
  ChatMessage(text: "In voluptate velit esse cillum dolore eu fugiat nulla pariatur", incomingMessage: false),
  ChatMessage(text: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui.", incomingMessage: true),
  ChatMessage(text: "Lorem ipsum! Ut enim ad minim veniam.", incomingMessage: true),
  ChatMessage(text: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu.", incomingMessage: false)
  
]







