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
    
    var tableLength : Int = 8
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = UIColor.systemIndigo
    }
    
    
    func registerCell(){
        
        routineTableView.register(UINib.init(nibName: "ProductUsedTableViewCell", bundle: nil), forCellReuseIdentifier: "productUsedTableViewCell")
        
        routineTableView.register(UINib.init(nibName: "ButtonRoutinePageTableViewCell", bundle: nil), forCellReuseIdentifier: "buttonRoutineTableViewCell")
        routineTableView.register(UINib.init(nibName: "TimerReminderTableViewCell", bundle: nil), forCellReuseIdentifier: "timerReminderTableViewCell")
        
        routineTableView.register(UINib.init(nibName: "LocationReminderTableViewCell", bundle: nil), forCellReuseIdentifier: "locationReminderTableViewCell")
        
        routineTableView.delegate = self
        routineTableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveToAddProduct"{
            if let destVC = segue.destination as? AddProductViewController {
                print("Asd")
            }
        }
    }
    
}

extension AddRoutineViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableLength
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.item == tableLength - 3){
            //button
            let row = tableView.dequeueReusableCell(withIdentifier: "buttonRoutineTableViewCell") as! ButtonRoutinePageTableViewCell
            
            return row
        }else if(indexPath.item == tableLength - 2){
            //timer reminder
            let row = tableView.dequeueReusableCell(withIdentifier: "timerReminderTableViewCell") as! TimerReminderTableViewCell
            
            return row
        }else if(indexPath.item == tableLength - 1){
            //location reminder
            let row = tableView.dequeueReusableCell(withIdentifier: "locationReminderTableViewCell") as! LocationReminderTableViewCell
            
            return row
        }else{
            let row = tableView.dequeueReusableCell(withIdentifier: "productUsedTableViewCell") as! ProductUsedTableViewCell
            
            return row
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var heightForRow : CGFloat = 0
        
        if(indexPath.item == tableLength - 3){
            //button
            heightForRow = 160
        }else if(indexPath.item == tableLength - 2){
            //timer reminder
            heightForRow = 140
        }else if(indexPath.item == tableLength - 1){
            //location reminder
            heightForRow = 140
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
        
        if(indexPath.item == tableLength - 3){
            //button
            print("BUTTON ROW CLICKED")
        }else if(indexPath.item == tableLength - 2){
            //timer reminder
            print("TIME REMINDER ROW CLICKED")
        }else if(indexPath.item == tableLength - 1){
            //location reminder
            print("LOCATION REMINDER ROW CLICKED")
        }else{
            print("ADD PRODUCT ROW CLICKED")
            performSegue(withIdentifier: "moveToAddProduct", sender: self)
        }
        
        
    }
    
    
}
