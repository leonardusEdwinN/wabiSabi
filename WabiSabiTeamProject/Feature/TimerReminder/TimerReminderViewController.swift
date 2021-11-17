//
//  TimerReminderViewController.swift
//  WabiSabiTeamProject
//
//  Created by Edwin Niwarlangga on 16/11/21.
//

import UIKit

//timerTableViewCell
struct TimerModel {
    var timerName : String
    var timerImage : String
}


class TimerReminderViewController: UIViewController, OverlayButtonProtocol {
    func buttonSavePressed(time: String) {
        print("WAKTU PROTOCOL : \(time)")
        tableAlarmArray.append(TimerModel(timerName: time, timerImage: "alarm"))
        
        
        self.dismiss(animated: false) {
            DispatchQueue.main.async {
                
                
                // MARK: checki data
                if self.tableAlarmArray.count == 0 {
                    self.timerReminderTableView.isHidden = true
                    self.viewEmptyState.isHidden = false
                }else{
                    
                    self.timerReminderTableView.isHidden = false
                    self.viewEmptyState.isHidden = true
                }
                
                self.timerReminderTableView.reloadData()
            }
        }
    }
    
    
    
    // MARK: Navigation
    @IBOutlet weak var buttonAdd: UIButton!
    @IBOutlet weak var labelTitlePage: UILabel!
    @IBOutlet weak var buttonBack: UIButton!
    
    @IBAction func buttonBackPressed(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func buttonAddPressed(_ sender: Any) {
        let slideVC = OverlayView()
        slideVC.modalPresentationStyle = .custom
        slideVC.transitioningDelegate = self
        slideVC.delegate = self
        self.present(slideVC, animated: true, completion: nil)
    }
    
    // MARK: TableView
    @IBOutlet weak var timerReminderTableView: UITableView!
    
    // MARK: EmptyState
    @IBOutlet weak var viewEmptyState: UIView!
    @IBOutlet weak var viewCircle: UIView!
    var tableAlarmArray : [TimerModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewCircle.layer.cornerRadius = viewCircle.frame.size.width / 2
        
        if tableAlarmArray.count == 0 {
            timerReminderTableView.isHidden = true
            viewEmptyState.isHidden = false
        }else{
            
            timerReminderTableView.isHidden = false
            viewEmptyState.isHidden = true
        }
        
        registerCell()
    }
    
    
    func registerCell(){
        
        
        timerReminderTableView.register(UINib.init(nibName: "TimerTableViewCell", bundle: nil), forCellReuseIdentifier: "timerTableViewCell")
        
        timerReminderTableView.delegate = self
        timerReminderTableView.dataSource = self
    }
    
    
}

extension TimerReminderViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableAlarmArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = tableView.dequeueReusableCell(withIdentifier: "timerTableViewCell") as! TimerTableViewCell
        
        
        row.setUI(
            title: tableAlarmArray[indexPath.item].timerName,
            image: tableAlarmArray[indexPath.item].timerImage
        )
        
        return row
        
    }
    
    
}

extension TimerReminderViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}
