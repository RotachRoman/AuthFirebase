//
//  ForwardButton.swift
//  AuthFirebaseTaskOne
//
//  Created by Rotach Roman on 24.06.2022.
//

import UIKit

class ForwardButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isHidden = true
        self.setTitle("", for: .normal)
        self.setTitleColor(.black, for: .normal)
        
        self.backgroundColor = UIColor(red: 0, green: 0.686, blue: 1, alpha: 1)
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.filled()
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 0, bottom: 18, trailing: 0)
        } else {
            self.contentEdgeInsets = UIEdgeInsets(top: 18, left: 0, bottom: 18, right: 0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
