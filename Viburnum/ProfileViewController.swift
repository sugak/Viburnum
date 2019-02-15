//
//  ProfileViewController.swift
//  Viburnum
//
//  Created by Maksim Sugak on 14/02/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

/*
 NOTES:
 
 1. В info.plist добавлены два ключа для запроса разрешения пользователя на использование галереи и камеры для задания со звездочкой
 2. В тренировочных целях добавлена легкая анимация buttonAnimation (for button: UIButton), которая увеличивает кнопку выбора фото в полтора раза по тапу
 
 */

// TODO: Разобраться со вторым лейблом
// TODO: Убрать "какую-то херню"

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
//  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//  //  print("Init()")
//  }
//
//  required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//  }
  
  
  
  
  // По рекомендации преподавателя после ДЗ 1 флаг анимации вынесен в одно место:
  var animated = true

  // Styling edit button:
  func editButtonStyle (for button: UIButton) {
    button.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    button.layer.borderWidth = 1.0
    button.layer.cornerRadius = 8
    button.clipsToBounds = true
  }
  
  // Stying photo button:
  func photoButtonStyle (for button: UIButton) {
    button.backgroundColor = UIColor(red:0.25, green:0.47, blue:0.94, alpha:1.0)
    button.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20) // redusing camera image inside the button
    button.layer.cornerRadius = button.bounds.width / 2 // To make sure it will be circle
    button.clipsToBounds = true
  }
  
  // Stying image container:
  func photoImageViewStyle (for image: UIImageView) {
    image.layer.cornerRadius = photoButtonOutlet.bounds.width / 2 // To make sure radius is the same as photo button has
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
        imagePicker.delegate = self // Using self delegate
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
        imagePicker.delegate = self // Using self delegate
      } else {
        print("Какая-то херня с камерой")
      }
    })
    
    // Adding buttons on action sheet:
    choosePhotoMenu.addAction(cancelButton)
    choosePhotoMenu.addAction(galleryButton)
    choosePhotoMenu.addAction(cameraButton)
    
    // Showing action sheet:
    present(choosePhotoMenu, animated: animated, completion: nil)
  }

 // ----------------------------------------------------------
  
  // Button animation
  func buttonAnimation (for button: UIButton) {
    UIView.animate(withDuration: 0.1, animations: { button.transform = CGAffineTransform(scaleX: 1.5, y: 1.5) }, completion: { _ in
                    button.transform = CGAffineTransform.identity
    })
  }
  
   // Outlets:
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
  // Actions:
  @IBAction func pushPhotoButton(_ sender: UIButton) {
      buttonAnimation(for: sender)  // Starting button animation
      choosePhoto() // Opening ActionSheet menu
  }
  
  // imagePickerController delegate:
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let selectedImage  = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
      photoImageView.image = selectedImage // Loading photo into ImageView
      photoImageView.contentMode = .scaleAspectFill //Saving ratio
    }
    dismiss(animated: animated, completion: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
       print("viewDidLoad: \(editButtonOutlet.frame)")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    print("WillAppear: \(editButtonOutlet.frame)")
  }
  
  override func viewDidAppear(_ animated: Bool) {
     super.viewWillAppear(animated)
      print("viewDidAppear: \(editButtonOutlet.frame)")
    
    /*
     Методы, связанные с установкой Auto Layout, вызываются внутри viewWillAppear.
     Среди них есть  updateViewConstraints, updateConstraints и др. Соответственно, в этом месте
     обновляются Constraints, которые изначально были установлены в интерфейсе Builder-а для
     iPhone SE (или в .xib).
     А метод viewDidAppear вызывается позже, поэтому уже имеет обновленные constraints и frames.
    */
  }
}
