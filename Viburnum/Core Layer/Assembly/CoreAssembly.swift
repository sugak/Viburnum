//
//  CoreAssembly.swift
//  Viburnum
//
//  Created by Maksim Sugak on 10/04/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

import Foundation

protocol ICoreAssembly {
  var communicator: ICommunicator { get }
  var coreDataStorage: ICoreDataStack { get }
}

class CoreAssembly: ICoreAssembly {
  var communicator: ICommunicator = MultiPeerCommunicator()
  var coreDataStorage: ICoreDataStack = CoreDataStack()
}
