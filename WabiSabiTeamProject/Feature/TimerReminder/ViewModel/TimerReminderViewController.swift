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
        
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
//        var date = dateFormatter.date(from: time)
        
        guard let timezone =  TimeZone.current.localizedName(for: .shortStandard, locale: .current) else {
            return
        }
        
        print("DUMMY REMINDER : \(time)")
        print("DUMMY DATEFORMATER : \(timezone)")
//        dateFormatter.timeZone = TimeZone(abbreviation: "WIT")
        
        let localISOFormatter = ISO8601DateFormatter()
        localISOFormatter.timeZone = TimeZone.current
        
//        print("DUMMY \(localISOFormatter.date(from: time))")
        if let date = localISOFormatter.date(from: time){
            print("DUMMY \(date)")
            var title: String = ""
            var body: String = ""
            switch selectedRoutine.name {
            case "Morning Skin Care":
                title = "Good Morning!"
                body = "Don't forget to do your Morning Skin Care Routine!"
                
            case "Night Skin Care":
                title = "Almost bed time!"
                body = "It's time to do your Evening Skin Care Routine"
                
            default:
                title = selectedRoutine.name ?? ""
                body = "Let's go, make it happen!"
            }
            PersistanceManager.shared.setReminder(reminderTime: date, routine: self.selectedRoutine,title: title, body: body)
        }
        
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
            
            let splitTime = "\(time)".split(separator: ":")
            let hour = splitTime[0].suffix(2)
            let minute = splitTime[1]
            
            row.labelAlarm.text = "\(hour).\(minute)"
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
