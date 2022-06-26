//
//  FirebaseAuthManager.swift
//  AuthFirebaseTaskOne
//
//  Created by Rotach Roman on 22.06.2022.
//

import Foundation
import FirebaseAuth

class AuthManager {
    static let shared = AuthManager()
    
    private let auth = Auth.auth()
    
    private var verificationId: String?
    
    func startAuth(phoneNumber: String, completion: @escaping (Bool) -> ()){
        auth.settings?.isAppVerificationDisabledForTesting = true
        PhoneAuthProvider.provider().verifyPhoneNumber(
            phoneNumber, uiDelegate: nil) { [weak self] verificationId, error in
                guard let verificationId = verificationId,
                      error == nil else {
                    completion(false)
                    return
                }
                self?.verificationId = verificationId
                completion(true)
            }
    }
    
    func verifyCode(smsCode: String, completion: @escaping (_ success: Bool, _ id: String?) -> ()){
        auth.languageCode = "ru"
        auth.settings?.isAppVerificationDisabledForTesting = true
        guard let verificationId = verificationId else {
            completion(false, nil)
            return
        }
        
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationId,
            verificationCode: smsCode
        )
        
        auth.signIn(with: credential) { result, error in
            guard result != nil && error == nil else {
                completion(false, nil)
                return
            }
            completion(true, verificationId)
        }
    }
    
}
