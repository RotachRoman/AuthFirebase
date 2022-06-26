//
//  DigtReplacement.swift
//  AuthFirebaseTaskOne
//
//  Created by Rotach Roman on 24.06.2022.
//

import Foundation

protocol DigtReplacementProtocol {
    func replacement(text: String, withMask mask: String, completionFilled: @escaping (Bool)->()) -> String
}

class DigtReplacement {
    private var filled: Bool = false
}

extension DigtReplacement: DigtReplacementProtocol {
    func replacement(text: String, withMask mask: String, completionFilled: @escaping (Bool)->()) -> String {
        filledText(text: text, mask: mask, completionFilled: completionFilled)
        
        var result = ""
        var index = text.startIndex // количество иттераций

        for ch in mask where index < text.endIndex {
            if ch == "#" {
                result.append(text[index])
                index = text.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    private func filledText(text: String, mask: String, completionFilled: @escaping (Bool)->()){
        // для исключения бессмысленного вызова completionFilled, было решено создать переменную hiddenButton
        let mask = mask.replacingOccurrences(of: "[^#]", with: "", options: .regularExpression)
        if text.count >= mask.count {
            completionFilled(true)
            self.filled = true
        } else if filled {
            completionFilled(false)
            self.filled = false
        }
    }
}
