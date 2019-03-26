//
//  StorageManager.swift
//  Viburnum
//
//  Created by Maksim Sugak on 26/03/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class StorageManager: NSObject {
  
  // Init core data stack:
  private let coreDataStack = CoreDataStack.shared
  
  // Save function:
  func saveProfile(profile: UserProfile, completion: @escaping (Error?) -> Void) {
    let appUser = AppUser.findOrInsertAppUser(in: coreDataStack.saveContext)
    appUser?.name = profile.name
    appUser?.info = profile.description
    appUser?.image = profile.profileImage.jpegData(compressionQuality: 1.0)
    
    // For Multipeer:
    UserDefaults.standard.set(profile.name, forKey: "profileName")
    
    self.coreDataStack.performSave(context: self.coreDataStack.saveContext) { (error) in
      DispatchQueue.main.async {
        completion(error)
      }
    }
  }
  
  // Load function:
  func readProfile(completion: @escaping (UserProfile) -> ()) {
    let appUser = AppUser.findOrInsertAppUser(in: coreDataStack.saveContext)
    let profile: UserProfile
    let name = appUser?.name ?? "Пользователь \(UIDevice.current.name)"
    let description = appUser?.info ?? "Описание из новой функции"
    let image: UIImage
    
    //Image handling:
    if let imageData = appUser?.image {
      image = UIImage(data: imageData) ?? UIImage(named: "placeholder-user")!
    } else {
      image = UIImage(named: "placeholder-user")!
    }
    
    profile = UserProfile(name: name, description: description, profileImage: image)
    DispatchQueue.main.async {
      completion(profile)
    }
  }
}
