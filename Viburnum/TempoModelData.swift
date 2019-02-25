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
  ["Чак Паланик",
   "Льюис Кэролл",
   "Ю несбё",
   "Хорхе Борхес",
   "Маргаретт Маргаретт Митчел",
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

let lastMessage = [
  ["Почему ты захардкодил меня первым в списке сообщений?",
   "Если в мире все бессмысленно, что мешает выдумать какой-нибудь смысл?",
   nil,
   "Кто-то гордится каждой написанной книгой, я – любою прочтённой.",
   "На крушении цивилизации можно заработать ничуть не меньше, чем на создании ее.",
   "Самое надёжное лекарство от иллюзий – взгляд в зеркало.",
   "Есть у человека нечто такое, что не подчиняется большинству, – это его совесть.",
   "В пятьдесят лет каждый из нас имеет такое лицо, какого заслуживает...",
   nil,
   "Городские часы откуда-то прознали, что их вот-вот придут убивать."],
  
  ["Почему ты захардкодил меня первым в списке сообщений?",
   "Если в мире все бессмысленно, что мешает выдумать какой-нибудь смысл?",
   "Люди боятся того, чего не знают. И ненавидят то, чего боятся.",
   "Кто-то гордится каждой написанной книгой, я – любою прочтённой.",
   "На крушении цивилизации можно заработать ничуть не меньше, чем на создании ее.",
   "Самое надёжное лекарство от иллюзий – взгляд в зеркало.",
   "Есть у человека нечто такое, что не подчиняется большинству, – это его совесть.",
   "В пятьдесят лет каждый из нас имеет такое лицо, какого заслуживает...",
   "В Америке мечты сбываются не потому, что американцы хотят, чтобы они сбылись, а потому, что они мечтают.",
   "Городские часы откуда-то прознали, что их вот-вот придут убивать."]
]

let ifOnline = [
  [true, true, true, true, true, true, true, true, true, true],
  [false, false, false, false, false, false, false, false, false, false]
]

let ifMessageUnread = [
  [true, false, false, true, true, false, false, true, false, false],
  [true, false, false, true, false, false, true, false, false, true]
]

let stringDate = [
  ["24.02.2019 14:34",
   "23.02.2019 11:20",
   "22.02.2019 17:55",
   "20.02.2019 18:20",
   "20.02.2019 17:12",
   "13.01.2019 23:01",
   "13.01.2019 04:25",
   "12.01.2019 15:12",
   "10.01.2019 12:10",
   "09.01.2019 00:24"],
  
  ["24.02.2019 19:14",
   "20.02.2019 10:50",
   "18.02.2019 10:24",
   "17.02.2019 14:34",
   "12.02.2019 09:30",
   "09.02.2019 21:25",
   "08.02.2019 11:34",
   "06.02.2019 08:47",
   "01.02.2019 19:02",
   "22.01.2019 18:21"]
]

struct ChatMessage {
  let text: String
  let incomingMessage: Bool
}

let sampleMessages = [
  ChatMessage(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit", incomingMessage: true),
  ChatMessage(text: "Ut enim ad minim veniam", incomingMessage: false),
  ChatMessage(text: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", incomingMessage: true),
  ChatMessage(text: "Lorem ipsum!", incomingMessage: false)
]







