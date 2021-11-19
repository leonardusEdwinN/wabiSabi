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
//    @IBAction func dummyButtonPressed(_ sender: Any) {
//        performSegue(withIdentifier: "moveToAddRoutinePage", sender: self)
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
    }
    
    func registerCell(){
        
        summaryTableView.register(UINib.init(nibName: "SummaryCalendarTableViewCell", bundle: nil), forCellReuseIdentifier: "summaryCalendarTableViewCell")
        
        summaryTableView.register(UINib.init(nibName: "SummaryActivityTableViewCell", bundle: nil), forCellReuseIdentifier: "summaryActivityTableViewCell")
        summaryTableView.register(UINib.init(nibName: "SummaryActivityEmptyStateTableViewCell", bundle: nil), forCellReuseIdentifier: "summaryActivityEmptyStateTableViewCell")
        
        summaryTableView.register(UINib.init(nibName: "SummaryAwardsTableViewCell", bundle: nil), forCellReuseIdentifier: "summaryAwardsTableViewCell")
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
}


extension SummaryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.item == 0){
            //calendar
            let cell = tableView.dequeueReusableCell(withIdentifier: "summaryCalendarTableViewCell",for: indexPath) as! SummaryCalendarTableViewCell
            
            return cell
        }else if(indexPath.item == 1){
            //summary activity
            //            let cell = tableView.dequeueReusableCell(withIdentifier: "summaryActivityTableViewCell",for: indexPath) as! SummaryActivityTableViewCell
            //
            //            return cell
            
            //no state
            let cell = tableView.dequeueReusableCell(withIdentifier: "summaryActivityEmptyStateTableViewCell",for: indexPath) as! SummaryActivityEmptyStateTableViewCell
            
            return cell
        }else if(indexPath.item == 2){
            //awards
            let cell = tableView.dequeueReusableCell(withIdentifier: "summaryAwardsTableViewCell",for: indexPath) as! SummaryAwardsTableViewCell
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.item == 0){
            return 450
        }else if (indexPath.item == 1){
            return 200
        }else if (indexPath.item == 2){
            return 250
        }
        
        return 100
    }
    
    
}
