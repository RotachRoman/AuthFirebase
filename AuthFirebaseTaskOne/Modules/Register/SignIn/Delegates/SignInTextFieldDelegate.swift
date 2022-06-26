//
//  SignInTextFieldDelegate.swift
//  AuthFirebaseTaskOne
//
//  Created by Rotach Roman on 23.06.2022.
//

import UIKit
import FirebaseAuth

class SignInTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    private let formatter = "+7(###)###-##-##"
    private let viewController: SignInViewHiddenButtonType
    private let phoneFormatter: InputMaskProtocol = PhoneFormatter()
    
//     когда введен номер полностью flagEndChange = true, в обратном случае false
    private var hiddenButton: Bool!
    
    init(viewController: SignInViewHiddenButtonType){
        self.viewController = viewController
        hiddenButton = false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = phoneFormatter.format(with: formatter, text: newString) { [weak self] in
            self?.viewController.filledTextField($0)
        }
        return false
    }
}
