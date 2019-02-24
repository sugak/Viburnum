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
    messageView.layer.cornerRadius = 12.0
    messageView.clipsToBounds = true
  }
    
  var textMess: String? {
    didSet{
      messageText.text = textMess
    }
  }
  
  
  @IBOutlet var messageView: UIView!
  @IBOutlet var messageText: UILabel!
  
}
