//
//  TimerReminderViewController.swift
//  WabiSabiTeamProject
//
//  Created by Edwin Niwarlangga on 16/11/21.
//

import UIKit

//timerTableViewCell

class TimerReminderViewController: UIViewController {
    
    
    // MARK: Navigation
    @IBOutlet weak var buttonAdd: UIButton!
    @IBOutlet weak var labelTitlePage: UILabel!
    @IBOutlet weak var buttonBack: UIButton!
    
    @IBAction func buttonBackPressed(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func buttonAddPressed(_ sender: Any) {
    }
    
    // MARK: TableView
    @IBOutlet weak var timerReminderTableView: UITableView!
    
    // MARK: EmptyState
    @IBOutlet weak var viewEmptyState: UIView!
    @IBOutlet weak var viewCircle: UIView!
    var tableAlarmArray : [String] = []
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
        
        return row
        
    }
    
    
}
