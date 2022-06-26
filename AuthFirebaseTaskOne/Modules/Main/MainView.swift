//
//  MainViewController.swift
//  AuthFirebaseTaskOne
//
//  Created by Rotach Roman on 23.06.2022.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    //MARK: - View Elements
    lazy var androidImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "android_logo")
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    //MARK: - Live cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension MainViewController: MainViewControllerType {
    func start() {
        
    }
}

//MARK: - Setup UI
extension MainViewController {
    private func setupUI() {
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews(){
        [androidImageView].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupConstraints(){
        androidImageView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview().inset(100)
        }
    }
}


