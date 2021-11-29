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
    @IBOutlet weak var circularProgressPercentageLabel : UILabel!
    @IBOutlet weak var backgoundWhite: UIView!
    @IBOutlet weak var backgroundPurple: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var tutorial1: UIImageView!
    @IBOutlet weak var tutorial2: UIImageView!
    @IBOutlet weak var tutorial3: UIImageView!
    @IBOutlet weak var tutorial4: UIImageView!
    @IBOutlet weak var tutorial5: UIImageView!
    @IBOutlet weak var tutorial6: UIImageView!
    @IBOutlet weak var backgroundTutorial: UIView!
    @IBOutlet weak var statusSegmentedControl: UISegmentedControl!
    
    var selectedDate: String = ""
    var skinCareRoutines: [Routines]!
    var selectedIndex : Int = 0
    var tutorialIndex : Int = 1
    var currentStatus : StatusRoutine = StatusRoutine.isToDo
    
    var currentTableView: [Routines] = []
    var todoTableView: [Routines] = []
    var completedTableView: [Routines] = []
    var skippedTableView: [Routines] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableViewDataByStatus()
        configureNavigationBar()
        setUpTableView()
        configureBackground()
        configureTutorial()
        configureSegmented()
        setUpcircularProgress()
    }
    
    func configureTableViewDataByStatus() {
        skinCareRoutines = PersistanceManager.shared.fetchRoutines()
        todoTableView = skinCareRoutines.filter({$0.isCompleted == false && $0.isSkipped == false})
        completedTableView = skinCareRoutines.filter({$0.isCompleted == true})
        skippedTableView = skinCareRoutines.filter({$0.isSkipped == true})
        
        if currentStatus == StatusRoutine.isToDo {
            currentTableView = todoTableView
        } else if currentStatus == StatusRoutine.isSkipped {
            currentTableView = skippedTableView
        } else {
            currentTableView = completedTableView
        }
    }
    
    func configureSegmented() {
        statusSegmentedControl.setTitle("To Do (\(todoTableView.count))", forSegmentAt: 0)
        statusSegmentedControl.setTitle("Completed (\(completedTableView.count))", forSegmentAt: 1)
        statusSegmentedControl.setTitle("Skipped (\(skippedTableView.count))", forSegmentAt: 2)
    }
    
    private func configureTutorial() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTutorialTap(_:)))
        
        if UserDefaults.standard.bool(forKey: "isCompleteTutorial") == true {
            backgroundTutorial.removeFromSuperview()
            tutorial1.removeFromSuperview()
            tutorial2.removeFromSuperview()
            tutorial3.removeFromSuperview()
            tutorial4.removeFromSuperview()
            tutorial5.removeFromSuperview()
            tutorial6.removeFromSuperview()
        } else {
            backgroundTutorial.addGestureRecognizer(tap)
            tutorial1.isHidden = false
            tutorial2.isHidden = true
            tutorial3.isHidden = true
            tutorial4.isHidden = true
            tutorial5.isHidden = true
            tutorial6.isHidden = true
        }
    }
    
    private func configureBackground() {
        backgoundWhite.layer.cornerRadius = 40
        backgoundWhite.layer.masksToBounds = true
    }
    
    private func configureNavigationBar() {
        title = "Today"
        let menuButton = UIBarButtonItem(image: UIImage(named: "Calender"), style: .plain, target: self, action: #selector(tapMenuButton))
        menuButton.tintColor = UIColor.black
        navigationItem.rightBarButtonItems = [menuButton]
    }
    
    private func setUpcircularProgress() {
        let products = PersistanceManager.shared.fetchProduct()
        var productDoneCount : Int = 0
        
        for product in products {
            if product.isDone {
                productDoneCount += 1
            }
        }
        
        let percentage : Float = Float(productDoneCount) / Float(products.count) * 100.0
        
        print("percentageeeee")
        print(percentage)
        print(productDoneCount)
        print(products.count)
        
        circularProgress.progressColor = UIColor.white
        circularProgress.trackColor = UIColor.systemGray4
        circularProgress.percentageValue = CGFloat(percentage) / 100
        circularProgressPercentageLabel.text = "\(Int(percentage))%"
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
            datePicker.backgroundColor = .black
        }
        datePicker.datePickerMode = .date
        return datePicker
    }()
    
    @IBAction func changeTableView(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            currentTableView = todoTableView
            currentStatus = StatusRoutine.isToDo
        } else if sender.selectedSegmentIndex == 1 {
            currentTableView = completedTableView
            currentStatus = StatusRoutine.isCompleted
        } else {
            currentTableView = skippedTableView
            currentStatus = StatusRoutine.isSkipped
        }
        
        routineTableView.reloadData()
    }
    
    @objc func handleTutorialTap(_ sender: Any) {
        tutorialIndex += 1
        print(tutorialIndex)
        if (tutorialIndex == 2) {
            tutorial1.removeFromSuperview()
            tutorial2.isHidden = false
            tutorial3.isHidden = true
            tutorial4.isHidden = true
            tutorial5.isHidden = true
            tutorial6.isHidden = true
        } else if (tutorialIndex == 3) {
            tutorial2.removeFromSuperview()
            tutorial3.isHidden = false
            tutorial4.isHidden = true
            tutorial5.isHidden = true
            tutorial6.isHidden = true
        } else if (tutorialIndex == 4) {
            tutorial3.removeFromSuperview()
            tutorial4.isHidden = false
            tutorial5.isHidden = true
            tutorial6.isHidden = true
        } else if (tutorialIndex == 5) {
            tutorial4.removeFromSuperview()
            tutorial5.isHidden = false
            tutorial6.isHidden = true
        } else if (tutorialIndex == 6) {
            tutorial5.removeFromSuperview()
            tutorial6.isHidden = false
        } else {
            tutorial6.removeFromSuperview()
            UserDefaults.standard.set(true, forKey: "isCompleteTutorial")
            backgroundTutorial.removeFromSuperview()
        }
    }
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let nav = segue.destination as? UINavigationController else {
            return
        }
        
        guard let addRoutineVC = nav.topViewController as? AddRoutineViewController else {
            return
        }
        
        addRoutineVC.selectedRoutine = self.skinCareRoutines[selectedIndex]
        nav.modalPresentationStyle = .fullScreen
    }
}

extension ActivityViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentTableView.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let productsByRoutine = PersistanceManager.shared.fetchProduct(routine: currentTableView[indexPath.row])
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoutinesTableViewCell", for: indexPath) as! RoutinesTableViewCell
        cell.setup(with: currentTableView[indexPath.row])
        var productDoneCount : Int = 0
        
        for product in productsByRoutine {
            if product.isDone {
                productDoneCount += 1
            }
        }
        
        PersistanceManager.shared.changeRoutineStatus(id: self.currentTableView[indexPath.row].id!,statusType: StatusRoutine.isCompleted ,status: productDoneCount == productsByRoutine.count)
         
        cell.routineProduct.text = "\(productDoneCount)/\(productsByRoutine.count)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let productsByRoutine = PersistanceManager.shared.fetchProduct(routine: currentTableView[indexPath.row])
        var productDoneCount : Int = 0
        
        for product in productsByRoutine {
            PersistanceManager.shared.changeProductStatus(id: product.id!, status: true)
            if product.isDone {
                productDoneCount += 1
            }
        }
        
        let closeAction = UIContextualAction(style: .normal, title:  "Finish", handler: { [self] (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            PersistanceManager.shared.changeRoutineStatus(id: self.currentTableView[indexPath.row].id!,statusType: StatusRoutine.isCompleted ,status: true)
            if (self.currentTableView[indexPath.row].isSkipped == true) {
                PersistanceManager.shared.changeRoutineStatus(id: self.currentTableView[indexPath.row].id!,statusType: StatusRoutine.isSkipped ,status: false)
            }
            print("Finish")
            self.configureTableViewDataByStatus()
            self.configureSegmented()
            self.setUpTableView()
            self.setUpcircularProgress()
            tableView.reloadData()
            success(true)
        })
        closeAction.image = UIImage(named: "tick")
        closeAction.backgroundColor = .systemGreen
        
        return UISwipeActionsConfiguration(actions: [closeAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            self.selectedIndex = indexPath.row
        
        
        performSegue(withIdentifier: "moveToAddRoutinePage", sender: self)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let productsByRoutine = PersistanceManager.shared.fetchProduct(routine: currentTableView[indexPath.row])
        var productDoneCount : Int = 0
        
        for product in productsByRoutine {
            PersistanceManager.shared.changeProductStatus(id: product.id!, status: false)
            if product.isDone {
                productDoneCount += 1
            }
        }
        
        let modifyAction = UIContextualAction(style: .normal, title:  "Skip", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            PersistanceManager.shared.changeRoutineStatus(id: self.currentTableView[indexPath.row].id!,statusType: StatusRoutine.isSkipped, status: true)
            
            if (self.currentTableView[indexPath.row].isCompleted == true) {
                PersistanceManager.shared.changeRoutineStatus(id: self.currentTableView[indexPath.row].id!,statusType: StatusRoutine.isCompleted ,status: false)
            }
            
            self.configureTableViewDataByStatus()
            self.configureSegmented()
            self.setUpcircularProgress()
            self.setUpTableView()
            print("SKIP")
            success(true)
            tableView.reloadData()
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
