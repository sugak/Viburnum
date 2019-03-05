//
//  ProfileViewController.swift
//  Viburnum
//
//  Created by Maksim Sugak on 14/02/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    
    // Layout for UI elements
    photoImageViewStyle(for: photoImageView)
    buttonGeneralStyle(for: editButtonOutlet)
  }
  
  // Outlets:
  @IBOutlet var photoImageView: UIImageView!
  @IBOutlet var editButtonOutlet: UIButton!
  
  // Actions:
  @IBAction func dismissButton(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  @IBAction func pushPhotoButton(_ sender: PhotoButton) {
    sender.buttonAnimation() // Making short button animation
    choosePhoto() // Opening ActionSheet menu
  }
  
  // Styling Edit button:
  func buttonGeneralStyle (for button: UIButton) {
    button.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    button.layer.borderWidth = 1.0
    button.layer.cornerRadius = 8
    button.clipsToBounds = true
  }
  
  // Styling photo image view:
  func photoImageViewStyle (for image: UIImageView) {
    image.layer.cornerRadius = Constants.cornerRadius
    image.clipsToBounds = true
  }
  
  // Photo uploading from Gallery or Camera
  func choosePhoto() {
    let choosePhotoMenu  = UIAlertController(title: nil, message: "Откуда взять фото?", preferredStyle: .actionSheet)
    let cancelButton  = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
    let galleryButton = actionForPhotoPickUp(title: "Выбрать из галереи", sourceType: .photoLibrary)
    let cameraButton = actionForPhotoPickUp(title: "Сделать снимок", sourceType: .camera)
    
    // Adding buttons on action sheet:
    choosePhotoMenu.addAction(cancelButton)
    choosePhotoMenu.addAction(galleryButton)
    choosePhotoMenu.addAction(cameraButton)
    
    // Showing action sheet:
    present(choosePhotoMenu, animated: Constants.animated, completion: nil)
  }
  
  // Function for action buttons to pick uo photo from Gallery or Camera
  func actionForPhotoPickUp (title: String, sourceType: UIImagePickerController.SourceType) -> UIAlertAction {
    return UIAlertAction(title: title, style: .default, handler: { [weak self] (action) in
      if UIImagePickerController.isSourceTypeAvailable(sourceType) {
        let imagePicker  = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        
        self?.present(imagePicker, animated: Constants.animated, completion: nil)
        imagePicker.delegate = self // Using self delegate
      } else {
        // Camera and Gallery error handler:
        let photoFailedAlert = UIAlertController(title: "Ошибка", message: (sourceType == .camera) ? "На вашем смартфоне не работает камера или она не доступна" : "На вашем смартфоне не доступна галерея", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        photoFailedAlert.addAction(okButton)
        self?.present(photoFailedAlert,animated: Constants.animated, completion: nil)
      }
    })
  }
  
  // imagePickerController delegate:
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let selectedImage  = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
      photoImageView.image = selectedImage // Loading photo into ImageView
      photoImageView.contentMode = .scaleAspectFill //Saving ratio
    }
    dismiss(animated: Constants.animated, completion: nil)
  }
}
