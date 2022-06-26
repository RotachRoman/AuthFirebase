//
//  SignInTextFieldDelegate.swift
//  AuthFirebaseTaskOne
//
//  Created by Rotach Roman on 23.06.2022.
//

import UIKit

class SignInTextFieldDelegate: MaskTextFieldDelegate {
    
    init(viewController: FilledTextFieldProtocol){
        let mask: String = "+7(###)###-##-##"
        let phoneFormatter = PhoneFormatter()
        
        super.init(mask: mask, formatter: phoneFormatter, viewController: viewController)
    }
}
