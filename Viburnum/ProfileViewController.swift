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

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  print(editButtonOutlet?.frame ?? "Failed to get button frame")
    /*
    Инициализация ViewController не включает в себя работу с View. Это делается, начиная с вызова
     метода LoadView(). Поэтому на этапе инициализации VC еще ничего не знает о UI.
     */
  }
  

  // Styling edit button:
  func editButtonStyle (for button: UIButton) {
    button.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    button.layer.borderWidth = 1.0
    button.layer.cornerRadius = 8
    button.clipsToBounds = true
  }
  
  
  // Stying image container:
  func photoImageViewStyle (for image: UIImageView) {
    image.layer.cornerRadius = 40.0 //photoButtonOutlet.bounds.width / 2 // To make sure radius is the same as photo button has
    image.clipsToBounds = true
  }
  
  //MARK: - Задание со звёздочкой
  func choosePhoto() {
    let choosePhotoMenu  = UIAlertController(title: nil, message: "Откуда взять фото?", preferredStyle: .actionSheet)
    
    let cancelButton  = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
    
    let galleryButton = UIAlertAction(title: "Выбрать из галереи", style: .default, handler: { (action) in
      if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
        let imagePicker  = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        self.present(imagePicker, animated: Constants.animated, completion: nil)
        imagePicker.delegate = self // Using self delegate
      }
    })
    
    let cameraButton = UIAlertAction(title: "Сделать снимок", style: .default, handler: { (action) in
      if UIImagePickerController.isSourceTypeAvailable(.camera) {
        let imagePicker  = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        
        self.present(imagePicker, animated: Constants.animated, completion: nil)
        imagePicker.delegate = self // Using self delegate
      }
    })
    
    // Adding buttons on action sheet:
    choosePhotoMenu.addAction(cancelButton)
    choosePhotoMenu.addAction(galleryButton)
    choosePhotoMenu.addAction(cameraButton)
    
    // Showing action sheet:
    present(choosePhotoMenu, animated: Constants.animated, completion: nil)
  }
 // ----------------------------------------------------------
  
  
   // Outlets:
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var editButtonOutlet: UIButton!
  
  // Actions:
  @IBAction func pushPhotoButton(_ sender: PhotoButton) {
     // buttonAnimation(for: sender)  // Starting button animation
      sender.buttonAnimation()
      choosePhoto() // Opening ActionSheet menu
  }
  
  // imagePickerController delegate:
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let selectedImage  = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
      photoImageView.image = selectedImage // Loading photo into ImageView
      photoImageView.contentMode = .scaleAspectFill //Saving ratio
    }
    dismiss(animated: Constants.animated, completion: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
       print("viewDidLoad: \(editButtonOutlet.frame)")
  }
  
  override func viewDidAppear(_ animated: Bool) {
     super.viewWillAppear(Constants.animated)
      print("viewDidAppear: \(editButtonOutlet.frame)")
    
    /*
     Методы, связанные с установкой Auto Layout, вызываются внутри viewWillAppear.
     Среди них есть  updateViewConstraints, updateConstraints и др. Соответственно, в этом месте
     обновляются Constraints, которые изначально были установлены в интерфейсе Builder-а для
     iPhone SE (или в .xib).
     А метод viewDidAppear вызывается позже, поэтому уже имеет обновленные constraints и frames.
    */
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    
    photoImageViewStyle(for: photoImageView)
 //   photoButtonStyle(for: photoButtonOutlet)
    editButtonStyle(for: editButtonOutlet)
    
  }
}
