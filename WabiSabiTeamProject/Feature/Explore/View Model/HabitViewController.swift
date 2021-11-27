//
//  HabitViewController.swift
//  WabiSabiTeamProject
//
//  Created by Giovanni Tjahyamulia on 27/11/21.
//

import UIKit

class HabitViewController: UIViewController {

    @IBOutlet weak var background: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var routineDetailsLabel: UILabel!
    
    var sectionSelected: Int!
    var indexSelected: Int!
    
    var data: SubCategories!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 34)
        routineDetailsLabel.font = UIFont.boldSystemFont(ofSize: 22)
        
        let whiteGradient = CAGradientLayer()
        whiteGradient.colors = [UIColor(red: 1, green: 1, blue: 1, alpha: 0.5).cgColor, UIColor(red: 1, green: 1, blue: 1, alpha: 0.3).cgColor]
        whiteGradient.locations = [0.0, 1.0]
        whiteGradient.borderColor = UIColor.white.cgColor
        whiteGradient.borderWidth = 2
        whiteGradient.cornerRadius = 30
        whiteGradient.frame = CGRect(x: 2, y: 0, width: self.background.frame.width - 24, height: self.background.frame.height)
        background.layer.insertSublayer(whiteGradient, at:0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sectionSelected = UserDefaults.standard.integer(forKey: "sectionHabitSelected")
        indexSelected = UserDefaults.standard.integer(forKey: "habitSelected")
        
        data = Utilities().category[sectionSelected].subcategories[indexSelected]
        
        titleLabel.text = data.habitName
        descriptionLabel.text = data.description
    }
    
    @IBAction func backtoHome(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func save(_ sender: Any) {
        
    }
}

