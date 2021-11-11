//
//  ActivityViewController.swift
//  WabiSabiTeamProject
//
//  Created by Albert . on 05/11/21.
//

import UIKit

class ActivityViewController: UIViewController {
    @IBOutlet weak var routineTableView: UITableView!
    @IBOutlet weak var circularProgress: CircularProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        setUpcircularProgress()
        setUpTableView()
    }
    
    private func configureNavigationBar() {
        title = "Today"
        let menuButton = UIBarButtonItem(image: UIImage(named: "Calender"), style: .plain, target: self, action: nil)
        menuButton.tintColor = UIColor.systemIndigo
        navigationItem.rightBarButtonItems = [menuButton]
    }
    
    private func setUpcircularProgress() {
        circularProgress.progressColor = UIColor.systemIndigo
        circularProgress.trackColor = UIColor.systemGray4
        circularProgress.percentageValue = 0.8
    }
    
    private func setUpTableView() {
        routineTableView.dataSource = self
        routineTableView.delegate = self
        let nib = UINib(nibName: "RoutinesTableViewCell", bundle: nil)
        routineTableView.register(nib, forCellReuseIdentifier: "RoutinesTableViewCell")
    }
}

extension ActivityViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoutinesTableViewCell", for: indexPath) as! RoutinesTableViewCell
        cell.setup(with: routines[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let closeAction = UIContextualAction(style: .normal, title:  "Finish", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("Finish")
            success(true)
        })
        closeAction.image = UIImage(named: "tick")
        closeAction.backgroundColor = .systemGreen
        
        return UISwipeActionsConfiguration(actions: [closeAction])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let modifyAction = UIContextualAction(style: .normal, title:  "Skip", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            tableView.beginUpdates()
            routines.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.endUpdates()
            print("SKIP")
            success(true)
        })
        modifyAction.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [modifyAction])
    }
}
