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

class StorageManager: NSObject, dataManagementProtocol {
  
  // Init core data stack:
  private let coreDataStack = CoreDataStack.shared
  
  func getProfile(completion: @escaping LoadHandler) {
    
    AppUser.findAppUser(in: coreDataStack.saveContext) { (appUser) in

      let profile = UserProfile(
      
      if newProfile.name != oldProfile.name {
        appUser.currentUser?.name = newProfile.name
      }
      if newProfile.description != oldProfile.description {
        appUser.userDescription = newProfile.description
      }
      if newProfile.userImage.jpegData(compressionQuality: 1.0) != oldProfile.userImage.jpegData(compressionQuality: 1.0) {
        appUser.image = newProfile.userImage.jpegData(compressionQuality: 1.0)
      }
      self.coreDataStack.performSave(in: self.coreDataStack.saveContext) { (error) in
        DispatchQueue.main.async {
          completion(error)
        }
      }
    }
    
  }
  
  func saveProfile(new profile: UserProfile, old: UserProfile, completion: @escaping LoadHandler) {
    AppUser.findAppUser(in: coreDataStack.saveContext) { (appUser) in
      let profile: UserProfile
      if let appUser = appUser {
        let name = appUser.name ?? UIDevice.current.name
        let descritption = appUser.info ?? ""
        let image: UIImage
        if let imageData = appUser.photo {
          image = UIImage(data: imageData) ?? UIImage(named: "placeholder-user")!
        } else {
          image = UIImage(named: "placeholder-user")!
        }
        profile = UserProfile(name: name, description: descritption, profileImage: image)
        DispatchQueue.main.async {
          completion(profile)
        }
      } else {
        assert(false, "AppUser is nil")
      }
    }

  }
  
  
  
}
