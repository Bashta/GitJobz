//
//  AppDelegate.swift
//  GitJobz
//
//  Created by er on 2/28/20.
//  Copyright © 2020 b4sht4. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
   
}

// MARK: UISceneSession Lifecycle

extension AppDelegate {

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
           return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
       }
    
}
