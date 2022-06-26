//
//  SceneDelegate.swift
//  AuthFirebaseTaskOne
//
//  Created by Rotach Roman on 22.06.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let _: SetupAppRouterType = SetupAppRouter(window: window)
    }
}

