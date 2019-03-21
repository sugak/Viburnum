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
    
    // Initial UI:
    initialUISettings()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    // Adding keyboard observers
    setUpObservers()
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    // Removing keyboard observers
    removeObservers()
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    
    // Layout for UI elements
    photoImageViewStyle(for: photoImageView)
  }
  
  // Variables and constants:
  var appliedDataManager: dataManagementProtocol!
  let gcdDataManager = GCDDataManager()
  var operationDataManager = OperationDataManager()
  var userProfile: UserProfile!
  // If in save progress flag:
  var dataSavingInProgress: Bool = false
  // If edit mode in progress:
  var editMode: Bool = false {
    
    // UI settings for edit nor edit mode:
    didSet {
      editButtonOutlet.isHidden = !editButtonOutlet.isHidden
      gcdButton.isHidden = !gcdButton.isHidden
      operationButton.isHidden = !operationButton.isHidden
      nameTextField.isUserInteractionEnabled = true
      nameTextField.becomeFirstResponder()  // Setting first responder for TextField
      descriptionTextView.isEditable = true
      
      if editMode {
        // Setting up save buttons in edit mode:
        gcdButton.isEnabled = false
        gcdButton.setTitleColor(UIColor.gray, for: .normal)
        operationButton.isEnabled = false
        operationButton.setTitleColor(UIColor.gray, for: .normal)
        
        photoButton.isHidden = false  // Photo button showing in edit mode
        
        nameTextField.text = userProfile.name
        descriptionTextView.text = userProfile.description
      } else {
        updateProfileInfo()
        nameTextField.isUserInteractionEnabled = false
        descriptionTextView.isEditable = false
        photoButton.isHidden = true
      }
    }
  }

  // Outlets:
  @IBOutlet var photoImageView: UIImageView!
  @IBOutlet var editButtonOutlet: UIProfileButton!
  @IBOutlet var gcdButton: UIProfileButton!
  @IBOutlet var operationButton: UIProfileButton!
  @IBOutlet var photoButton: PhotoButton!
  @IBOutlet var activityIndicator: UIActivityIndicatorView!
  @IBOutlet var nameTextField: UITextField!
  @IBOutlet var descriptionTextView: UITextView!
  
  // Special functions to check text changing of TextField and TextView:
  @IBAction func nameFieldDidChange(_ sender: Any) {
    saveButtonsControl()
  }
  func textViewDidChange(_ textView: UITextView) {
    saveButtonsControl()
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
    editMode = !editMode
  }
  
  @IBAction func pushGCDButton(_sender: UIProfileButton) {
    //GCD action
    appliedDataManager = gcdDataManager
    saveUserProfile()
    
  }
  @IBAction func pushOperationButton(_ sender: PhotoButton) {
    //Operation action
    appliedDataManager = operationDataManager
    saveUserProfile()
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
      saveButtonsControl()
    }
    dismiss(animated: Constants.animated, completion: nil)
  }
  
  // Finished with text entering:
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  // Hide keyboard on textView Return tap:
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    if string == "\n"
    {
      textField.resignFirstResponder()
      self.descriptionTextView.becomeFirstResponder()
      return true
    }
    return true
  }
  
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    if text == "\n"
    {
      textView.resignFirstResponder()
      pushGCDButton(_sender: gcdButton)
      return true
    }
    return true
  }
  
  // Main save function for save options:
  private func saveUserProfile() {
    // UI settings:
      dataSavingInProgress = true
      gcdButton.isEnabled = false
      operationButton.isEnabled = false
      activityIndicator.isHidden = false
      activityIndicator.startAnimating()
    
    let newProfile = UserProfile(name: nameTextField.text!, description: descriptionTextView.text!, profileImage: photoImageView.image!)
    
    appliedDataManager.saveProfile(new: newProfile, old: userProfile) { (error) in
      if error == nil {
        self.userProfile = newProfile
        let alert = UIAlertController(title: "Профиль успешно сохранен", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ОК", style: .default) { action in
          if self.editMode {
            self.editMode = false
          } else {
            self.updateProfileInfo()
          }
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
      } else {
        // Possible error handling:
        let alert = UIAlertController(title: "Что-то пошло не так", message: "Не удалось сохранить профиль", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ОК", style: .default, handler: nil)
        let repeatAction = UIAlertAction(title: "Еще раз", style: .default) { action in
          print(action)
          self.saveUserProfile()
        }
        alert.addAction(okAction)
        alert.addAction(repeatAction)
        self.present(alert, animated: true, completion: nil)
      }
      self.activityIndicator.stopAnimating()
      self.activityIndicator.isHidden = true
      self.gcdButton.isEnabled = true
      self.operationButton.isEnabled = true
      self.dataSavingInProgress = false
    }
  }
  
  // Func to update profile:
  private func updateProfileInfo() {
    nameTextField.text = userProfile.name
    descriptionTextView.text = userProfile.description
    photoImageView.image = userProfile.profileImage
  }
  
  // Func to load saved profile:
  private func loadUserProfile() {
    appliedDataManager = operationDataManager
    activityIndicator.startAnimating()
    gcdDataManager.getProfile { (profile) in
      self.userProfile = profile
      self.activityIndicator.stopAnimating()
      self.activityIndicator.isHidden = true
      self.updateProfileInfo()
    }
  }
  
  // Func to check if text has been changed and apply to buttons state:
  private func saveButtonsControl() {
    if (!dataSavingInProgress && (nameTextField.text != "") && ((nameTextField.text != userProfile.name) || (descriptionTextView.text != userProfile.description || (photoImageView.image! != userProfile.profileImage)))) {
      
      // Change button UI:
      gcdButton.isEnabled = true
      gcdButton.setTitleColor(UIColor.black, for: .normal)
      operationButton.isEnabled = true
      operationButton.setTitleColor(UIColor.black, for: .normal)
    } else {
      // Change button UI:
      gcdButton.isEnabled = false
      gcdButton.setTitleColor(UIColor.gray, for: .normal)
      operationButton.isEnabled = false
      operationButton.setTitleColor(UIColor.gray, for: .normal)
    }
  }
  
  // Backup func for the very initial settings:
  func initialUISettings() {
    if UserDefaults.standard.string(forKey: "profileName") != nil  {
      nameTextField.text = UserDefaults.standard.string(forKey: "profileName")
    } else {
      nameTextField.text = "Пользователь \(UIDevice.current.name)"
    }
    if UserDefaults.standard.string(forKey: "profileDescription") != nil {
      descriptionTextView.text = UserDefaults.standard.string(forKey: "profileDescription")
    } else {
      descriptionTextView.text = "Люблю программировать \n Люблю помогать другим"
    }
    
    // Profile updating:
    loadUserProfile()
    
    // Delegates:
    nameTextField.delegate = self
    descriptionTextView.delegate = self
    
    // Hiding spinner:
    activityIndicator.isHidden = true
  }
  
  // Keyboard handling stuff:
  private func setUpObservers() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(keyboardWillShow(notification:)),
                                           name: UIResponder.keyboardWillShowNotification,
                                           object: nil)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(keyboardWillHide(notification:)),
                                           name: UIResponder.keyboardWillHideNotification,
                                           object: nil)
  }
  
  private func removeObservers() {
    NotificationCenter.default.removeObserver(self,
                                              name: UIResponder.keyboardWillShowNotification,
                                              object: nil)
    NotificationCenter.default.removeObserver(self,
                                              name: UIResponder.keyboardWillHideNotification,
                                              object: nil)
  }
  
  @objc func keyboardWillShow(notification: NSNotification) {
    if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
      if self.view.frame.origin.y == 0 {
        self.view.frame.origin.y -= keyboardSize.height
      }
    }
  }
  
  @objc func keyboardWillHide(notification: NSNotification) {
    if self.view.frame.origin.y != 0 {
      self.view.frame.origin.y = 0
    }
  }
}

