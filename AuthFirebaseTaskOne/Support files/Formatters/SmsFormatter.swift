//
//  SmsFormatter.swift
//  AuthFirebaseTaskOne
//
//  Created by Rotach Roman on 24.06.2022.
//

import Foundation


class SmsFormatter {
    private var hiddenButton = false
    private var digtReplacement: DigtReplacementProtocol = DigtReplacement()
}

extension SmsFormatter: InputMaskProtocol {
    func format(with mask: String, text: String, completionFilled: @escaping (Bool) -> ()) -> String {
        
        let numbers = text.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        return digtReplacement.replacement(text: numbers, withMask: mask, completionFilled: completionFilled)
    }
    
    
}
