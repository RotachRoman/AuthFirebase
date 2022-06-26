//
//  Presenter.swift
//  AuthFirebaseTaskOne
//
//  Created by Rotach Roman on 23.06.2022.
//

import UIKit

protocol PresenterBase: AnyObject {}

protocol PresenterType: PresenterBase {
    associatedtype PresenterViewController
    init(view: PresenterViewController)
}
