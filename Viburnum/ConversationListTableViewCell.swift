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
      guard message != nil else {
        lastMessageLabel.font = UIFont(name: "Futura", size: 14.0)
        lastMessageLabel.text = "No messages yet"
        return
      }
      lastMessageLabel.text = message
    }
  }
  var date: Date? {
    didSet {
      let dateFormatter = DateFormatter()
      // TODO: Сделать гард на нулевую дату
      if Calendar.current.isDateInToday(date!) {
        dateFormatter.dateFormat = "HH:mm"
      } else {
        dateFormatter.dateFormat = "dd MMM"
      }
      lastMessageDateLabel.text = dateFormatter.string(from: date!)
    }
  }
  
  var online: Bool = false {
    didSet {
      if online {
        self.backgroundColor = #colorLiteral(red: 0.9488946795, green: 0.9413331151, blue: 0.8294835687, alpha: 1)
      } else {
        self.backgroundColor = .white
      }
    }
  }
  
  var hasUnreadMessages = false {
    didSet {
      if hasUnreadMessages {
      lastMessageLabel.textColor = UIColor.black
      lastMessageLabel.font = .boldSystemFont(ofSize: 16.0)
      } else {
        // TODO: // lastMessageLabel.font =  //.lightSystemFont(ofSize: 16.0)
      }
    }
  }
  
  var avatarSymbols = "" {
    didSet {
      let initials = avatarSymbols.components(separatedBy: " ").reduce("") { ($0 == "" ? "" : "\($0.first!)") + "\($1.first!)" }
      avatarLabel.text = initials
    }
  }
  
  
  
  // Outlets:
  @IBOutlet var talkerNameLabel: UILabel!
  @IBOutlet var lastMessageLabel: UILabel!
  @IBOutlet var lastMessageDateLabel: UILabel!
  @IBOutlet var avatarLabel: UILabel!
  

  override func layoutSubviews() {
    super.layoutSubviews()
    self.selectionStyle = .none
    
    avatarLabel.layer.cornerRadius = 25.0
    avatarLabel.clipsToBounds = true
   
  }

}
