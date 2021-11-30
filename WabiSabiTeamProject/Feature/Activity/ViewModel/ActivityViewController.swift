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
    
    let allRoutines = PersistanceManager.shared.fetchRoutines()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableViewDataByStatus()
        configureNavigationBar()
        generateDailyRoutine()
        setUpTableView()
        configureBackground()
        configureTutorial()
        configureSegmented()
        setUpcircularProgress()
        setGradientBackground()
//        backgroundPurple.backgroundColor = UIColor.systemGreen
    }
    
    func filterTodayRoutine(routines: [Routines]) -> [Routines] {
        let calendar = Calendar.current
        let todayRoutine = routines.filter({calendar.isDateInToday(($0.routineDate ?? Date.yesterday) as Date)})
        return todayRoutine
    }
    
    func generateDailyRoutine() {
        // Logic nya itu, ketika masuk app apabila kita belom generate maka akan mengenerate routine untuk 'besok' yang mana kondisinya adalah isEveryday == true || routines yang memiliki schedules hari esok
        let dayTommorow = Date.tomorrow
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayInWeek = dateFormatter.string(from: dayTommorow)
        var dayIndex : Int = 0
        
        if dayInWeek == "Sunday" {
            dayIndex = 0
        } else if dayInWeek == "Monday" {
            dayIndex = 1
        } else if dayInWeek == "Tuesday" {
            dayIndex = 2
        } else if dayInWeek == "Wednesday" {
            dayIndex = 3
        } else if dayInWeek == "Thursday" {
            dayIndex = 4
        } else if dayInWeek == "Friday" {
            dayIndex = 5
        } else if dayInWeek == "Saturday" {
            dayIndex = 6
        }

        // Filter schedules adalah besok atau isEveryday == true
        let routinesWithScheduleOrEveryDay = allRoutines.filter({$0.schedules?.contains(dayIndex) ?? false || $0.isEveryday == true})
    
        print("CREATEEEEE")
        print(dayInWeek)
        print(dayIndex)
        print(routinesWithScheduleOrEveryDay)
        
        // user default isGenerateToday == true -> tidak generate
        // user default isGenerateToday == false -> generate
        // user defailt lastGenerate == isToday -> tidak generate
        // user defailt lastGenerate == isYesterday -> generate
        // if lastGenerate == isYesterday || isGenerateToday == false -> generate / set isGenerateToday = true & lastGenerate = isToday
        let lastGenerateTime = UserDefaults.standard.object(forKey: "lastGenerateTime") as? Date
//        let isGeneratedToday = UserDefaults.standard.bool(forKey: "isGeneratedToday")
        
        if (lastGenerateTime?.weekday != Date().weekday || lastGenerateTime == nil) {
            UserDefaults.standard.set(Date(), forKey: "lastGenerateTime")
            UserDefaults.standard.set(true, forKey: "isGeneratedToday")
            
            for generateRoutine in routinesWithScheduleOrEveryDay {
                print("GENERATEEE")
                PersistanceManager.shared.setRoutine(isEveryday: generateRoutine.isEveryday, name: generateRoutine.name!, routineDate: Date.tomorrow)
                print(generateRoutine.name)
                print(generateRoutine.schedules?.allObjects)
                let products = generateRoutine.routineproduct?.allObjects as! [Product]
                for product in products {
                    PersistanceManager.shared.setProduct(name: product.name!)
                    
                    print("routineproduct")
                    print(product.routineproduct)
                    print(product.name)
                    
                }
                print(lastGenerateTime?.weekday)
                print(Date().weekday)
                print(lastGenerateTime?.weekday == Date().weekday)
            }
        } else {
            print("GA USAH GENERATE LAGI")
            print(lastGenerateTime?.weekday)
            print(Date().weekday)
            print(lastGenerateTime?.weekday == Date().weekday)
        }
        
        
       
    }
    
    func setGradientBackground() {
        let colorTop =  getUIColor(hex: "#E6D2C6")?.cgColor
        let colorBottom = getUIColor(hex: "#D4CFDE")?.cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = self.view.bounds
        
        
        backgroundPurple.layer.insertSublayer(gradientLayer, at:1)
    }
    
    func configureTableViewDataByStatus() {
        skinCareRoutines = filterTodayRoutine(routines: allRoutines)
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
        closeAction.backgroundColor = getUIColor(hex: "#CDCBDB")
        
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
        modifyAction.backgroundColor = getUIColor(hex: "#CDCBDB")
        
        return UISwipeActionsConfiguration(actions: [modifyAction])
    }
}

extension ActivityViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationCalenderController(presentedViewController: presented, presenting: presenting)
    }
}    

func getUIColor(hex: String, alpha: Double = 1.0) -> UIColor? {
    var cleanString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cleanString.hasPrefix("#")) {
        cleanString.remove(at: cleanString.startIndex)
    }

    if ((cleanString.count) != 6) {
        return nil
    }

    var rgbValue: UInt32 = 0
    Scanner(string: cleanString).scanHexInt32(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
}
