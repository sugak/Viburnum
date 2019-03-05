//
//  ThemesViewController.swift
//  Viburnum
//
//  Created by Maksim Sugak on 05/03/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

import UIKit

class ThemesViewController: UIViewController {
  
  let model = Themes()
  var themeProtocol: ((UIColor) -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
  func applyTheme(with color: UIColor) {
    self.view.backgroundColor = color
    UINavigationBar.appearance().barTintColor = color
    
    let windows = UIApplication.shared.windows
    for window in windows {
      for view in window.subviews {
        view.removeFromSuperview()
        window.addSubview(view)
      }
    }
    
    themeProtocol?(color)
  }
  
  

  @IBAction func themeButtonTap(_ sender: Any) {
    if let button = sender as? UIButton {
      switch button.tag {
      case 1:
        applyTheme(with: model.theme1)
        break
      case 2:
        applyTheme(with: model.theme2)
        break
      case 3:
        applyTheme(with: model.theme3)
        break
      default:
        break
      }
    }
  }
  
  @IBAction func closeButtonTap(_sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }
  
}
