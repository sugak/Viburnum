//
//  CoreDataStack.swift
//  Viburnum
//
//  Created by Maksim Sugak on 26/03/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack: NSObject {
  static let shared = CoreDataStack()
  
  
  // URL:
  var storeURL: URL {
    let documentUrl = FileManager.default.urls(for: .documentDirectory,
                                               in: .userDomainMask).first!
    return documentUrl.appendingPathComponent("MyStore")
  }
  
  // Managed Object:
  let dataModelName = "Viburnum"
  let dataModelExtention = "momd"
  
  lazy var managedObjectModel: NSManagedObjectModel = {
    let  modelURL = Bundle.main.url(forResource: self.dataModelName,
                                    withExtension: self.dataModelExtention)!
    return NSManagedObjectModel(contentsOf: modelURL)!
  }()
  
  // Store Coordinator:
  lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
    let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
    
    do {
      try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: self.storeURL, options: nil)
    } catch {
      assert(false, "Error adding store \(error)")
    }
    return coordinator
  }()
  
  // Contexts:
  lazy var masterContext: NSManagedObjectContext = {
    var masterContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    masterContext.persistentStoreCoordinator = self.persistentStoreCoordinator
    masterContext.mergePolicy = NSOverwriteMergePolicy
    return masterContext
  }()
  
  lazy var mainContext: NSManagedObjectContext = {
    var mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    mainContext.parent = self.masterContext
    mainContext.mergePolicy = NSOverwriteMergePolicy
    return mainContext
  }()
  
  lazy var saveContext:NSManagedObjectContext = {
    var saveContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    saveContext.parent = self.mainContext
    saveContext.mergePolicy = NSOverwriteMergePolicy
    return saveContext
  }()
  
  // Saving function:
  func performSave(in context: NSManagedObjectContext, completion: SaveHandler?) {
    if context.hasChanges {
      context.perform {
        do {
          try context.save()
        } catch {
          completion?(error)
        }
        if let parentContext = context.parent {
          self.performSave(in: parentContext, completion: completion)
        } else {
          completion?(nil)
        }
      }
    } else {
      completion?(nil)
    }
  }
  
  
  
  
}
