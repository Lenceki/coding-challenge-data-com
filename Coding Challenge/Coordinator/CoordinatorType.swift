//
//  CoordinatorBase.swift
//  Coding Challenge
//
//  Created by John Lawrence Figuerres on 11/10/22.
//

import Foundation
import UIKit

protocol CoordinatorType {
    var subCoordinators: [CoordinatorType] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}
