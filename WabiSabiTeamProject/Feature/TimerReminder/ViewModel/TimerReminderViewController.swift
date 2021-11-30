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
//        tableAlarmArray.append(TimerModel(timerName: time, timerImage: "alarm"))
        PersistanceManager.shared.setReminder(reminderTime: time, routine: self.selectedRoutine)
        
            print("WAKTU PROTOCOL : \(time)")
        self.dismiss(animated: false) {
            
            self.fetchDataReminder()
            DispatchQueue.main.async {
                // MARK: checki data
                if self.reminders.count == 0 {
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
//    var tableAlarmArray : [TimerModel] = []
    var reminders : [Reminder] = []
    var selectedRoutine: Routines!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("SELECTED ROUTINE : \(selectedRoutine.name)")
        fetchDataReminder()
        
        viewCircle.layer.cornerRadius = viewCircle.frame.size.width / 2
        
        if reminders.count == 0 {
            timerReminderTableView.isHidden = true
            viewEmptyState.isHidden = false
        }else{
            
            timerReminderTableView.isHidden = false
            viewEmptyState.isHidden = true
        }
        
        registerCell()
    }
    
    func fetchDataReminder(){
        self.reminders = PersistanceManager.shared.fetchReminder(routine: selectedRoutine)
        print("SELF REMINDER TIME : \(self.reminders)")
    }
    
    
    func registerCell(){
        
        
        timerReminderTableView.register(UINib.init(nibName: "TimerTableViewCell", bundle: nil), forCellReuseIdentifier: "timerTableViewCell")
        
        timerReminderTableView.delegate = self
        timerReminderTableView.dataSource = self
    }
    
    
}

extension TimerReminderViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = tableView.dequeueReusableCell(withIdentifier: "timerTableViewCell") as! TimerTableViewCell
        
        if let time = reminders[indexPath.item].reminderTime{
            row.labelAlarm.text = "\(time)"
        }
//        row.setUI(
//            title: ,
//            image: reminders[indexPath.item].timerImage
//        )
        
        return row
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        // Delete Action action
        let delete = UIContextualAction(style: .normal,
                                         title: " ") { [weak self] (action, view, completionHandler) in
        
            if let deletedRemindner = self?.reminders[indexPath.row]{
                //update data status
                PersistanceManager.shared.deleteReminder(reminder: deletedRemindner)
            }
            
            print("DELETE DATA UHUY")
            self?.fetchDataReminder()
            
            self?.timerReminderTableView.reloadData()
            completionHandler(true)
        }
        
        delete.image = UIImage(named: "deleteIcon")?.withTintColor(.white)
        delete.backgroundColor = .red
        
        
        let configuration = UISwipeActionsConfiguration(actions: [delete])

        return configuration
    }
    
    
}

extension TimerReminderViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}
