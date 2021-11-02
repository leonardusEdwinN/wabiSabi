//
//  QuestionNameViewController.swift
//  WabiSabiTeamProject
//
//  Created by Giovanni Tjahyamulia on 28/10/21.
//

import UIKit

class QuestionNameViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var borderTextField: UIView!
    @IBOutlet weak var buttonNext: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonNext.isHidden = true
    }

    @IBAction func beginEditTextField(_ sender: Any) {
        borderTextField.backgroundColor = UIColor(named: "ColorPrimary")
    }
    
    @IBAction func editTextField(_ sender: Any) {
        if textField.text?.count ?? 0 >= 3 {
            buttonNext.isHidden = false
        }
        else {
            buttonNext.isHidden = true
        }
    }
    
    @IBAction func endEditTextField(_ sender: Any) {
        borderTextField.backgroundColor = UIColor.separator
    }
    
    @IBAction func next(_ sender: Any) {
        UserDefaults.standard.set(textField.text, forKey: "name")
    }
}
