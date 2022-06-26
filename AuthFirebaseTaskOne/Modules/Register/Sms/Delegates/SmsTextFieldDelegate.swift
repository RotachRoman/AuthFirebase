//
//  SmsTextFieldDelegate.swift
//  AuthFirebaseTaskOne
//
//  Created by Rotach Roman on 23.06.2022.
//

import UIKit

class SmsTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    private let formatter: String
    private let viewController: SmsViewHiddenButtonType
    private let smsFormatter: InputMaskProtocol = SmsFormatter()
    
    init(viewController: SmsViewHiddenButtonType){
        self.viewController = viewController
        self.formatter = "### ###"
    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//
////        if let text = textField.text, !text.isEmpty {
////            AuthManager.shared.verifyCode(smsCode: text){ [weak self] success in
////                guard success else { return }
////                DispatchQueue.main.async {
////                    let vc = MainViewController()
////                    vc.modalPresentationStyle = .fullScreen
////                    self?.viewController.navigationController?.pushViewController(vc, animated: true)
////                }
////            }
////        }
////        return true
//
//
//    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = smsFormatter.format(with: formatter, text: newString) { [weak self] in
            self?.viewController.filledTextField($0)
        }
        return false
    }
}
