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
        lastMessageLabel.font = UIFont(name: "Futura", size: 16.0)
        lastMessageLabel.text = "No messages yet"
        return
      }
      lastMessageLabel.text = message
    }
  }
  var date: Date? {
    didSet {
      let dateFormatter = DateFormatter()
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
        self.backgroundColor = #colorLiteral(red: 1, green: 0.9478314519, blue: 0.8266604543, alpha: 1)
      } else {
        self.backgroundColor = .white
      }
    }
  }
  
  var hasUnreadMessages = false {
    didSet {
      if hasUnreadMessages {
      lastMessageLabel.font = .boldSystemFont(ofSize: 16.0)
      } else {
        // TODO: // lastMessageLabel.font =  //.lightSystemFont(ofSize: 16.0)
      }
    }
  }
  
  // Outlets:
  @IBOutlet var talkerNameLabel: UILabel!
  @IBOutlet var lastMessageLabel: UILabel!
  @IBOutlet var lastMessageDateLabel: UILabel!
  


    override func awakeFromNib() {
        super.awakeFromNib()
       self.selectionStyle = .none    // Убираем выделение при тапе
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
