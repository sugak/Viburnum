//
//  ProfileViewController.swift
//  Viburnum
//
//  Created by Maksim Sugak on 14/02/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

  func editButtonStyle (for button: UIButton) {
    button.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    button.layer.borderWidth = 1.0
    button.layer.cornerRadius = 8
    button.clipsToBounds = true
  }
  
  func photoButtonStyle (for button: UIButton) {
    button.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    button.layer.cornerRadius = button.bounds.width / 2
    button.clipsToBounds = true
  }
  
  func photoImageViewStyle (for image: UIImageView) {
    image.layer.cornerRadius = photoButtonOutlet.bounds.width / 2
    image.clipsToBounds = true
  }

  
  @IBOutlet weak var photoImageView: UIImageView! {
    didSet {
      photoImageViewStyle(for: photoImageView)
           }
  }
  
  @IBOutlet weak var photoButtonOutlet: UIButton! {
    didSet {
      photoButtonStyle(for: photoButtonOutlet)
           }
  }
  
  @IBOutlet weak var editButtonOutlet: UIButton! {
    didSet {
           editButtonStyle(for: editButtonOutlet)
           }
  }

  @IBAction func pushPhotoButton(_ sender: UIButton) {
      print("Выбери изображение профиля")
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    


}
