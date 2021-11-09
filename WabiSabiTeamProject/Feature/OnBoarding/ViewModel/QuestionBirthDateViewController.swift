//
//  QuestionBirthDateViewController.swift
//  WabiSabiTeamProject
//
//  Created by Giovanni Tjahyamulia on 28/10/21.
//

import UIKit

class QuestionBirthDateViewController: UIViewController {
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var birthdatePicker: UIDatePicker!
    
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
        UserDefaults.standard.set(true, forKey: "isCompleteOnBoarding")
    }
}