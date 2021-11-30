//
//  NewHabitViewController.swift
//  WabiSabiTeamProject
//
//  Created by Edwin Niwarlangga on 30/11/21.
//

import Foundation
import UIKit

//startHabitTableViewCell
//routineNameTableViewCell
//selectWeekTableViewCell
//productHeaderTableViewCell
class NewHabitViewController : UIViewController{
    
    // MARK: variable
    var arrayRoutine : [String] = ["name","start", "schedule", "headerp", "products", "reminder", "timer", "location"]
    
    // MARK: UI Component
    @IBOutlet var outerView: UIView!
    @IBOutlet var habitTableView: UITableView!
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelDetail: UILabel!
    @IBOutlet var buttonSave: UIButton!
    @IBOutlet var backButton: UIButton!
    @IBAction func backButtonPressed(_ sender: Any) {
    }
    @IBAction func buttonSavePressed(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupUI()
    }
    
    func setupUI(){
        outerView.layer.cornerRadius = 29
        outerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        outerView.layer.borderWidth = 2
        outerView.layer.borderColor = UIColor.white.cgColor
        
        hideKeyboardWhenTappedAround()
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(QuestionNameViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    func setupTableView(){
        
        habitTableView.register(UINib.init(nibName: "RoutineNameTableViewCell", bundle: nil), forCellReuseIdentifier: "routineNameTableViewCell")
        
        habitTableView.register(UINib.init(nibName: "StartHabitTableViewCell", bundle: nil), forCellReuseIdentifier: "startHabitTableViewCell")
        
        habitTableView.register(UINib.init(nibName: "SelectWeekTableViewCell", bundle: nil), forCellReuseIdentifier: "selectWeekTableViewCell")
        habitTableView.register(UINib.init(nibName: "ProductHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "productHeaderTableViewCell")
        
        
        habitTableView.register(UINib.init(nibName: "ProductUsedTableViewCell", bundle: nil), forCellReuseIdentifier: "productUsedTableViewCell")
        habitTableView.register(UINib.init(nibName: "ButtonRoutinePageTableViewCell", bundle: nil), forCellReuseIdentifier: "buttonRoutineTableViewCell")
        habitTableView.register(UINib.init(nibName: "BeRemindedTableViewCell", bundle: nil), forCellReuseIdentifier: "remindedTableViewCell")
        habitTableView.register(UINib.init(nibName: "TimerReminderTableViewCell", bundle: nil), forCellReuseIdentifier: "timerReminderTableViewCell")
        habitTableView.register(UINib.init(nibName: "LocationReminderTableViewCell", bundle: nil), forCellReuseIdentifier: "locationReminderTableViewCell")
        
        habitTableView.delegate = self
        habitTableView.dataSource = self
    }
}


extension NewHabitViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayRoutine.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var section : Int = 0
        if(arrayRoutine[section] == "products"){
            section = 5
        }else{
            section =  1
        }
        return section
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch arrayRoutine[indexPath.section] {
        case "name":
            let row = tableView.dequeueReusableCell(withIdentifier: "routineNameTableViewCell") as! RoutineNameTableViewCell
            return row
        case "start":
            
            let row = tableView.dequeueReusableCell(withIdentifier: "startHabitTableViewCell") as! StartHabitTableViewCell
            return row
        case "schedule":
            
            let row = tableView.dequeueReusableCell(withIdentifier: "selectWeekTableViewCell") as! SelectWeekTableViewCell
            return row
        case "headerp":
            let row = tableView.dequeueReusableCell(withIdentifier: "productHeaderTableViewCell") as! ProductHeaderTableViewCell
            return row
        case "products":
            let row = tableView.dequeueReusableCell(withIdentifier: "productUsedTableViewCell") as! ProductUsedTableViewCell
            return row
        case "reminder":
            
            let row = tableView.dequeueReusableCell(withIdentifier: "remindedTableViewCell") as! BeRemindedTableViewCell
            return row
        case "timer":
            
            let row = tableView.dequeueReusableCell(withIdentifier: "timerReminderTableViewCell") as! TimerReminderTableViewCell
            return row
        case "location":
            
            let row = tableView.dequeueReusableCell(withIdentifier: "locationReminderTableViewCell") as! LocationReminderTableViewCell
            return row
        default:
            return UITableViewCell();
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var heightForRow : CGFloat = 0
        
        switch arrayRoutine[indexPath.section] {
        case "name":
            heightForRow = 100
        case "start":
            heightForRow = 100
        case "schedule":
            heightForRow = 150
        case "headerp":
            heightForRow = 30
        case "products":
            heightForRow = 100
        case "reminder":
            heightForRow = 80
        case "timer":
            heightForRow = 140
        case "location":
            heightForRow = 140
        default:
            heightForRow = 0
        }
        
        return heightForRow
    }
    
    
}
