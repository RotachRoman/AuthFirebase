//
//  SmsTextFieldDelegate.swift
//  AuthFirebaseTaskOne
//
//  Created by Rotach Roman on 23.06.2022.
//

import Foundation

class SmsTextFieldDelegate: MaskTextFieldDelegate {
    
    init(viewController: FilledTextFieldProtocol){
        let mask: String = "### ###"
        let smsFormatter: InputMaskProtocol = SmsFormatter()
        super.init(mask: mask, formatter: smsFormatter, viewController: viewController)
    }
}
