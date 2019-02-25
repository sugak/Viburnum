//
//  ConversationListTableViewCell.swift
//  Viburnum
//
//  Created by Maksim Sugak on 22/02/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

import UIKit

class ConversationListTableViewCell: UITableViewCell, ConversationCellConfiguration {
  
  // Conform to protocol:
  var name: String? {
    didSet {
      talkerNameLabel.text = name
    }
  }
  
  var message: String? {
    didSet {
      fontUpdate()
      if message != nil {
        lastMessageLabel.text = message
      } else {
        lastMessageLabel.text = "No messages yet"
      }
    }
  }
  
  var date: Date? {
    didSet {
      // Задание со звездочкой:
      if date != nil {
        let dateFormatter = DateFormatter()
          if Calendar.current.isDateInToday(date!) {
            dateFormatter.dateFormat = "HH:mm"
          } else {
            dateFormatter.dateFormat = "dd MMM"
          }
        lastMessageDateLabel.text = dateFormatter.string(from: date!)
      } else {
        lastMessageDateLabel.text = ""
      }
    }
  }
  
  var online: Bool = false {
    didSet {
      if online {
        self.backgroundColor = #colorLiteral(red: 0.965354383, green: 0.9575526118, blue: 0.8513519168, alpha: 1)
      } else {
        self.backgroundColor = .white
      }
    }
  }
  
  var hasUnreadMessages = false {
    didSet {
      fontUpdate()
    }
  }
  
  // Function to get initials of name for avatar:
  var avatarSymbols = "" {
    didSet {
      let initials = avatarSymbols.components(separatedBy: " ").reduce("") { ($0 == "" ? "" : "\($0.first!)") + "\($1.first!)" }
      avatarLabel.text = initials
    }
  }
  
  // Function to update last message font:
  private func fontUpdate () {
    lastMessageLabel.textColor = UIColor.darkGray
    lastMessageLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
      if message == nil {
        lastMessageLabel.font = UIFont(name: "Futura", size: 14.0)
        lastMessageLabel.textColor = UIColor.darkGray
      } else {
        if hasUnreadMessages {
          lastMessageLabel.textColor = UIColor.black
          lastMessageLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .bold)
        }
      }
  }
  
  // Outlets:
  @IBOutlet var talkerNameLabel: UILabel!
  @IBOutlet var lastMessageLabel: UILabel!
  @IBOutlet var lastMessageDateLabel: UILabel!
  @IBOutlet var avatarLabel: UILabel!
  
  override func layoutSubviews() {
    super.layoutSubviews()
    // No selection for rows:
    self.selectionStyle = .none
    
    // Setting up the avatar label:
    avatarLabel.layer.cornerRadius = 25.0
    avatarLabel.clipsToBounds = true
  }
}
