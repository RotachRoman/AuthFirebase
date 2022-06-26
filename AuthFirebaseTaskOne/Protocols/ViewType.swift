//
//  ViewType.swift
//  AuthFirebaseTaskOne
//
//  Created by Rotach Roman on 26.06.2022.
//

import UIKit

protocol ViewController : UIViewController {}

protocol StartViewType: ViewController {
    func start(fromViewController: UIViewController)
}
