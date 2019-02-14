//
//  ProfileViewController.swift
//  Viburnum
//
//  Created by Maksim Sugak on 14/02/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  var animated = false  // По рекомендации преподавателя после ДЗ 1 флаг анимации вынесен в одно место

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
  
  //MARK: - Asterisk task
  func choosePhoto() {
    let choosePhotoMenu  = UIAlertController(title: nil, message: "Откуда взять фото?", preferredStyle: .actionSheet)
    
    let cancelButton  = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
    let galleryButton = UIAlertAction(title: "Выбрать из галереи", style: .default, handler: { (action) in
      if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
        let imagePicker  = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        self.present(imagePicker, animated: self.animated, completion: nil)
        imagePicker.delegate = self
      } else {
        print("Какая-то херня с галереей")
      }
      
    })
    
    let cameraButton = UIAlertAction(title: "Сделать снимок", style: .default, handler: { (action) in
      if UIImagePickerController.isSourceTypeAvailable(.camera) {
        let imagePicker  = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        
        self.present(imagePicker, animated: self.animated, completion: nil)
        imagePicker.delegate = self
      } else {
        print("Какая-то херня с камерой")
      }
      
    })
    
    choosePhotoMenu.addAction(cancelButton)
    choosePhotoMenu.addAction(galleryButton)
    choosePhotoMenu.addAction(cameraButton)
    
    present(choosePhotoMenu, animated: animated, completion: nil)
  }

 // ----------------------------------------------------------
  
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
      choosePhoto()
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }

  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let selectedImage  = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
      photoImageView.image = selectedImage
      photoImageView.contentMode = .scaleAspectFill
    }
    
    dismiss(animated: animated, completion: nil)
  }


}
