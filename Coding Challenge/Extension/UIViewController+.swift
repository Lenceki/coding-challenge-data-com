//
//  UIViewController+.swift
//  Coding Challenge
//
//  Created by John Lawrence Figuerres on 11/10/22.
//

import Foundation
import UIKit

extension UIViewController {
    static var typeName: String {
         
        return String(describing: self)
    }
    
    static func instantiate(storyBoardName: String = "Main", bundle: Bundle = Bundle.main) -> Self {
        let storyboard = UIStoryboard(name: storyBoardName, bundle: bundle)
        return storyboard.instantiateViewController(withIdentifier: self.typeName) as! Self
    }
    
    func showError(_ errorMessage: String) {
        
        let alert = UIAlertController(title: "Ooops", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            alert.dismiss(animated: true)
        }))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    
    }
}
