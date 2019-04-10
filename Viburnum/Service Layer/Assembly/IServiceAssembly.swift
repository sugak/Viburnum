//
//  IServiceAssembly.swift
//  Viburnum
//
//  Created by Maksim Sugak on 10/04/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol IServicesAssembly {
  // CoreData service
  // Communication service
  // Themes service
}

class ServicesAssembly: IServicesAssembly {
  
  private let coreAssembly: ICoreAssembly
  
  init(coreAssembly: ICoreAssembly) {
    self.coreAssembly = coreAssembly
  }
}
