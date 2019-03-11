//
//  ProfileViewController.swift
//  Viburnum
//
//  Created by Maksim Sugak on 14/02/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate{
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // TEMPO Model:
    nameTextField.text = "Maksim Sugak"
    descriptionTextView.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit "
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    
    // Layout for UI elements
    photoImageViewStyle(for: photoImageView)
    
    nameTextField.text = UserDefaults.standard.string(forKey: "profileName")
    descriptionTextView.text = UserDefaults.standard.string(forKey: "profileDescription")
    
    if UserDefaults.standard.string(forKey: "profileName") == nil {
    nameTextField.placeholder = "Введите сюда свое имя"
    descriptionTextView.text = "Напишите кратко о себе"
    }
  }
  
  // Outlets:
  @IBOutlet var photoImageView: UIImageView!
  @IBOutlet var editButtonOutlet: UIProfileButton!
  @IBOutlet var gcdButton: UIProfileButton!
  @IBOutlet var operationButton: UIProfileButton!
  @IBOutlet var nameTextField: UITextField! {
    didSet {
     // nameTextField.becomeFirstResponder()
      nameTextField.delegate = self
    }
  }
  @IBOutlet var descriptionTextView: UITextView! {
    didSet {
      descriptionTextView.delegate = self
    }
  }
  
  // Actions:
  @IBAction func dismissButton(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  @IBAction func pushPhotoButton(_ sender: PhotoButton) {
    sender.buttonAnimation() // Making short button animation
    choosePhoto() // Opening ActionSheet menu
  }
  
  @IBAction func pushEditButton(_ sender: PhotoButton) {
    editButtonOutlet.isHidden = true
    gcdButton.isHidden = false
    operationButton.isHidden = false
    
    nameTextField.isEnabled = true
    descriptionTextView.isEditable = true
  }
  @IBAction func pushGCDButton(_sender: UIProfileButton) {
    // TODO: GCD action
    UserDefaults.standard.set(nameTextField.text, forKey: "profileName")
    UserDefaults.standard.set(descriptionTextView.text, forKey: "profileDescription")
  }
  @IBAction func pushOperationButton(_ sender: PhotoButton) {
    // TODO: Operation action
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
  
  // Changing text
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  

  // Hide keyboard on textView Return tap:
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    if text == "\n"
    {
      textView.resignFirstResponder()
      return true
    }
    return true
  }
  
  

  
  
//  Пофиксить:
//  клавиатура налетает на текст


}
