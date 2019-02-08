//
//  ViewController.swift
//  Viburnum
//
//  Created by Maksim Sugak on 07/02/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  // MARK: - showLogForView()
    func showLogForView (caller: String  = #function) {
        #if SHOWLOGS
        print("\n \n View is loaded into memory with: \(caller)")
        #endif
    }

    override func viewDidLoad() {
      super.viewDidLoad()
      showLogForView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(true)
      showLogForView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(true)
      showLogForView()
    }
    
    override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()
      showLogForView()
    }
    
    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      showLogForView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(true)
      showLogForView()
    }
}

