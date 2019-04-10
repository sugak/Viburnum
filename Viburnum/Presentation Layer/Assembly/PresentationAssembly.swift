//
//  PresentationAssembly.swift
//  Viburnum
//
//  Created by Maksim Sugak on 10/04/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

import Foundation
import UIKit

protocol IPresentationAssembly {
  func navigationController() -> UINavigationController
  func conversationListViewController() -> ConversationListViewController
  func conversationViewController() -> ConversationViewController?
  func themesViewController() -> ThemesViewController?
  func profileViewController() -> ProfileViewController?
}

class PresentationAssembly: IPresentationAssembly {
  
  private let serviceAssembly: IServicesAssembly
  
  init(serviceAssembly: IServicesAssembly) {
    self.serviceAssembly = serviceAssembly
  }
  
  func navigationController() -> UINavigationController {
    return UINavigationController()
  }
  
  func conversationListViewController() -> ConversationListViewController {
    return ConversationListViewController()
  }
  
  func conversationViewController() -> ConversationViewController? {
    return ConversationViewController()
  }
  
  func themesViewController() -> ThemesViewController? {
    return ThemesViewController()
  }
  
  func profileViewController() -> ProfileViewController? {
    return ProfileViewController()
  }
}
