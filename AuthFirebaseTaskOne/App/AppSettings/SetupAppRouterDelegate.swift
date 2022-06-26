//
//  SetupAppRouter.swift
//  AuthFirebaseTaskOne
//
//  Created by Rotach Roman on 22.06.2022.
//

import UIKit
import FirebaseAuth

protocol SetupAppRouterType {
    init(window: UIWindow?)
}

final class SetupAppRouter: SetupAppRouterType{
    private var window: UIWindow?
    
    required init(window: UIWindow?){
        self.window = window
        setup()
    }
    
    private func setup() {
        // может пригодиться для выхода из учетной записи
        try? Auth.auth().signOut()
        if Auth.auth().currentUser == nil {
            setupSignInViewController()
        } else {
            setupAuthViewController()
        }
    }
    
    //MARK: - SetupViewController
    private func setupSignInViewController() {
        let viewController = SignInViewController(nibName: nil, bundle: nil)
        setupViewController(viewController: viewController)
        
        let presenter = SignInPresenter(view: viewController)
        viewController.presenter = presenter
    }
    
    private func setupAuthViewController() {
        let viewController = MainViewController(nibName: nil, bundle: nil)
        setupViewController(viewController: viewController)
    }
    
    private func setupViewController(viewController: UIViewController){
        self.window?.rootViewController = UINavigationController(rootViewController: viewController)
        self.window?.makeKeyAndVisible()
    }
}
