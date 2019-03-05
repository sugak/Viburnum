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
      
      // Setting current theme color to the view background:
      guard let currentTheme = UserDefaults.standard.colorForKey(key: "currentTheme") else {return}
      self.view.backgroundColor = currentTheme
    }
  
  func applyTheme(with color: UIColor) {
    self.view.backgroundColor = color
    UINavigationBar.appearance().barTintColor = color
    UserDefaults.standard.setColor(value: color, forKey: "currentTheme")
    
    let windows = UIApplication.shared.windows
    for window in windows {
      for view in window.subviews {
        view.removeFromSuperview()
        window.addSubview(view)
      }
    }
    themeProtocol?(color)
  }
  
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
  
  @IBAction func closeButtonTap(_sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }
  
}

extension UserDefaults {
  func setColor(value: UIColor?, forKey: String) {
    guard let value = value else {
      set(nil, forKey:  forKey)
      return
    }
    set(NSKeyedArchiver.archivedData(withRootObject: value), forKey: forKey)
  }
  func colorForKey(key:String) -> UIColor? {
    guard let data = data(forKey: key), let color = NSKeyedUnarchiver.unarchiveObject(with: data) as? UIColor
      else { return nil }
    return color
  }
}
