//
//  UIButtonExtention.swift
//  Viburnum
//
//  Created by Maksim Sugak on 20/04/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
  func sendButtonAnimation () {
    UIView.animate(withDuration: 0.1, animations: { self.transform = CGAffineTransform(scaleX: 1.15, y: 1.15) }, completion: { _ in
      self.transform = CGAffineTransform.identity
    })
  }
  
  func changeSendButton (for state: String) {
    UIView.animate(withDuration: 0.5) {
      if state == "inactive" {
        let image = UIImage(named: "sendButtonActive")
        self.setImage(image, for: .normal)
      } else if state == "active" {
        let image = UIImage(named: "sendButtonInactive")
        self.setImage(image, for: .normal)
      }
    }
  }
}
