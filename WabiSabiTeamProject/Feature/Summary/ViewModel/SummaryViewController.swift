//
//  SummaryViewController.swift
//  WabiSabiTeamProject
//
//  Created by Edwin Niwarlangga on 04/11/21.
//

import Foundation
import UIKit

class SummaryViewController: UIViewController{
    @IBOutlet weak var summaryTableView: UITableView!
    
    @IBOutlet weak var dummyButton: UIButton!
    
    let allRoutines = Array(PersistanceManager.shared.fetchRoutines())
    
    var selectedDateRoutines: [Routines]!
//    @IBAction func dummyButtonPressed(_ sender: Any) {
//        performSegue(withIdentifier: "moveToAddRoutinePage", sender: self)
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
    }
    
    func registerCell(){
        
        summaryTableView.register(UINib.init(nibName: "SummaryCalendarTableViewCell", bundle: nil), forCellReuseIdentifier: "summaryCalendarTableViewCell")
        
        summaryTableView.register(UINib.init(nibName: "SummaryActivityCircularProgressTableViewCell", bundle: nil), forCellReuseIdentifier: "SummaryActivityCircularProgressTableViewCell")
        
        // summaryTableView.register(UINib.init(nibName: "SummaryActivityEmptyStateTableViewCell", bundle: nil), forCellReuseIdentifier: "summaryActivityEmptyStateTableViewCell")
        // summaryTableView.register(UINib.init(nibName: "SummaryAwardsTableViewCell", bundle: nil), forCellReuseIdentifier: "summaryAwardsTableViewCell")
        summaryTableView.delegate = self
        summaryTableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveToAddRoutinePage"{
            //for navigation navigation
//            if let destVC = segue.destination as? UINavigationController,
//               let targetController = destVC.topViewController as? AddRoutineViewController {
//                destVC.modalPresentationStyle = .fullScreen
//            }
            if let destVC = segue.destination as? AddRoutineViewController {
                destVC.modalPresentationStyle = .fullScreen
            }
        }
    }
    
    func filterRoutine(date: Date, routines: [Routines]) -> [Routines] {
        let filteredItems = routines.filter { $0.routineDate == date }
        return filteredItems
    }
    
    func filterTodayRoutine(routines: [Routines]) -> [Routines] {
        let calendar = Calendar.current
        let todayRoutine = routines.filter({calendar.isDateInToday(($0.routineDate ?? Date.yesterday) as Date)})
        return todayRoutine
    }
    
    func calculatePercentage(routines: [Routines]) -> CGFloat{
        var completedRoutine: CGFloat = 0.0
        
        if(routines != nil){
            for i in 0...routines.count {
                if routines[i] != nil {
                    if routines[i].isCompleted {
                        completedRoutine = completedRoutine + 1.0
                    }
                }
            }
        }
        return CGFloat(completedRoutine) / CGFloat(routines.count)
    }
}


extension SummaryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.item == 0){
            //calendar
            let cell = tableView.dequeueReusableCell(withIdentifier: "summaryCalendarTableViewCell",for: indexPath) as! SummaryCalendarTableViewCell
            cell.allRoutines = allRoutines
            return cell
        }else if(indexPath.item == 1){
            //summary activity
            //            let cell = tableView.dequeueReusableCell(withIdentifier: "summaryActivityTableViewCell",for: indexPath) as! SummaryActivityTableViewCell
            //
            //            return cell
            
            //no state
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryActivityCircularProgressTableViewCell",for: indexPath) as! SummaryActivityCircularProgressTableViewCell
            if selectedDateRoutines != nil {
                cell.frame.size = CGSize(width: summaryTableView.frame.width, height: CGFloat(Int(selectedDateRoutines.count / 3) * 220))
            }
            cell.data = allRoutines
            return cell
        }
        /*
        else if(indexPath.item == 2){
            //awards
            let cell = tableView.dequeueReusableCell(withIdentifier: "summaryAwardsTableViewCell",for: indexPath) as! SummaryAwardsTableViewCell
            
            return cell
        }
        */
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.item == 0){
            return 450
        }else if (indexPath.item == 1){
            if selectedDateRoutines != nil {
                return CGFloat(Int(selectedDateRoutines.count/3) * 220)
            }
            return 220
        }
        /*
        else if (indexPath.item == 2){
            return 250
        }
        */
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.item == 0) {
            
        }
    }
    
}
