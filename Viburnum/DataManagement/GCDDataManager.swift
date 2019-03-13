//
//  GCDDataManager.swift
//  Viburnum
//
//  Created by Maksim Sugak on 13/03/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

import Foundation
import UIKit

class GCDDataManager: dataManagementProtocol {
  
  // Custom queue and let helpers:
  let userInitiatedQueue = DispatchQueue(label: "com.MaksimSugak", qos: .userInitiated)
  let documentsDirectory: URL
  let url: URL
  
  init() {
    documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    url = documentsDirectory.appendingPathComponent("user_profile").appendingPathExtension("plist")
  }
  
  // Save functions:
  func saveProfileName(_ name: String) {
    UserDefaults.standard.set(name, forKey: "profileName")
  }
  func saveProfileDescription(_ description: String) {
    UserDefaults.standard.set(description, forKey: "profileDescription")
  }
  func saveProfileImage(_ image: UIImage) throws {
    guard let imageData = image.jpegData(compressionQuality: 1.0) else { throw ImageError.convertDataError }
    do {
      try imageData.write(to: url, options: .noFileProtection)
    } catch let error {
      throw error
    }
  }
  
  // Get Profile function:
  func getProfile(completion: @escaping LoadHandler){
    userInitiatedQueue.async {
      let name = UserDefaults.standard.string(forKey: "profileName") ?? "Без имени"
      let description = UserDefaults.standard.string(forKey: "profileDescription") ?? "Профиль не заполнен"
      let image: UIImage
      if let imageData =  try? Data(contentsOf: self.url), UIImage(data: imageData) != nil {
        image = UIImage(data: imageData)!
      } else {
        image = UIImage(named: "placeholder-user")!
      }
      let profile = UserProfile(name: name, description: description, profileImage: image)
      DispatchQueue.main.async {
        completion(profile)
      }
    }
  }
  
  // Save profile function:
  func saveProfile(new profile: UserProfile, old: UserProfile, completion: @escaping SaveHandler) {
    userInitiatedQueue.async {
      if profile.name != old.name {
        self.saveProfileName(profile.name)
      }
      if profile.description != old.name {
        self.saveProfileDescription(profile.description)
      }
      if profile.profileImage != old.profileImage {
        do {
          try self.saveProfileImage(profile.profileImage)
        } catch let error {
          DispatchQueue.main.async {
            completion(error)
          }
          return
        }
      }
      DispatchQueue.main.async {
        completion(nil)
      }
    }
  }
}
