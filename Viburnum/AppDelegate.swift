//
//  AppDelegate.swift
//  Viburnum
//
//  Created by Maksim Sugak on 07/02/2019.
//  Copyright © 2019 Maksim Sugak. All rights reserved.
//
//// --------------------------------------------------//
////                                                   //
////                    Viburnum                       //
////    Вайбёрнум - это:                               //
////        - калина (ягода), как раз в рамках         //
////         современных тенденций нэйминга            //
////        - слово, удачно созвучное с Viber.         //
////          Очень удобно.                            //
////        - Было легко подобрать хорошую иконку      //
////                                                   //
//// --------------------------------------------------//

//     NOTES:
//     - Задание со звездочкой решено с помощью Conditional Compilation.
//       В проекте две схемы: Viburnum ShowLogs пишет в консоль, Viburnum не пишет.

//     - В схеме отключены логи системных сообщений ОС через OS_ACTIVITY_MODE = disable


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
      #if SHOWLOGS
       print("\n App moved from Not running to Foreground Inactive with: \(#function)")
      #endif
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
        #if SHOWLOGS
        print("\n App moved from Active to Inactive with: \(#function)")
        #endif
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
  
        #if SHOWLOGS
        print("\n App moved from Inactive to Background with: \(#function)")
        #endif
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
        #if SHOWLOGS
        print("\n App moved from Background to Inactive Foreground: \(#function)")
        #endif
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
       
        #if SHOWLOGS
        print("\n App moved from Inactive to Active with: \(#function)")
        #endif
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
       
        #if SHOWLOGS
        print("\n App moved from Background to Suspended with: \(#function)")
        #endif
    
    }


}

