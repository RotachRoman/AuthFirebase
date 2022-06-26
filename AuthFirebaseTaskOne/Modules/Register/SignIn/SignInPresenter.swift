//
//  SignInPresenter.swift
//  AuthFirebaseTaskOne
//
//  Created by Rotach Roman on 23.06.2022.
//

import Foundation
import UIKit

protocol SignInViewType: AnyObject {
    func start()
}

class SignInPresenter: PresenterType {
    typealias presenterViewController = SignInViewType
    
    weak var view: SignInViewType?
    
    required init(view: SignInViewType) {
        self.view = view
    }

    func forwardTapButton(text: String, viewController: UIViewController){
        let firebaseNumber = text.replacingOccurrences(of: "[^0-9, +]", with: "", options: .regularExpression)
        AuthManager.shared.startAuth(phoneNumber: firebaseNumber) { success in
            guard success else { return }
            DispatchQueue.main.async {
                let vc = SmsViewController()
                let smsPresenter = SmsPresenter(phoneNumber: firebaseNumber)
                vc.presenter = smsPresenter
                viewController.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
