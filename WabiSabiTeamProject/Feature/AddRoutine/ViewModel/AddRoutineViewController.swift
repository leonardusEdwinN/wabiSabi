//
//  AddRoutineViewController.swift
//  WabiSabiTeamProject
//
//  Created by Edwin Niwarlangga on 11/11/21.
//

import Foundation
import UIKit

//productUsedTableViewCell
//locationReminderTableViewCell
//timerReminderTableViewCell
//buttonRoutineTableViewCell

class AddRoutineViewController : UIViewController{
    @IBOutlet weak var routineTableView: UITableView!
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    @IBOutlet weak var backButton: UIButton!
    var tableLength : Int = 7
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        registerCell()
//        self.navigationController?.navigationBar.prefersLargeTitles = true
//        self.navigationController?.navigationBar.backgroundColor = UIColor.systemIndigo
    }
    
    
    func registerCell(){
        
        routineTableView.register(UINib.init(nibName: "ProductUsedTableViewCell", bundle: nil), forCellReuseIdentifier: "productUsedTableViewCell")
        
        routineTableView.register(UINib.init(nibName: "ButtonRoutinePageTableViewCell", bundle: nil), forCellReuseIdentifier: "buttonRoutineTableViewCell")
        routineTableView.register(UINib.init(nibName: "TimerReminderTableViewCell", bundle: nil), forCellReuseIdentifier: "timerReminderTableViewCell")
        
        routineTableView.register(UINib.init(nibName: "LocationReminderTableViewCell", bundle: nil), forCellReuseIdentifier: "locationReminderTableViewCell")
        
        routineTableView.register(UINib.init(nibName: "SaveButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "saveButtonTableViewCell")
        
        
        
        routineTableView.delegate = self
        routineTableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveToAddProduct"{
            
            guard let nav = segue.destination as? UINavigationController else {
                fatalError("NavigationController not found")
            }
            
            guard let AddProductVC = nav.topViewController as? AddProductViewController else {
                fatalError("AddProductViewController not found")
            }
        }else if segue.identifier == "moveToTimeReminder"{
            
            guard let nav = segue.destination as? UINavigationController else {
                fatalError("NavigationController not found")
            }
            
            guard let TimerReminderVC = nav.topViewController as? TimerReminderViewController else {
                fatalError("TimerReminderViewController not found")
            }
        }else if segue.identifier == "moveToLocationReminder"{
            
            guard let nav = segue.destination as? UINavigationController else {
                fatalError("NavigationController not found")
            }
            
            guard let AddProductVC = nav.topViewController as? LocationReminderViewController else {
                fatalError("LocationReminderViewController not found")
            }
        }
    }
    
}

extension AddRoutineViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableLength
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.item == tableLength - 4){
            //button
            let row = tableView.dequeueReusableCell(withIdentifier: "buttonRoutineTableViewCell") as! ButtonRoutinePageTableViewCell
            
            row.delegate = self
            return row
        }else if(indexPath.item == tableLength - 3){
            //timer reminder
            let row = tableView.dequeueReusableCell(withIdentifier: "timerReminderTableViewCell") as! TimerReminderTableViewCell
            
            return row
        }else if(indexPath.item == tableLength - 2){
            //location reminder
            let row = tableView.dequeueReusableCell(withIdentifier: "locationReminderTableViewCell") as! LocationReminderTableViewCell
            
            return row
        }else if(indexPath.item == tableLength - 1){
            //save button
            let row = tableView.dequeueReusableCell(withIdentifier: "saveButtonTableViewCell") as! SaveButtonTableViewCell
            
            row.delegate = self
            return row
        }else{
            let row = tableView.dequeueReusableCell(withIdentifier: "productUsedTableViewCell") as! ProductUsedTableViewCell
            
            return row
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var heightForRow : CGFloat = 0
        
        if(indexPath.item == tableLength - 4){
            //button
            heightForRow = 160
        }else if(indexPath.item == tableLength - 3){
            //timer reminder
            heightForRow = 140
        }else if(indexPath.item == tableLength - 2){
            //location reminder
            heightForRow = 140
        }else if(indexPath.item == tableLength - 1){
            //save button
            heightForRow = 50
        }else{
            heightForRow = 125
        }
        
        return heightForRow
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let verticalPadding: CGFloat = 10

        let maskLayer = CALayer()
        maskLayer.cornerRadius = 10    //if you want round edges
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
        cell.layer.mask = maskLayer
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(indexPath.item == tableLength - 4){
            //button
            print("BUTTON ROW CLICKED")
        }else if(indexPath.item == tableLength - 3){
            //timer reminder
            print("TIME REMINDER ROW CLICKED")
            performSegue(withIdentifier: "moveToTimeReminder", sender: self)
        }else if(indexPath.item == tableLength - 2){
            //location reminder
            print("LOCATION REMINDER ROW CLICKED")
            performSegue(withIdentifier: "moveToLocationReminder", sender: self)
        }else if(indexPath.item == tableLength - 1){
            //Save Button
//            performSegue(withIdentifier: "moveToLocationReminder", sender: self)
        }else{
            print("ADD PRODUCT ROW CLICKED")
            performSegue(withIdentifier: "moveToAddProduct", sender: self)
        }
        
        
    }
    
    
}


extension AddRoutineViewController : AddRoutineDelegate{
    func addRoutineDidSave() {
        self.dismiss(animated: false, completion: nil)
    }
}
extension AddRoutineViewController : AddProductDelegate{
    func addNewProduct() {
        self.performSegue(withIdentifier: "moveToAddProduct", sender: self)
    }
}
