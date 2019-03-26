//
//  AppUser extention.swift
//  Viburnum
//
//  Created by Maksim Sugak on 26/03/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension AppUser {
  
  // Fetch request template:
  static func fetchRequest(model: NSManagedObjectModel) -> NSFetchRequest<AppUser>? {
    let templateName = "AppUser"
    
    guard let fetchRequest = model.fetchRequestTemplate(forName: templateName) as? NSFetchRequest<AppUser> else {
      assert(false, "No template")
      return nil
    }
    return fetchRequest
  }
  
  //Insert AppUser:
  static func insertAppUser(in context: NSManagedObjectContext) -> AppUser? {
    guard let appUser = NSEntityDescription.insertNewObject(forEntityName: "AppUser", into: context) as? AppUser else {return nil}
    
    appUser.name = UIDevice.current.name
    appUser.photo = UIImage(named: "placeholder-user")!.jpegData(compressionQuality: 1.0)
    appUser.info = "Это описание из метода insertAppUser"
    return appUser
    
  }
  
  //Find AppUser:
  static func findAppUser(in context: NSManagedObjectContext, completion: @escaping (AppUser?) -> Void) {
    context.perform {
      var appUser: AppUser?
      guard let model = context.persistentStoreCoordinator?.managedObjectModel else {return}
      guard let request = AppUser.fetchRequest(model: model) else {return}
      do {
        let results = try context.fetch(request)
        assert(results.count < 2, "Multiple AppUsers found!")
        if results.isEmpty {
          appUser = AppUser.insertAppUser(in: context)
        } else {
          appUser = results.first!
        }
        completion(appUser)
      } catch {
        print ("Failed to fetch AppUser:\(error)")
      }
    }

  }

  
  
  
}
