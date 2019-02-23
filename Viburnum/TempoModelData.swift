//
//  TempoModelData.swift
//  Viburnum
//
//  Created by Maksim Sugak on 23/02/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

import Foundation

let talkerNames = ["Taker 1", "Talker 2", "Talker 3"]

let lastMessages = ["Message 1", nil ,"Message 3"]
let datesStrings = ["2019-02-23 10:34","2019-02-23 11:15","2019-02-20 14:20"]
let ifOnline = [true, false, true]
let ifUnreadedMessage = [false, true, true]


//var messagesDates: [Date] =





extension String {
  func getMyDate() -> DateComponents {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:MM"
    let date = dateFormatter.date(from: self)
    let dateComp = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute, .second], from: date!)
    return dateComp
  }
}
