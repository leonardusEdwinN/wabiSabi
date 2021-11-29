//
//  HabitViewController.swift
//  WabiSabiTeamProject
//
//  Created by Giovanni Tjahyamulia on 27/11/21.
//

import UIKit

@available(iOS 15.0, *)
class HabitViewController: UIViewController {

    @IBOutlet weak var background: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var routineDetailsLabel: UILabel!
    @IBOutlet weak var routineNameTextField: UITextField!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var productContainer: UIView!
    @IBOutlet weak var beRemindedLabel: UILabel!
    
    @IBOutlet weak var reminderContainer: UIView!
    @IBOutlet weak var buttonToday: UIButton!
    @IBOutlet weak var buttonTommorow: UIButton!
    @IBOutlet weak var buttonCustom: UIButton!
    
    @IBOutlet weak var buttonSunday: UIButton!
    @IBOutlet weak var buttonMonday: UIButton!
    @IBOutlet weak var buttonTuesday: UIButton!
    @IBOutlet weak var buttonWednesday: UIButton!
    @IBOutlet weak var buttonThursday: UIButton!
    @IBOutlet weak var buttonFriday: UIButton!
    @IBOutlet weak var buttonSaturday: UIButton!
    @IBOutlet weak var buttonEveryday: UIButton!
    
    var sectionSelected: Int!
    var indexSelected: Int!
    
    var data: SubCategories!
    
    var startHabit: Date = Date()
    
    var dayToDoHabit: [Bool] = [false, false, false, false, false, false, false]
    var isEveryday: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var tintedConfiguration: UIButton.Configuration!
    
    override func viewWillAppear(_ animated: Bool) {
        sectionSelected = UserDefaults.standard.integer(forKey: "sectionHabitSelected")
        indexSelected = UserDefaults.standard.integer(forKey: "habitSelected")
        
        if sectionSelected > 0 {
            productContainer.isHidden = true
        }
        
        if indexSelected != nil && sectionSelected != nil {
            data = Utilities().category[sectionSelected].subcategories[indexSelected]
            
            titleLabel.text = data.habitName
            descriptionLabel.text = data.description
            routineNameTextField.text = data.habitName
        }
        
        setUI()
    }
    
    func setUI() {
        tintedConfiguration = UIButton.Configuration.tinted()
        tintedConfiguration.baseForegroundColor = UIColor(named: "ColorPrimary")
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 34)
        routineDetailsLabel.font = UIFont.boldSystemFont(ofSize: 22)
        beRemindedLabel.font = UIFont.boldSystemFont(ofSize: 22)
        productLabel.font = UIFont.boldSystemFont(ofSize: 22)
        
        buttonToday.configuration = UIButton.Configuration.filled()
        buttonToday.setTitle("Today", for: .normal)
        buttonToday.setTitleColor(UIColor.white, for: .normal)
        tintedConfiguration.title = "Tommorow"
        buttonTommorow.configuration = tintedConfiguration
        tintedConfiguration.title = "Custom"
        buttonCustom.configuration = tintedConfiguration
        
        tintedConfiguration.title = "S"
        buttonSunday.configuration = tintedConfiguration
        tintedConfiguration.title = "M"
        buttonMonday.configuration = tintedConfiguration
        tintedConfiguration.title = "T"
        buttonTuesday.configuration = tintedConfiguration
        tintedConfiguration.title = "W"
        buttonWednesday.configuration = tintedConfiguration
        tintedConfiguration.title = "T"
        buttonThursday.configuration = tintedConfiguration
        tintedConfiguration.title = "F"
        buttonFriday.configuration = tintedConfiguration
        tintedConfiguration.title = "S"
        buttonSaturday.configuration = tintedConfiguration
        
        tintedConfiguration.title = "Everyday"
        buttonEveryday.configuration = tintedConfiguration
        
        let whiteGradient = CAGradientLayer()
        whiteGradient.colors = [UIColor(red: 1, green: 1, blue: 1, alpha: 0.5).cgColor, UIColor(red: 1, green: 1, blue: 1, alpha: 0.3).cgColor]
        whiteGradient.locations = [0.0, 1.0]
        whiteGradient.borderColor = UIColor.white.cgColor
        whiteGradient.borderWidth = 2
        whiteGradient.cornerRadius = 30
        whiteGradient.frame = CGRect(x: 1, y: 0, width: self.background.frame.width - 2, height: self.background.frame.height)
        background.layer.insertSublayer(whiteGradient, at:0)
    }
    
    @IBAction func backtoHome(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func save(_ sender: Any) {
        var routineName: String = routineNameTextField.text ?? data.habitName
        var schedules: [Schedule]!
        for index in 0...6 {
            if dayToDoHabit[index] {
                var temp = Schedule(context: PersistanceManager.shared.persistentContainer.viewContext)
                temp.schedule = "\(index)"
                schedules.append(temp)
            }
        }
        if schedules == nil {
            PersistanceManager.shared.setRoutine(isEveryday: isEveryday, name: routineName, startHabit: startHabit)
        }
        else {
            PersistanceManager.shared.setRoutine(isEveryday: isEveryday, startHabit: startHabit, name: routineName, schedules: schedules)
        }
    }
    
    @IBAction func startFromToday(_ sender: Any) {
        if #available(iOS 15.0, *) {
            buttonToday.configuration = UIButton.Configuration.filled()
            buttonToday.setTitleColor(UIColor.white, for: .normal)

            tintedConfiguration.title = "Tommorow"
            buttonTommorow.configuration = tintedConfiguration
            
            tintedConfiguration.title = "Custom"
            buttonCustom.configuration = tintedConfiguration
            
            startHabit = Date()
        } else {
            // Fallback on earlier versions
        }
    }
    
    @IBAction func startFromTommorow(_ sender: Any) {
        if #available(iOS 15.0, *) {
            tintedConfiguration.title = "Today"
            buttonToday.configuration = tintedConfiguration
            
            buttonTommorow.configuration = UIButton.Configuration.filled()
            buttonTommorow.setTitleColor(UIColor.white, for: .normal)
            
            tintedConfiguration.title = "Custom"
            buttonCustom.configuration = tintedConfiguration
            
            let today = Date()
            let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)
            startHabit = tomorrow ?? Date()
            
        } else {
            // Fallback on earlier versions
        }
    }
    
    @IBAction func startWithCustom(_ sender: Any) {
        if #available(iOS 15.0, *) {
            tintedConfiguration.title = "Today"
            buttonToday.configuration = tintedConfiguration
            
            tintedConfiguration.title = "Tommorow"
            buttonTommorow.configuration = tintedConfiguration
            
            buttonCustom.configuration = UIButton.Configuration.filled()
            buttonCustom.setTitleColor(UIColor.white, for: .normal)
            
            startHabit = Date()
        } else {
            // Fallback on earlier versions
        }
    }
    
    func checkDayToDoHabit(index: Int, button: UIButton) {
        if dayToDoHabit[index] {
            dayToDoHabit[index] = false
            tintedConfiguration.title = button.title(for: .normal)
            button.configuration = tintedConfiguration
            button.setTitleColor(UIColor(named: "ColorPrimary"), for: .normal)
            
            buttonEveryday.configuration = tintedConfiguration
            buttonEveryday.setTitle("Everyday", for: .normal)
            buttonEveryday.setTitleColor(UIColor(named: "ColorPrimary"), for: .normal)
        }
        else {
            dayToDoHabit[index] = true
            button.configuration = UIButton.Configuration.filled()
            button.setTitle(button.title(for: .normal), for: .normal)
            button.setTitleColor(UIColor.white, for: .normal)
            
            var temp = true
            for index in 0...6 {
                if !dayToDoHabit[index] {
                    temp = false
                    break
                }
            }
            isEveryday = false
            
            if temp {
                buttonEveryday.configuration = UIButton.Configuration.filled()
                buttonEveryday.setTitle("Everyday", for: .normal)
                buttonEveryday.setTitleColor(UIColor.white, for: .normal)
                
                isEveryday = true
            }
        }
    }
    
    @IBAction func sundayReminder(_ sender: Any) {
        checkDayToDoHabit(index: 0, button: buttonSunday)
    }
    
    @IBAction func mondayReminder(_ sender: Any) {
        checkDayToDoHabit(index: 1, button: buttonMonday)
    }
    
    @IBAction func tuesdayReminder(_ sender: Any) {
        checkDayToDoHabit(index: 2, button: buttonTuesday)
    }
    
    @IBAction func wednesdayReminder(_ sender: Any) {
        checkDayToDoHabit(index: 3, button: buttonWednesday)
    }
    
    @IBAction func thursdayReminder(_ sender: Any) {
        checkDayToDoHabit(index: 4, button: buttonThursday)
    }
    
    @IBAction func fridayReminder(_ sender: Any) {
        checkDayToDoHabit(index: 5, button: buttonFriday)
    }
    
    @IBAction func saturdayReminder(_ sender: Any) {
        checkDayToDoHabit(index: 6, button: buttonSaturday)
    }
    
    @IBAction func everydayReminder(_ sender: Any) {
        for index in 0...6 {
            dayToDoHabit[index] = true
        }
        
        isEveryday = true
        
        buttonEveryday.configuration = UIButton.Configuration.filled()
        buttonEveryday.setTitle("Everyday", for: .normal)
        buttonEveryday.setTitleColor(UIColor.white, for: .normal)
        
        buttonSunday.configuration = UIButton.Configuration.filled()
        buttonSunday.setTitle("S", for: .normal)
        buttonSunday.setTitleColor(UIColor.white, for: .normal)
        buttonMonday.configuration = UIButton.Configuration.filled()
        buttonMonday.setTitle("M", for: .normal)
        buttonMonday.setTitleColor(UIColor.white, for: .normal)
        buttonTuesday.configuration = UIButton.Configuration.filled()
        buttonTuesday.setTitle("T", for: .normal)
        buttonTuesday.setTitleColor(UIColor.white, for: .normal)
        buttonWednesday.configuration = UIButton.Configuration.filled()
        buttonWednesday.setTitle("W", for: .normal)
        buttonWednesday.setTitleColor(UIColor.white, for: .normal)
        buttonThursday.configuration = UIButton.Configuration.filled()
        buttonThursday.setTitle("T", for: .normal)
        buttonThursday.setTitleColor(UIColor.white, for: .normal)
        buttonFriday.configuration = UIButton.Configuration.filled()
        buttonFriday.setTitle("F", for: .normal)
        buttonFriday.setTitleColor(UIColor.white, for: .normal)
        buttonSaturday.configuration = UIButton.Configuration.filled()
        buttonSaturday.setTitle("S", for: .normal)
        buttonSaturday.setTitleColor(UIColor.white, for: .normal)
    }
    
    
}
