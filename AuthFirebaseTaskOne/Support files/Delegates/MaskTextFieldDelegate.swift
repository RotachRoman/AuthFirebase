//
//  MaskTextFieldDelegate.swift
//  AuthFirebaseTaskOne
//
//  Created by Rotach Roman on 25.06.2022.
//

import UIKit

protocol FilledTextFieldProtocol {
    //функция для обработки смены состояний заполненности textField
    func filledTextField(_ filled: Bool)
}

class MaskTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    private let mask: String
    private let formatter: InputMaskProtocol
    private let viewController: FilledTextFieldProtocol
    
    init(mask: String, formatter: InputMaskProtocol, viewController: FilledTextFieldProtocol){
        self.mask = mask
        self.formatter = formatter
        self.viewController = viewController
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        createFormatter(textField, shouldChangeCharactersIn: range, replacementString: string)
        return false
    }
    
    private func createFormatter(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) {
        guard let text = textField.text else { return }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = formatter.format(with: mask, text: newString) { [weak self] in
            self?.viewController.filledTextField($0)
        }
    }
}
