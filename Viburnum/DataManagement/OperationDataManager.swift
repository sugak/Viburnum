//
//  OperationDataManager.swift
//  Viburnum
//
//  Created by Maksim Sugak on 13/03/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

import Foundation
import UIKit

class OperationDataManager: dataManagementProtocol {
  var documentsDirectory: URL
  var url: URL
  let operationQueue = OperationQueue()
  
  init() {
    operationQueue.qualityOfService = .userInitiated
    operationQueue.maxConcurrentOperationCount = 1
    documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    url = documentsDirectory.appendingPathComponent("user_profile").appendingPathExtension("plist")
  }
  
  // Save profile func:
  func saveProfile(new profile: UserProfile, old: UserProfile, completion: @escaping SaveHandler) {
    let saveOperation = SaveProfileOperation()
    saveOperation.archiveURL = url
    saveOperation.completionHandler = completion
    saveOperation.newProfile = profile
    saveOperation.oldProfile = old
    operationQueue.addOperation(saveOperation)
  }
  
  // Get profile func:
  func getProfile(completion: @escaping LoadHandler) {
    let loadOperation = ProfileLoadingOperation()
    loadOperation.archiveURL = url
    loadOperation.completionHandler = completion
    operationQueue.addOperation(loadOperation)
  }
}

class ProfileLoadingOperation: Operation {
  var profile: UserProfile!
  var archiveURL: URL!
  var completionHandler: LoadHandler!
  
  override func main() {
    let name = UserDefaults.standard.string(forKey: "profileName") ?? "Без имени"
    let description = UserDefaults.standard.string(forKey: "profileDescription") ?? "Профиль не заполнен"
    let image: UIImage
    if let imageData =  try? Data(contentsOf: archiveURL), UIImage(data: imageData) != nil {
      image = UIImage(data: imageData)!
    } else {
      image = UIImage(named: "placeholder-user")!
    }
    profile = UserProfile(name: name, description: description, profileImage: image)
    OperationQueue.main.addOperation { self.completionHandler(self.profile) }
  }
}

class SaveProfileOperation: Operation {
  var newProfile: UserProfile!
  var oldProfile: UserProfile!
  var completionHandler: SaveHandler!
  var archiveURL: URL!
  
  override func main() {
    if newProfile.name != oldProfile.name {
      UserDefaults.standard.set(newProfile.name, forKey: "profileName")
    }
    if newProfile.description != oldProfile.name {
      UserDefaults.standard.set(newProfile.description, forKey: "profileDescription")
    }
    if newProfile.profileImage.jpegData(compressionQuality: 1.0) != oldProfile.profileImage.jpegData(compressionQuality: 1.0) {
      guard let imageData = newProfile.profileImage.jpegData(compressionQuality: 1.0) else {
        OperationQueue.main.addOperation {
          self.completionHandler(ImageError.convertDataError)
        }
        return
      }
      do {
        try imageData.write(to: archiveURL, options: .noFileProtection)
      } catch let error {
        self.completionHandler(error)
      }
    }
    OperationQueue.main.addOperation {
      self.completionHandler(nil)
    }
  }
}
