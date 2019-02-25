//
//  messageViewCell.swift
//  Viburnum
//
//  Created by Maksim Sugak on 24/02/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

import UIKit

class messageViewCell: UITableViewCell, messageCellConfiguration {
  
  override func layoutSubviews() {
    super .layoutSubviews()
    //Styling chat bubbles:
    self.selectionStyle = .none 
    messageView.layer.cornerRadius = 12.0
    messageView.clipsToBounds = true
  }
  
  // Confirming to protocol:
  var textMess: String? {
    didSet{
      messageText.text = textMess
    }
  }
  
  // Outlets:
  @IBOutlet var messageView: UIView! // View as bubble background
  @IBOutlet var messageText: UILabel!
}
