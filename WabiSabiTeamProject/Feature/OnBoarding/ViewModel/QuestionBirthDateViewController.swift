//
//  QuestionBirthDateViewController.swift
//  WabiSabiTeamProject
//
//  Created by Giovanni Tjahyamulia on 28/10/21.
//

import UIKit

class QuestionBirthDateViewController: UIViewController {
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
        UserDefaults.standard.set(birthdatePicker.date, forKey: "birthdate")
        
        UserDefaults.standard.set(true, forKey: "isCompleteOnBoarding")
        
        // let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // let vc = storyboard.instantiateViewController(withIdentifier: "Main") as! ViewController
        // self.show(vc, sender: nil)
    }
}
