//
//  ThemesViewController.swift
//  Viburnum
//
//  Created by Maksim Sugak on 05/03/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

/*
 
 === ЧЕКЛИСТ ===
 для переключения между классами Objective-C & Swift
 
 1. Сменить Target Membership
 2. Проверить Custom Class в IB
 3. В ConversationListViewController:
 
 3.1 Для перехода в Swift:
 3.1.1 В segue "themeMenu" раскомментить блок //For Swift class usage:
 3.1.2 Там же закомментить блок // For Objective-C class usage:
 3.1.3 Закомментить extension ConversationListViewController: ThemesViewControllerDelegate в конце кода
 
 3.2 Для перехода в Obj-C:
 3.2.1 В segue "themeMenu" закомментить блок //For Swift class usage:
 3.2.2 В segue "themeMenu" раскомментить блок // For Objective-C class usage:
 3.2.3 Раскомментить extension ConversationListViewController: ThemesViewControllerDelegate в конце кода
 
 */

import UIKit

class ThemesViewController: UIViewController {
  
  let model = Themes()
  var themeProtocol: ((UIColor) -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()
      
      // Setting current theme color to the view background:
      guard let currentTheme = UserDefaults.standard.colorForKey(key: "currentTheme") else {return}
      self.view.backgroundColor = currentTheme
    }
  
  // Function for all updates on buttons tap:
  func applyTheme(with color: UIColor) {
    self.view.backgroundColor = color
    UINavigationBar.appearance().barTintColor = color
    UserDefaults.standard.setColor(value: color, forKey: "currentTheme")
    
    // All views update:
    let windows = UIApplication.shared.windows
    for window in windows {
      for view in window.subviews {
        view.removeFromSuperview()
        window.addSubview(view)
      }
    }
    themeProtocol?(color)
  }
  
  // Actions:
  @IBAction func backButton(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
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
}
