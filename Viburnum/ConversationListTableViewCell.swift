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
        // TODO: поменять шрифт
        lastMessageLabel.text = "No messages yet"
        return
      }
      lastMessageLabel.text = message
    }
  }
  var date: Date?
  
  var online: Bool = false {
    didSet {
      if online {
        self.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
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
