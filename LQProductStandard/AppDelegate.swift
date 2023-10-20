//
//  AppDelegate.swift
//  LQProductStandard
//
//  Created by qiukua on 2023/10/16.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        self.window?.rootViewController = LQProductStandardViewController()
        self.window?.makeKeyAndVisible()
        return true
    }


}

