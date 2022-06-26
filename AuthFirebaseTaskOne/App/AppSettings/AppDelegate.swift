//
//  AppDelegate.swift
//  AuthFirebaseTaskOne
//
//  Created by Rotach Roman on 22.06.2022.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        if #available(iOS 13.0, *) {
        } else {
            window = UIWindow(frame: UIScreen.main.bounds)
            let _: SetupAppRouterType = SetupAppRouter(window: window)
        }
        return true
    }
}

