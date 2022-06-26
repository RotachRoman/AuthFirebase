//
//  SmsViewController.swift
//  AuthFirebaseTaskOne
//
//  Created by Rotach Roman on 23.06.2022.
//

import UIKit
import SnapKit

class SmsViewController: UIViewController {
    //MARK: - Properties
    var delegateTextField: SmsTextFieldDelegate!
    var presenter: SmsPresenter!
    
    //MARK: - View Elements
    lazy var verifiredTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Код подтверждения XXX XXX"
        
        textField.delegate = delegateTextField
        textField.returnKeyType = .continue
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    lazy var forwardButton: ForwardButton = {
        let button = ForwardButton()
        button.setTitle("Продолжить", for: .normal)
        button.addTarget(self, action: #selector(forwardTapButton), for: .touchUpInside)
        return button
    }()
    
    lazy var repeatSmsButton: ForwardButton = {
        let button = ForwardButton()
        button.isHidden = false
        button.setTitle("Повторить отправку SMS", for: .normal)
        button.addTarget(self, action: #selector(repeatSmsTap), for: .touchUpInside)
        return button
    }()
    
    lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - Live cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        delegateTextField = SmsTextFieldDelegate(viewController: self)
        setupUI()
    }
}

//MARK: - StartViewType
extension SmsViewController: StartViewType {
    func start(fromViewController viewController: UIViewController) {
        viewController.navigationController?.pushViewController(self, animated: true)
    }
}

//MARK: - FilledTextFieldProtocol
extension SmsViewController: FilledTextFieldProtocol {
    //функция для обработки смены состояний заполненности textField
    func filledTextField(_ filled: Bool) {
        forwardButton.isHidden = !filled
    }
}

//MARK: - Function Buttons
extension SmsViewController {
    @objc
    func forwardTapButton(sender: UIButton!) {
        guard let text = verifiredTextField.text else { return }
        presenter.forwardTapButton(text: text, viewController: self)
    }
    
    @objc
    func repeatSmsTap(sender: UIButton!){
        presenter.sendRepeatSmsButton(view: self)
    }
}

//MARK: - SmsTimerView
extension SmsViewController: SmsTimerView {
    func timerWork(_ work: Bool) {
        self.timerLabel.isHidden = !work
        self.repeatSmsButton.isEnabled = !work
         
        if work {
            self.repeatSmsButton.backgroundColor = .lightGray
        } else {
            self.repeatSmsButton.backgroundColor = UIColor(red: 0, green: 0.686, blue: 1, alpha: 1)
        }
    }
    
    func changeTimerLabel(with text: String) {
        timerLabel.isHidden = false
        timerLabel.text = text
    }
}

//MARK: - Setup UI
extension SmsViewController {
    private func setupUI() {
        view.backgroundColor = .white
        setupNavigationTitle()

        setupSubviews()
        setupConstraints()
    }
    
    private func setupNavigationTitle(){
        self.navigationItem.title = "Ввод SMS-кода"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupSubviews(){
        [timerLabel, verifiredTextField, forwardButton, repeatSmsButton].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupConstraints(){
        verifiredTextField.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(12)
        }
        
        timerLabel.snp.makeConstraints { make in
            make.centerX.leading.trailing.equalToSuperview()
            make.bottom.equalTo(verifiredTextField).inset(100)
        }
        
        repeatSmsButton.snp.makeConstraints { make in
            make.top.equalTo(verifiredTextField).offset(50)
            make.leading.trailing.equalToSuperview().inset(32)
            make.height.equalTo(40)
        }
        
        forwardButton.snp.makeConstraints { make in
            make.top.equalTo(repeatSmsButton).inset(50)
            make.leading.trailing.equalToSuperview().inset(32)
            make.height.equalTo(40)
        }
    }
}
