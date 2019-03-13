//
//  dataManagement.swift
//  Viburnum
//
//  Created by Maksim Sugak on 13/03/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

import Foundation
import UIKit

// Closure handling:
typealias SaveHandler = (Error?) -> Void
typealias LoadHandler = (UserProfile) -> Void

// Protocol for save structs:
protocol dataManagementProtocol {
  func getProfile(completion: @escaping LoadHandler)
  func saveProfile(new profile: UserProfile, old: UserProfile, completion: @escaping SaveHandler)
}

enum ImageError: Error {
  case convertDataError
}

// Struct for saving user profile data:
struct UserProfile {
  var name: String
  var description: String
  var profileImage: UIImage
}





