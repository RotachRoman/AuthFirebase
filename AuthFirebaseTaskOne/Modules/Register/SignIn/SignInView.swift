//
//  SignInView.swift
//  AuthFirebaseTaskOne
//
//  Created by Rotach Roman on 23.06.2022.
//

import UIKit
import SnapKit

class SignInViewController: UIViewController {
    
    //MARK: - Properties
    var delegateTextField: SignInTextFieldDelegate!
    var presenter: SignInPresenter!
    
    //MARK: - View Elements
    lazy var phoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Номер телефона +7(xxx)xxx-xx-xx"
        
        textField.delegate = delegateTextField
        textField.returnKeyType = .continue
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    lazy var forwardButton: ForwardButton = {
        let button = ForwardButton()
        button.setTitle("Получить код", for: .normal)
        button.addTarget(self, action: #selector(forwardTapButton), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Live cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegateTextField = SignInTextFieldDelegate(viewController: self)
        
        setupUI()
    }
}

//MARK: - SignInViewType
extension SignInViewController: StartViewType {
    func start(fromViewController: UIViewController) {
        
    }
}

//MARK: - ViewHiddenButtonType
extension SignInViewController: FilledTextFieldProtocol {
    //функция для обработки смены состояний заполненности textField
    func filledTextField(_ filled: Bool) {
        forwardButton.isHidden = !filled
    }
}

//MARK: - Buttons
extension SignInViewController {
    @objc func forwardTapButton(sender: UIButton!) {
        guard let text = phoneTextField.text else { return }
        presenter.forwardTapButton(phone: text, viewController: self)
    }
}

//MARK: - Setup UI
extension SignInViewController {
    private func setupUI() {
        view.backgroundColor = .white
        setupNavigationTitle()
        
        setupSubviews()
        setupConstraints()
    }
    
    private func setupNavigationTitle(){
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Регистрация"
    }
    
    private func setupSubviews(){
        [phoneTextField, forwardButton].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupConstraints(){
        phoneTextField.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(12)
        }
        
        forwardButton.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField).offset(50)
            make.leading.trailing.equalToSuperview().inset(32)
            make.height.equalTo(40)
        }
    }
}


