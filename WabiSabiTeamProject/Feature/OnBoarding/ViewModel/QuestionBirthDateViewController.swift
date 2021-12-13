//
//  QuestionBirthDateViewController.swift
//  WabiSabiTeamProject
//
//  Created by Giovanni Tjahyamulia on 28/10/21.
//

import UIKit

class QuestionBirthDateViewController: UIViewController {
    @IBOutlet var background: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var birthdatePicker: UIDatePicker!
    @IBOutlet weak var selectedDatePickerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let calendar = Calendar(identifier: .gregorian)
        var comps = DateComponents()
        comps.year = 0
        let maxDate = calendar.date(byAdding: comps, to: Date())
        comps.year = -80
        let minDate = calendar.date(byAdding: comps, to: Date())
        birthdatePicker.maximumDate = maxDate
        birthdatePicker.minimumDate = minDate
        
        setUI()
    }
    
    func setUI() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(red: 227.0/255.0, green: 208.0/255.0, blue: 197.0/255.0, alpha: 1).cgColor, UIColor(red: 181.0/255.0, green: 171.0/255.0, blue: 223.0/255.0, alpha: 1).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at:0)
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        
        var whiteGradientBackground = CAGradientLayer()
        whiteGradientBackground.colors = [UIColor(red: 1, green: 1, blue: 1, alpha: 0.6).cgColor, UIColor(red: 1, green: 1, blue: 1, alpha: 0.2).cgColor]
        whiteGradientBackground.locations = [0.0, 1.0]
        whiteGradientBackground.cornerRadius = 8
        whiteGradientBackground.borderColor = UIColor.white.cgColor
        whiteGradientBackground.borderWidth = 2
        self.selectedDatePickerView.layer.insertSublayer(whiteGradientBackground, at:0)
        whiteGradientBackground.frame = CGRect(x: 0, y: 0, width: selectedDatePickerView.frame.width, height: selectedDatePickerView.frame.height)
    }
    
    @IBAction func back(_ sender: Any) {
        Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { timer in
            DispatchQueue.main.async { [self] in
                var counter = progressView.progress - 0.01
                if counter >= 0.83 {
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
        Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { timer in
            DispatchQueue.main.async { [self] in
                var counter = progressView.progress + 0.01
                if counter <= 1.01 {
                    progressView.progress = counter
                }
                else {
                    timer.invalidate()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        UserDefaults.standard.set(birthdatePicker.date, forKey: "birthdate")
    }
}
