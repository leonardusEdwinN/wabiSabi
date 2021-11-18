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
    @IBOutlet weak var todoButton: UIButton!
    @IBOutlet weak var skippedButton: UIButton!
    @IBOutlet weak var completedButton: UIButton!
    @IBOutlet weak var backgoundWhite: UIView!
    @IBOutlet weak var backgroundPurple: UIView!
    @IBOutlet weak var circularProgressBackground: UIView!
    var selectedDate: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        setUpcircularProgress()
        setUpTableView()
        configureButton()
        configureBackground()
    }
    
    private func configureBackground() {
        backgoundWhite.layer.cornerRadius = 40
        backgoundWhite.layer.masksToBounds = true
    }
    
    private func configureButton() {
        todoButton.titleLabel?.numberOfLines = 1
        todoButton.titleLabel?.adjustsFontSizeToFitWidth = true
        todoButton.titleLabel?.lineBreakMode = .byClipping
        
        completedButton.titleLabel?.numberOfLines = 1
        completedButton.titleLabel?.adjustsFontSizeToFitWidth = true
        completedButton.titleLabel?.lineBreakMode = .byClipping
        
        skippedButton.titleLabel?.numberOfLines = 1
        skippedButton.titleLabel?.adjustsFontSizeToFitWidth = true
        skippedButton.titleLabel?.lineBreakMode = .byClipping
    }
    
    private func configureNavigationBar() {
        title = "Today"
        let menuButton = UIBarButtonItem(image: UIImage(named: "Calender"), style: .plain, target: self, action: #selector(tapMenuButton))
        menuButton.tintColor = UIColor.white
        navigationItem.rightBarButtonItems = [menuButton]
    }
    
    private func setUpcircularProgress() {
        circularProgress.progressColor = UIColor.systemIndigo
        circularProgress.trackColor = UIColor.systemGray4
        circularProgress.percentageValue = 0.8
        
        circularProgressBackground.layer.cornerRadius = 40
        circularProgressBackground.layer.masksToBounds = true
    }
    
    private func setUpTableView() {
        routineTableView.dataSource = self
        routineTableView.delegate = self
        let nib = UINib(nibName: "RoutinesTableViewCell", bundle: nil)
        routineTableView.register(nib, forCellReuseIdentifier: "RoutinesTableViewCell")
    }
    
    private lazy var datePicker : UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.autoresizingMask = .flexibleWidth
        if #available(iOS 13, *) {
            datePicker.backgroundColor = .label
        } else {
            datePicker.backgroundColor = .white
        }
        datePicker.datePickerMode = .date
        return datePicker
    }()
    
    @objc func tapMenuButton(_ sender: Any) {
        
        let slideVC = OverlayCalenderView()
        slideVC.modalPresentationStyle = .custom
        slideVC.transitioningDelegate = self
        self.present(slideVC, animated: true, completion: nil)
    }
    
    @objc func onDoneButtonClick() {
        datePicker.removeFromSuperview()
    }
    
    @objc func dateChanged(_ sender: UIDatePicker?) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        
        if let date = sender?.date {
            self.selectedDate = dateFormatter.string(from: date)
            datePicker.removeFromSuperview()
        }
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

extension ActivityViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationCalenderController(presentedViewController: presented, presenting: presenting)
    }
}
