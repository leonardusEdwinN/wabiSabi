//
//  QuestionNameViewController.swift
//  WabiSabiTeamProject
//
//  Created by Giovanni Tjahyamulia on 28/10/21.
//

import UIKit

class QuestionNameViewController: UIViewController {
    @IBOutlet var background: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var textFieldBackground: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var borderTextField: UIView!
    @IBOutlet weak var buttonNext: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonNext.isEnabled = false
        
        // textField.returnKeyType = UIReturnKeyType.done
        textField.delegate = self
        
        self.hideKeyboardWhenTappedAround()
        
        setUI()
    }
    
    func setUI() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(red: 227.0/255.0, green: 208.0/255.0, blue: 197.0/255.0, alpha: 1).cgColor, UIColor(red: 181.0/255.0, green: 171.0/255.0, blue: 223.0/255.0, alpha: 1).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at:0)
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        
        textFieldBackground.transform = textFieldBackground.transform.rotated(by: CGFloat(-Double.pi / 2)) //90 degree
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
    
    @IBAction func back(_ sender: Any) {
        Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { timer in
            DispatchQueue.main.async { [self] in
                var counter = progressView.progress - 0.01
                if counter >= 0.5 {
                    progressView.progress = counter
                }
                else {
                    timer.invalidate()
                    
                    self.dismiss(animated: true, completion: nil)
                }
                
            }
        }
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
