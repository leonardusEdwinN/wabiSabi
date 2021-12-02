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
    
    let allRoutines: [Routines] = Array(PersistanceManager.shared.fetchRoutines())
    var selectedDateRoutines: [Routines]!
    
//    @IBAction func dummyButtonPressed(_ sender: Any) {
//        performSegue(withIdentifier: "moveToAddRoutinePage", sender: self)
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        let user = PersistanceManager.shared.fetchUser()
        selectedDateRoutines = filterRoutine(filterDate: Date(), routines: allRoutines)
        selectedDateRoutines = selectedDateRoutines.filter({$0.userroutine?.id == user.id})
        selectedDateRoutines = selectedDateRoutines.filter({$0.startHabit != nil })
    }
    
//    func refetchAllRoutine() {
//        routines = []
//            let user = PersistanceManager.shared.fetchUser()
//            routines = PersistanceManager.shared.fetchRoutines().filter({$0.userroutine?.id == user.id})
//            routines = routines.filter({ $0.startHabit != nil })
//        }
    
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
    
    func filterRoutine(filterDate: Date, routines: [Routines]) -> [Routines] {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        
        var date: String = df.string(from: filterDate)
        
        var filteredItems: [Routines] = []
        for i in 0..<routines.count {
            let routineDate: String = df.string(from: routines[i].routineDate ?? Date())
            if (routineDate.elementsEqual(date)) {
                filteredItems.append(routines[i])
            }
        }
        return filteredItems
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
            cell.cellDelegate = self
            return cell
        }else if(indexPath.item == 1){
            //summary activity
            //            let cell = tableView.dequeueReusableCell(withIdentifier: "summaryActivityTableViewCell",for: indexPath) as! SummaryActivityTableViewCell
            //
            //            return cell
            
            //no state
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryActivityCircularProgressTableViewCell",for: indexPath) as! SummaryActivityCircularProgressTableViewCell
            cell.setData(newData: selectedDateRoutines)
            cell.tag = 1
            if selectedDateRoutines != nil {
                cell.frame.size = CGSize(width: summaryTableView.frame.width, height: CGFloat(Int(selectedDateRoutines.count / 3) * 230))
            }
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
                return CGFloat(((1 + Int(selectedDateRoutines.count/3)) * 170) + 60)
            }
            return 230
        }
        /*
        else if (indexPath.item == 2){
            return 250
        }
        */
        
        return 100
    }
}

extension SummaryViewController : SummaryCollectionViewCellDelegate {
    func didTapAtCell(date: Date) {
        if let cell = summaryTableView.viewWithTag(1) as? SummaryActivityCircularProgressTableViewCell {
            if date <= Date() {
                cell.setData(newData: filterRoutine(filterDate: date, routines: allRoutines))
                cell.frame.size = CGSize(width: summaryTableView.frame.width, height: CGFloat(((1 + Int(selectedDateRoutines.count/3)) * 170) + 60))
            }
            else {
                cell.setData(newData: [])
                cell.frame.size = CGSize(width: summaryTableView.frame.width, height: 230)
            }
        }
    }
}

