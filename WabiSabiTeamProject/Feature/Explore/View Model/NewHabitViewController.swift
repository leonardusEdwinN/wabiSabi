//
//  NewHabitViewController.swift
//  WabiSabiTeamProject
//
//  Created by Edwin Niwarlangga on 30/11/21.
//

import Foundation
import UIKit

//startHabitTableViewCell
//routineNameTableViewCell
//selectWeekTableViewCell
//productHeaderTableViewCell
class NewHabitViewController : UIViewController{
    
    
    // MARK: variable
    var arrayRoutine : [String] = ["name","start", "schedule", "headerp", "products","button", "reminder", "timer", "location"]
    var isEdit: Bool = false
    
    var products: [Product] = []
    var selectedProduct: Product!
    var selectedRoutine : Routines!
    var schedule : [Schedule] = []
    var subcategories : SubCategories!
    var startHabit: Date = Date()
    
    var dayToDoHabit: [Bool] = [false, false, false, false, false, false, false]
    var isEveryday: Bool = false
    
    // MARK: UI Component
    @IBOutlet var outerView: UIView!
    @IBOutlet var habitTableView: UITableView!
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelDetail: UILabel!
    @IBOutlet var buttonSave: UIButton!
    @IBOutlet var backButton: UIButton!
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func buttonSavePressed(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ROUTINE : \(selectedRoutine.name)")
        fetchDataProduct()
        setupTableView()
        setupUI()
    }
    
    func setupUI(){
        labelTitle.text = subcategories.habitName
        labelDetail.text = subcategories.description
        
        outerView.layer.cornerRadius = 29
        outerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        outerView.layer.borderWidth = 2
        outerView.layer.borderColor = UIColor.white.cgColor
        
        hideKeyboardWhenTappedAround()
        
    }
    
    func fetchDataProduct(){
        self.products = PersistanceManager.shared.fetchProduct(routine: self.selectedRoutine)
        print("PRODUCT : \(products.count)")
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(QuestionNameViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    func setupTableView(){
        
        habitTableView.register(UINib.init(nibName: "RoutineNameTableViewCell", bundle: nil), forCellReuseIdentifier: "routineNameTableViewCell")
        
        habitTableView.register(UINib.init(nibName: "StartHabitTableViewCell", bundle: nil), forCellReuseIdentifier: "startHabitTableViewCell")
        
        habitTableView.register(UINib.init(nibName: "SelectWeekTableViewCell", bundle: nil), forCellReuseIdentifier: "selectWeekTableViewCell")
        habitTableView.register(UINib.init(nibName: "ProductHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "productHeaderTableViewCell")
        
        
        habitTableView.register(UINib.init(nibName: "ProductUsedTableViewCell", bundle: nil), forCellReuseIdentifier: "productUsedTableViewCell")
        habitTableView.register(UINib.init(nibName: "ButtonRoutinePageTableViewCell", bundle: nil), forCellReuseIdentifier: "buttonRoutineTableViewCell")
        habitTableView.register(UINib.init(nibName: "BeRemindedTableViewCell", bundle: nil), forCellReuseIdentifier: "remindedTableViewCell")
        habitTableView.register(UINib.init(nibName: "TimerReminderTableViewCell", bundle: nil), forCellReuseIdentifier: "timerReminderTableViewCell")
        habitTableView.register(UINib.init(nibName: "LocationReminderTableViewCell", bundle: nil), forCellReuseIdentifier: "locationReminderTableViewCell")
        
        habitTableView.delegate = self
        habitTableView.dataSource = self
    }
}


extension NewHabitViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayRoutine.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var row : Int = 0
        if(arrayRoutine[section] == "products"){
            row = products.count
        }else{
            row = 1
        }
        return row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print("indexpat \(indexPath.section)")
        switch arrayRoutine[indexPath.section] {
        case "name":
            let row = tableView.dequeueReusableCell(withIdentifier: "routineNameTableViewCell") as! RoutineNameTableViewCell
            
            row.setUI(placeholder: self.subcategories.habitName)
            //set namenya
            return row
        case "start":
            
            let row = tableView.dequeueReusableCell(withIdentifier: "startHabitTableViewCell") as! StartHabitTableViewCell
            
            row.delegate = self
            return row
        case "schedule":
            
            let row = tableView.dequeueReusableCell(withIdentifier: "selectWeekTableViewCell") as! SelectWeekTableViewCell
            
            row.delegate = self
            return row
        case "headerp":
            let row = tableView.dequeueReusableCell(withIdentifier: "productHeaderTableViewCell") as! ProductHeaderTableViewCell
            
            row.delegate = self
            return row
        case "products":
            let row = tableView.dequeueReusableCell(withIdentifier: "productUsedTableViewCell") as! ProductUsedTableViewCell
            
            
            row.productNameLabel.text = arrayRoutine[indexPath.section]
            
                //ada data
                if(isEdit){
                    print("IS EDIT TRUE")
                    row.setDragableandTrashIcon()
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                }
                else{
                    self.products[indexPath.row].isDone ? row.setStatusDone() : row.setStatusUndone()
                }
                
                if((products[indexPath.row]) != nil){
                    if let name = self.products[indexPath.row].name, let brand = self.products[indexPath.row].brand{
                        DispatchQueue.main.async {
                            row.setUIText(title: self.products[indexPath.row].productType ?? "", brand: "\(brand)", desc: "\(name)")
                        }
                    }
                }else{
                    DispatchQueue.main.async {
                        row.setUIText(title: self.products[indexPath.row].name ?? "", brand: "Product Brand", desc: "Add your Product")
                        row.hideAll()
                    }
                }
                
                if let image = products[indexPath.row].picture{
                        DispatchQueue.main.async {
                            row.setUIImage(image: image)
                        }

                }
            
            print("SELECTED PRODUCT \(self.products[indexPath.row])")
            row.selectedProduct = self.products[indexPath.row]
            row.delegate = self
            row.selectedIndexPath = indexPath
            
            return row
        case "button":
            let row = tableView.dequeueReusableCell(withIdentifier: "buttonRoutineTableViewCell") as! ButtonRoutinePageTableViewCell
            
            row.delegate = self
            return row
        case "reminder":
            
            let row = tableView.dequeueReusableCell(withIdentifier: "remindedTableViewCell") as! BeRemindedTableViewCell
            return row
        case "timer":
            
            let row = tableView.dequeueReusableCell(withIdentifier: "timerReminderTableViewCell") as! TimerReminderTableViewCell
            return row
        case "location":
            
            let row = tableView.dequeueReusableCell(withIdentifier: "locationReminderTableViewCell") as! LocationReminderTableViewCell
            return row
        default:
            return UITableViewCell();
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch arrayRoutine[indexPath.section] {
        case "products":
//            if(row.productNameLabel.text == "Product Type" && row.productBrandLabel.text == "Product Brand"){
//                //kondisi di mana belum ada data
//                print("INDEXPath : \(indexPath.row)")
////                self.selectedProduct = products[indexPath.row]
////                performSegue(withIdentifier: "moveToAddProduct", sender: self)
//            }else{
//
//            }
            
            if(products.count > 0)
            {
                if((products[indexPath.row].brand) != nil && (products[indexPath.row].brand) != nil){
                    //ada data
                    if(!isEdit)
                    {
                        
                        let row = tableView.dequeueReusableCell(withIdentifier: "productUsedTableViewCell") as! ProductUsedTableViewCell
                        if(products[indexPath.row].isDone){
                            //di uncheck
                            row.setStatusUndone()
                            if let id = self.products[indexPath.row].id{
                                //update data status
                                PersistanceManager.shared.changeProductStatus(id: id, status: false)
                            }
                            
                            tableView.reloadRows(at: [indexPath], with: .automatic)
                        }else{
                            // di check
                            
                            row.setStatusDone()
                            if let id = self.products[indexPath.row].id{
                                //update data status
                                PersistanceManager.shared.changeProductStatus(id: id, status: true)
                            }
                            
                            tableView.reloadRows(at: [indexPath], with: .automatic)
                        }
                    }
                }
            }
            else{
                //ga ada data
                self.selectedProduct = products[indexPath.row]
                performSegue(withIdentifier: "moveToAddProduct", sender: self)
            }
        case "timer":
            performSegue(withIdentifier: "moveToTimeReminder", sender: self)
        default :
            print("Cannot Click")
        }

    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var heightForRow : CGFloat = 0
        
        switch arrayRoutine[indexPath.section] {
        case "name":
            heightForRow = 100
        case "start":
            heightForRow = 100
        case "schedule":
            heightForRow = 150
        case "headerp":
            heightForRow = 30
        case "products":
            heightForRow = 100
        case "button":
            heightForRow = 110
        case "reminder":
            heightForRow = 80
        case "timer":
            heightForRow = 140
        case "location":
            heightForRow = 140
        default:
            heightForRow = 0
        }
        
        return heightForRow
    }
    
    
}

extension NewHabitViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveToAddProduct"{
            
            guard let nav = segue.destination as? UINavigationController else {
                return
            }
            
            guard let addProductVC = nav.topViewController as? AddProductViewController else {
               return
            }
            
            addProductVC.selectedRoutine = self.selectedRoutine
            addProductVC.delegateAddProduct = self
            addProductVC.selectedProduct = self.selectedProduct
            addProductVC.isEdit = (self.selectedProduct != nil) ? true : false
            addProductVC.modalPresentationStyle = .fullScreen
            
        }else if segue.identifier == "moveToTimeReminder"{
            
            guard let nav = segue.destination as? UINavigationController else {
                return
            }
            
            guard let timerReminderVC = nav.topViewController as? TimerReminderViewController else {
                return
            }
            timerReminderVC.selectedRoutine = self.selectedRoutine
        
        }
    }
    
    
}


extension NewHabitViewController : DidSelectButtonAtStartHabitDelegate, OverlayButtonProtocol {
    
    
    func didtapTodayButton() {
        print("TODAY")
        startHabit = Date()
    }
    
    func didtapTommorowButton() {
        print("TOMO")
        let today = Date()
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)
        startHabit = tomorrow ?? Date()
    }
    
    func didtapCustomButton() {
        print("CUSTOM")
        let slideVC = OverlayCalenderView()
        slideVC.modalPresentationStyle = .custom
        slideVC.transitioningDelegate = self
        slideVC.delegate = self
        self.present(slideVC, animated: true, completion: nil)
    }
    
    func buttonSavePressed(time: String) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        
        
        if let date = dateFormatter.date(from: time){
            
            print("START HABIT CUSTOM : \(date)")
            self.startHabit  = date
        }
        
        
    }
    
}


extension NewHabitViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationCalenderController(presentedViewController: presented, presenting: presenting)
    }
}


extension NewHabitViewController : DidEditButtonPressed{
    func editButtonPressed(title status: String) {
        if(status == "Save"){
            //kembalikan ke state edit
            self.isEdit = false
            self.habitTableView.reloadData()
        }else if(status == "Edit"){
            //kembalikan ke state save
            self.isEdit = true
            self.habitTableView.reloadData()
        }
    }
}

extension NewHabitViewController : deleteProductItemDelegate{
    func deleteProductItem(deletedProduct product: Product) {
        print("DELET PRODUCT")
        PersistanceManager.shared.deleteProduct(product: product)
        DispatchQueue.main.async {
            self.fetchDataProduct()
            self.habitTableView.reloadData()
        }
    }
    
    func editProductItem(editedProduct product: Product) {
        print("ADD PRODUCT ROW CLICKED")
        self.selectedProduct = product
        performSegue(withIdentifier: "moveToAddProduct", sender: self)
    }
}


extension NewHabitViewController : SelectDayOfTheWeekDelegate{
    func didTapSelectWeek(dayOfTheWeek: String) {
        
        var temp = Schedule(context: PersistanceManager.shared.persistentContainer.viewContext)
        
        
        switch dayOfTheWeek {
        case "Monday":
            temp.schedule = "0"
            self.schedule.append(temp)
        case "Tuesday":
            temp.schedule = "1"
            self.schedule.append(temp)
        case "Wednesday":
            temp.schedule = "2"
            self.schedule.append(temp)
        case "Thursday":
            temp.schedule = "3"
            self.schedule.append(temp)
        case "Friday":
            temp.schedule = "4"
            self.schedule.append(temp)
        case "Saturday":
            temp.schedule = "5"
            self.schedule.append(temp)
        case "Sunday":
            temp.schedule = "6"
            self.schedule.append(temp)
        case "All":
            var habits : [Schedule] = []
            
            for index in 0...6 {
                temp.schedule = "\(index)"
                habits.append(temp)
            }
            self.schedule = habits
        default:
            temp.schedule=""
        }
        
        print("SCHEDULE : \(schedule.count)")
       
    }
}

extension NewHabitViewController : AddProductDelegate{
    func addNewProduct() {
        self.performSegue(withIdentifier: "moveToAddProduct", sender: self)
    }
    
    func importProductFromExisting() {
        self.performSegue(withIdentifier: "moveToImportRoutine", sender: self)
    }
}

extension NewHabitViewController : SaveNewProductRoutineDelegate{
    func saveNewProductRoutine(for product: ProductModel) {
        var productTemp = Product(context: PersistanceManager.shared.persistentContainer.viewContext)
        
        productTemp.name = product.name
        productTemp.picture = product.image
        productTemp.brand = product.brand
        productTemp.periodAfterOpening = product.openedDate
        productTemp.productType = product.productType
        productTemp.isDone = product.isDone
        
        products.append(productTemp)
        
        DispatchQueue.main.async {
            self.habitTableView.reloadData()
            Loading.sharedInstance.hideIndicator()
        }
    }
    
    
}

//extension NewHabitViewController : SaveProductDelegate{
//    func saveProductAndReloadIt() {
//        print("Save")
//        DispatchQueue.main.async {
//            self.fetchDataProduct()
//            self.habitTableView.reloadData()
//            Loading.sharedInstance.hideIndicator()
//        }
//    }
//}
