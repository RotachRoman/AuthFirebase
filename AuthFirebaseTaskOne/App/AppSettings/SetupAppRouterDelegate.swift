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
    func getAppRouter() -> AppRouterType?
}

final class SetupAppRouter: SetupAppRouterType{
    private var window: UIWindow?
    private var appRouter: AppRouterType?
    
    required init(window: UIWindow?){
        self.window = window
        setup()
    }
    
    func getAppRouter() -> AppRouterType? {
        return appRouter
    }
    
    private func setup() {
        var appViewController: UIViewController
        var presenter: PresenterBase
        
        try? Auth.auth().signOut()
        
        if Auth.auth().currentUser == nil {
            (appViewController, presenter) = setupSignInViewController()
//            presenter =
        } else {
            (appViewController, presenter) = setupAuthViewController()
            
        }
        self.appRouter = AppRouter(appViewController: appViewController, presenter: presenter)
        self.appRouter?.startApplication()
    }
    
    //MARK: - SetupViewController
    private func setupSignInViewController() -> (UIViewController, PresenterBase) {
        let viewController = SignInViewController(nibName: nil, bundle: nil)
        setupViewController(viewController: viewController)
        
        let presenter = SignInPresenter(view: viewController as SignInViewType)
        viewController.presenter = presenter
        
        return (viewController, presenter)
    }
    
    private func setupAuthViewController() -> (UIViewController, PresenterBase) {
        let viewController = MainViewController(nibName: nil, bundle: nil)
        setupViewController(viewController: viewController)
        
        let presenter = MainPresenter(view: viewController as MainViewControllerType)
        
        return (viewController, presenter)
    }
    
    private func setupViewController(viewController: UIViewController){
        self.window?.rootViewController = UINavigationController(rootViewController: viewController)
        self.window?.makeKeyAndVisible()
    }
}
