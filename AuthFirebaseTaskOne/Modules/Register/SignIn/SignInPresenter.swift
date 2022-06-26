//
//  SignInPresenter.swift
//  AuthFirebaseTaskOne
//
//  Created by Rotach Roman on 23.06.2022.
//

import Foundation


class SignInPresenter {
    typealias PresenterViewController = StartViewType
    
    weak var view: PresenterViewController?
    
    required init(view: PresenterViewController) {
        self.view = view
    }
    
    //MARK: - Buttons
    //Обработка функционала по нажатию на кнопку
    func forwardTapButton(phone: String, viewController: ViewController){
        // удаление скобок и пробелов из номера телефона
        let firebasePhone = phone.replacingOccurrences(of: "[^0-9, +]", with: "", options: .regularExpression)
        //проверка на существование зарегестрированного номера
        AuthManager.shared.startAuth(phoneNumber: firebasePhone) { [unowned self] success in
            guard success else { return }
            forwardViewController(phone: firebasePhone, viewController: viewController)
        }
    }
    
    //    MARK: - Supporting func
    private func forwardViewController(phone: String, viewController: ViewController){
        DispatchQueue.main.async {
            let vc = SmsViewController()
            let smsPresenter = SmsPresenter(view: vc, phoneNumber: phone)
            
            vc.presenter = smsPresenter
            viewController.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
   
