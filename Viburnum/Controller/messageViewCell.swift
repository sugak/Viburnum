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
  
  /*
   Notes:
   Компилятор ругается на слово text, считая его атрибутом.
   Я не стал искать решение проблемы, сосредоточившись на других задачах, коих было много :)
   Просто поменял имя переменной. Надеюсь, что заданием не предполагалось выйти из ситуации по-другому.
   По ходу задания и леции встретились еще 2 похожих момента:
   1. protocol: class был заменен в языке на protocol: AnyObject
   2. UITableViewAutomaticDimention стал UITableView.automaticDimension
   */
  
  // Confirming to protocol:
  var textMess: String? {
    didSet{
      messageText.text = textMess
    }
  }
  
  // Outlets:
  @IBOutlet var messageView: UIView! // View for bubble background
  @IBOutlet var messageText: UILabel!
}
