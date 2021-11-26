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
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var tutorialBackground: UIView!
    @IBOutlet weak var tutorial1: UIImageView!
    @IBOutlet weak var tutorial2: UIImageView!
    @IBOutlet weak var tutorial3: UIImageView!
    @IBOutlet weak var tutorial4: UIImageView!
    @IBOutlet weak var tutorial5: UIImageView!
    @IBOutlet weak var tutorial6: UIImageView!
    
    var selectedDate: String = ""
    var skinCareRoutines: [Routines]!
    var selectedIndex : Int = 0
    var tutorialIndex : Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        setUpcircularProgress()
        setUpTableView()
        configureButton()
        configureBackground()
        configureTutorial()
        
        skinCareRoutines = PersistanceManager.shared.fetchRoutines()
    }
    
    private func configureTutorial() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTutorialTap(_:)))
        tutorialBackground.addGestureRecognizer(tap)
        
        if UserDefaults.standard.bool(forKey: "isCompleteTutorial") == true {
            tutorialBackground.removeFromSuperview()
        } else {
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
        menuButton.tintColor = UIColor.black
        navigationItem.rightBarButtonItems = [menuButton]
    }
    
    private func setUpcircularProgress() {
        circularProgress.progressColor = UIColor.white
        circularProgress.trackColor = UIColor.systemGray4
        circularProgress.percentageValue = 0.8
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
    
    @objc func handleTutorialTap(_ sender: Any) {
        tutorialIndex += 1
        print(tutorialIndex)
        if (tutorialIndex == 2) {
            tutorial1.isHidden = true
            tutorial2.isHidden = false
            tutorial3.isHidden = true
            tutorial4.isHidden = true
            tutorial5.isHidden = true
            tutorial6.isHidden = true
        } else if (tutorialIndex == 3) {
            tutorial1.isHidden = true
            tutorial2.isHidden = true
            tutorial3.isHidden = false
            tutorial4.isHidden = true
            tutorial5.isHidden = true
            tutorial6.isHidden = true
        } else if (tutorialIndex == 4) {
            tutorial1.isHidden = true
            tutorial2.isHidden = true
            tutorial3.isHidden = true
            tutorial4.isHidden = false
            tutorial5.isHidden = true
            tutorial6.isHidden = true
        } else if (tutorialIndex == 5) {
            tutorial1.isHidden = true
            tutorial2.isHidden = true
            tutorial3.isHidden = true
            tutorial4.isHidden = true
            tutorial5.isHidden = false
            tutorial6.isHidden = true
        } else if (tutorialIndex == 6) {
            tutorial1.isHidden = true
            tutorial2.isHidden = true
            tutorial3.isHidden = true
            tutorial4.isHidden = true
            tutorial5.isHidden = true
            tutorial6.isHidden = false
        } else {
            UserDefaults.standard.set(true, forKey: "isCompleteTutorial")
            tutorialBackground.removeFromSuperview()
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
            fatalError("NavigationController not found")
        }
        
        guard let AddRoutineVC = nav.topViewController as? AddRoutineViewController else {
            fatalError("AddRoutineViewController not found")
            
//            let storyboard = UIStoryboard(name: "AddRoutine", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "addRoutineVC") as! AddRoutineViewController
//            vc.selectedRoutine = skinCareRoutines[indexPath.row]
//
//            self.show(vc, sender: nil)
        }
        
        AddRoutineVC.selectedRoutine = skinCareRoutines[selectedIndex]
    }
}

extension ActivityViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoutinesTableViewCell", for: indexPath) as! RoutinesTableViewCell
        cell.setup(with: routines[indexPath.row])
        
        cell.routineProduct.text = "0/\(PersistanceManager.shared.fetchProduct(routine: skinCareRoutines[indexPath.row]).count)"
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(indexPath.item == 0){
            performSegue(withIdentifier: "moveToAddRoutinePage", sender: self)
            self.selectedIndex = indexPath.item
        }
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let modifyAction = UIContextualAction(style: .normal, title:  "Skip", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            tableView.beginUpdates()
            routines.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            PersistanceManager.shared.deleteRoutines(routines: self.skinCareRoutines[indexPath.row])
            
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
