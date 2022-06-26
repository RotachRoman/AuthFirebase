//
//  SmsPresenter.swift
//  AuthFirebaseTaskOne
//
//  Created by Rotach Roman on 23.06.2022.
//

import UIKit
import Moya

protocol SmsViewType: AnyObject {
    func start()
}

protocol SmsTimerView: AnyObject {
    func timerWork(_ work: Bool)
    func changeTimerLabel(with text: String)
}

class SmsPresenter {
    weak var view: SmsViewType?
    private let authProvider: MoyaProvider = MoyaProvider<AuthBackendMoya>()
    
    private var phoneNumber: String!
    var timerSec = 5
    
    init(view: SmsViewType? = SmsViewController(), phoneNumber: String){
        self.view = view
        self.phoneNumber = phoneNumber
    }
    
    func start(){
        view?.start()
    }
    
    func forwardTapButton(text: String, viewController: UIViewController){
        let code = text.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        AuthManager.shared.verifyCode(smsCode: code){[unowned self] success, id  in
            guard success,
                  let id = id else { return }
            
            sendAuthIDToBack(withPhone: phoneNumber, id: id, viewController: viewController)
        }
    }
    
    func timerTapButton(view: SmsTimerView){
        let time = timerSec
        view.timerWork(true)
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {[unowned self] timer in
            if self.timerSec > 0 {
                let text = "Если вам не пришло сообщение, можете повторить попытку через \(self.timerSec) секунд"
                view.changeTimerLabel(with: text)
                self.timerSec -= 1
            } else {
                self.timerSec = time
                let text = "Если вам не пришло сообщение, можете повторить попытку через \(self.timerSec) секунд"
                view.changeTimerLabel(with: text)
                view.timerWork(false)
                timer.invalidate()
            }
        }
    }
    
    func sendRepeatSms(text: String, viewController: UIViewController){
        let firebaseNumber = text.replacingOccurrences(of: "[^0-9, +]", with: "", options: .regularExpression)
        AuthManager.shared.startAuth(phoneNumber: firebaseNumber) { _ in }
    }
    
    private func forwardViewController(viewController: UIViewController){
        DispatchQueue.main.async {
            let vc = MainViewController()
            vc.modalPresentationStyle = .fullScreen
            viewController.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


//MARK: - Network
extension SmsPresenter {
    private func sendAuthIDToBack(withPhone phone: String, id: String, viewController: UIViewController){
        authProvider.request(.checkUser(phone: phone, id: id), callbackQueue: DispatchQueue.main) { progress in
            
        } completion: {[unowned self] result in
            switch result {
            case .success:
                self.forwardViewController(viewController: viewController)
            case .failure:
//                self.presentError()
                return
            }
        }
    }
}
 
