//
//  SmsPresenter.swift
//  AuthFirebaseTaskOne
//
//  Created by Rotach Roman on 23.06.2022.
//

import Moya

//MARK: - Protocols View
protocol SmsTimerView: AnyObject {
    func timerWork(_ work: Bool)
    func changeTimerLabel(with text: String)
}

class SmsPresenter {
    typealias PresenterViewController = StartViewType
    
    //MARK:  Properties
    weak var view: PresenterViewController?
    private let authProvider: MoyaProvider = MoyaProvider<AuthBackendMoya>()
    
    private var phoneNumber: String
    private var timerSec = 120

    init(view: PresenterViewController, phoneNumber: String) {
        self.view = view
        self.phoneNumber = phoneNumber
    }
    
    //    MARK: - Buttons
    func forwardTapButton(text: String, viewController: ViewController){
        let code = text.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        AuthManager.shared.verifyCode(smsCode: code) {[unowned self] success, id  in
            guard success,
                  let id = id else { return }
            //отправка идентификатора в метод авторизации checkUser
            sendAuthIDToBack(withPhone: phoneNumber, id: id, viewController: viewController)
        }
    }
    
    func sendRepeatSmsButton(view: SmsTimerView){
        // удаление скобок и пробелов из номера телефона
        let firebaseNumber = phoneNumber.replacingOccurrences(of: "[^0-9, +]", with: "", options: .regularExpression)
        // отправка повторного кода
        AuthManager.shared.startAuth(phoneNumber: firebaseNumber) { _ in }
        startTimer(view: view)
    }
    
    //    MARK: - Supporting func
    private func startTimer(view: SmsTimerView){
        let time = timerSec
        //оповещение о начале отчета времени
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
                //оповещение о завершении отчета времени
                view.timerWork(false)
                timer.invalidate()
            }
        }
    }
    
    private func forwardViewController(viewController: ViewController){
        DispatchQueue.main.async {
            let vc = MainViewController()
            vc.modalPresentationStyle = .fullScreen
            viewController.navigationController?.pushViewController(vc, animated: false)
        }
    }
}

//MARK: - Network
extension SmsPresenter {
    private func sendAuthIDToBack(withPhone phone: String, id: String, viewController: ViewController){
        authProvider.request(.checkUser(phone: phone, id: id)) { result in
            switch result {
            case .success:
                self.forwardViewController(viewController: viewController)
            case .failure:
                print(result)
                return
            }
        }
    }
}
