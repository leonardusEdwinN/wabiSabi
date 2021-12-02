//
//  Utilities.swift
//  WabiSabiTeamProject
//
//  Created by Edwin Niwarlangga on 24/11/21.
//

import Foundation
import UIKit

class Util{
//    func showAlert(){
//        let alert = UIAlertController(title: "Please fill the data properly", message: "Something missing when you add prouct.", preferredStyle: .alert)
//
//        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//
//        self.present(alert, animated: true)
//    }
    
    static func displayAlert(title: String, message: String) {

            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
            alertController.addAction(defaultAction)

            guard let viewController = UIApplication.shared.keyWindow?.rootViewController else {
                fatalError("keyWindow has no rootViewController")
                return
            }

            viewController.present(alertController, animated: true, completion: nil)
        }
}
