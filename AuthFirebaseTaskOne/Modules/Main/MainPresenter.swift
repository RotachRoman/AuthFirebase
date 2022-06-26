//
//  MainPresenter.swift
//  AuthFirebaseTaskOne
//
//  Created by Rotach Roman on 23.06.2022.
//

import Foundation

protocol MainViewControllerType: AnyObject {
}

class MainPresenter: PresenterType {
    typealias presenterViewController = MainViewControllerType
    var view: presenterViewController
    
    required init(view: presenterViewController) {
        self.view = view
    }
}
