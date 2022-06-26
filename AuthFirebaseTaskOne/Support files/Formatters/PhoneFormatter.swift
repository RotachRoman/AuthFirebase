//
//  PhoneFormatter.swift
//  AuthFirebaseTaskOne
//
//  Created by Rotach Roman on 23.06.2022.
//

import UIKit

//MARK: pr: InputMaskProtocol
public protocol InputMaskProtocol {
    func format(with mask: String, text: String, completionFilled: @escaping (Bool)->()) -> String
}

class PhoneFormatter {
    private var hiddenButton = false
    private var digtReplacement: DigtReplacementProtocol = DigtReplacement()
}

//MARK: ext: InputMaskProtocol
extension PhoneFormatter: InputMaskProtocol {
    func format(with mask: String, text: String, completionFilled: @escaping (Bool)->()) -> String {
        // для удобства удаляем дефолтное начало номера при удалении
        if text == "+7(" {
            return ""
        }
        var numbers = text.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        // из-за дублирования и придуманного метода, при вводе двух подряд 7 возникает не ожидаемое ожидание
        if numbers.first == "7", numbers.count != 1 {
            numbers.removeFirst()
        }
         return digtReplacement.replacement(text: numbers, withMask: mask, completionFilled: completionFilled)
    }
    
}
