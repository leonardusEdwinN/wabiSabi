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
    var routineName: String = ""
    
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
        
        //show indicator loading
        DispatchQueue.main.async {
            Loading.sharedInstance.showIndicator()
        }
        
        var schedules: [Schedule] = []
        for index in 0...6 {
            if dayToDoHabit[index] {
                var temp = Schedule(context: PersistanceManager.shared.persistentContainer.viewContext)
                temp.schedule = "\(index)"
                schedules.append(temp)
            }
        }
        
        if schedules.count == 0 {
            // Kalau Tidak Punya schedule
            PersistanceManager.shared.setRoutine(isEveryday: isEveryday, name: self.routineName, startHabit: self.startHabit)
        }
        else {
            //kalau punya schedule
            PersistanceManager.shared.setRoutine(isEveryday: isEveryday, startHabit: self.startHabit, name: self.routineName, schedules: schedules)
        }
        
        //Routine CREATED
        if let routineCreatedId = UserDefaults.standard.string(forKey: "routineID"){
            var selectedRoutineCreated = PersistanceManager.shared.fetchRoutine(id: routineCreatedId)
            self.selectedRoutine = selectedRoutineCreated
        }
        
        print("FETCH PRODUCTS")
        // Add product to routine
        for product in products {
            PersistanceManager.shared.setProduct(brand: product.brand ?? "", expiredDate: product.expiredDate ?? Date(), name: product.name ?? self.subcategories.habitName, periodAfterOpening: product.periodAfterOpening ?? Date(), picture: product.picture ?? "", routine: selectedRoutine, productType: product.productType ?? "", isDone: product.isDone)
        }
        
        products = PersistanceManager.shared.fetchProduct(routine: selectedRoutine)
        
        DispatchQueue.main.async {
            self.dismiss(animated: false) {
                Loading.sharedInstance.hideIndicator()
            }
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(NewHabitViewController.dismissKeyboard))
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
            
            row.delegate = self
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
                    row.setDragableandTrashIcon()
//                    tableView.reloadRows(at: [indexPath], with: .automatic)
                }
                else{
                    self.products[indexPath.row].isDone ? row.setStatusDone() : row.setStatusUndone()
                }
                
                if((products[indexPath.row]) != nil){
                    print("MASUK KE SINI")
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
            
            if((products[indexPath.row].name) != nil && (products[indexPath.row].brand) != nil){
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
            }else{
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
            addProductVC.isNotConnectToDB = true // data offline
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
//        print("TODAY")
        startHabit = Date()
            print("TODAY : \(startHabit)")
    }
    
    func didtapTommorowButton() {
        let today = Date()
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)
        startHabit = tomorrow ?? Date()
        
            print("TOMO : \(startHabit)")
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
        print("TIME \(time)")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd yyyy"
        dateFormatter.timeZone = TimeZone.current
        
        
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

extension NewHabitViewController : EditDeletProductItemDelegate{
    func deleteProductItem(deletedProduct product: Product) {
        print("DELET PRODUCT")
        self.products = products.filter({ $0.id != product.id})
        DispatchQueue.main.async {
            self.habitTableView.reloadData()
        }
    }
    
    func editProductItem(editedProduct product: Product) {
        print("ADD PRODUCT ROW CLICKED \(product.name)")
        self.selectedProduct = product
        performSegue(withIdentifier: "moveToAddProduct", sender: self)
    }
}


extension NewHabitViewController : SelectDayOfTheWeekDelegate{
    func didTapSelectWeek(dayOfTheWeek: String, isSelected : Bool) {
        
        switch dayOfTheWeek {
        case "Sunday":
            self.dayToDoHabit[0] = isSelected
        case "Monday":
            self.dayToDoHabit[1] = isSelected
        case "Tuesday":
            self.dayToDoHabit[2] = isSelected
        case "Wednesday":
            self.dayToDoHabit[3] = isSelected
        case "Thursday":
            self.dayToDoHabit[4] = isSelected
        case "Friday":
            self.dayToDoHabit[5] = isSelected
        case "Saturday":
            self.dayToDoHabit[6] = isSelected
        case "All":
            self.isEveryday = isSelected
            if(isSelected){
                //everyday
                for index in 0...6 {
                    self.dayToDoHabit[index] = true
                }
            }else{
                for index in 0...6 {
                    self.dayToDoHabit[index] = false
                }
            }
            
        default:
            print("DATA NOT FOUND")
        }
      
        
       
    }
}

extension NewHabitViewController : AddProductDelegate{
    func addNewProduct() {
        var productTemp = Product(context: PersistanceManager.shared.persistentContainer.viewContext)
        
        productTemp.name = ""
        productTemp.picture = ""
        productTemp.brand = ""
        productTemp.periodAfterOpening = Date()
        productTemp.expiredDate = Date()
        productTemp.productType = ""
        productTemp.isDone = false
        productTemp.id = ""
        
        self.selectedProduct = productTemp
        
        self.performSegue(withIdentifier: "moveToAddProduct", sender: self)
    }
    
    func importProductFromExisting() {
        self.performSegue(withIdentifier: "moveToImportRoutine", sender: self)
    }
}

extension NewHabitViewController : SaveNewProductRoutineDelegate{
    func updateNewProductRoutine(for product: ProductModel) {
        var productTemp = Product(context: PersistanceManager.shared.persistentContainer.viewContext)
        
        productTemp.name = product.name
        productTemp.picture = product.image
        productTemp.brand = product.brand
        productTemp.periodAfterOpening = product.openedDate
        productTemp.expiredDate = product.expired
        productTemp.productType = product.productType
        productTemp.isDone = product.isDone
        productTemp.id = product.id
        
        for (index, product) in products.enumerated(){
            print("Selected Product : \(selectedProduct.id) :: \(product.id)")
            if(selectedProduct.id == product.id){
//                isUpdate = true
                products[index] = productTemp //update productnya langunsg terus break
                break;
            }
        }
        
        DispatchQueue.main.async {
            self.habitTableView.reloadData()
            Loading.sharedInstance.hideIndicator()
        }
    }
    
    func saveNewProductRoutine(for product: ProductModel) {
        var productTemp = Product(context: PersistanceManager.shared.persistentContainer.viewContext)
        
        productTemp.name = product.name
        productTemp.picture = product.image
        productTemp.brand = product.brand
        productTemp.periodAfterOpening = product.openedDate
        productTemp.expiredDate = product.expired
        productTemp.productType = product.productType
        productTemp.isDone = product.isDone
        productTemp.id = product.id
        
        self.selectedProduct = productTemp
        
        if(products.count == 0){
            products.append(productTemp)
        }else{
            print("CEK DATA")
            var isCanAppend = true
            for product in products{
                print("Selected Product : \(selectedProduct.id) :: \(product.id)")
                if(selectedProduct.id == product.id){
                    isCanAppend = false
                }
            }
            
            print("iscanAppend : \(isCanAppend)")
            if isCanAppend{
                products.append(productTemp)
            }
        }
        
        print("product : \(products.count)")
        
        DispatchQueue.main.async {
            self.habitTableView.reloadData()
            Loading.sharedInstance.hideIndicator()
        }
    }
    
    
}

extension NewHabitViewController : TextfieldCellGetName{
    func getValueInsideTextfield(for textfield: String) {
        print("DELEGATE SUCCESS : \(textfield)")
        self.routineName = textfield
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
