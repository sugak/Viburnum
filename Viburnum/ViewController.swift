//
//  ViewController.swift
//  Viburnum
//
//  Created by Maksim Sugak on 07/02/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        #if SHOWLOGS
        print("\n \n View is loaded into memory with: \(#function)")
        #endif
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        #if SHOWLOGS
        print("\n View is about to be added to a view hierarchy with: \(#function)")
        #endif
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        #if SHOWLOGS
        print("\n View was added to a view hierarchy with: \(#function) \n")
        #endif
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        #if SHOWLOGS
        print("\n View is about to layout its subviews with: \(#function)")
        #endif
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        #if SHOWLOGS
        print("\n View has just laid out its subviews with: \(#function)")
        #endif
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        #if SHOWLOGS
        print("\n View is about to be removed from a view hierarchy with: \(#function)")
        #endif
    }
    

    
    

}

