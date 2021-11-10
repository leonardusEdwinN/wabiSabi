//
//  QuestionNameViewController.swift
//  WabiSabiTeamProject
//
//  Created by Giovanni Tjahyamulia on 28/10/21.
//

import UIKit

class QuestionNameViewController: UIViewController {
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var borderTextField: UIView!
    @IBOutlet weak var buttonNext: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonNext.isEnabled = false
        
        // textField.returnKeyType = UIReturnKeyType.done
        textField.delegate = self
        
        self.hideKeyboardWhenTappedAround()
    }

    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(QuestionNameViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func beginEditTextField(_ sender: Any) {
        borderTextField.backgroundColor = UIColor(named: "ColorPrimary")
    }
    
    @IBAction func editTextField(_ sender: Any) {
        if textField.text?.count ?? 0 >= 3 {
            Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { timer in
                DispatchQueue.main.async { [self] in
                    var counter = progressView.progress + 0.01
                    if counter <= 0.67 {
                        progressView.progress = counter
                    }
                    else {
                        timer.invalidate()
                        
                        buttonNext.isEnabled = true
                    }
                    
                }
            }
        }
        else {
            Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { timer in
                DispatchQueue.main.async { [self] in
                    var counter = progressView.progress - 0.01
                    if counter >= 0.5 {
                        progressView.progress = counter
                    }
                    else {
                        timer.invalidate()
                        
                        buttonNext.isEnabled = false
                    }
                    
                }
            }
        }
    }
    
    @IBAction func endEditTextField(_ sender: Any) {
        borderTextField.backgroundColor = UIColor.separator
    }
    
    @IBAction func next(_ sender: Any) {
        UserDefaults.standard.set(textField.text, forKey: "name")
    }
}

extension QuestionNameViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
