//
//  messageViewCell.swift
//  Viburnum
//
//  Created by Maksim Sugak on 24/02/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

import UIKit

class messageViewCell: UITableViewCell, messageCellConfiguration {
  
  var textMess: String? {
    didSet{
      incomeMessageLabel.text = textMess
    }
  }
  
  @IBOutlet var incomeMessageLabel: UILabel!
  @IBOutlet var outcomeMessageLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 20.0
        self.clipsToBounds = true

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: Constants.animated)
   

        // Configure the view for the selected state
    }

}
