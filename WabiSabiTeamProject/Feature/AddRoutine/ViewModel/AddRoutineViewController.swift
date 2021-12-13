//
//  AddRoutineViewController.swift
//  WabiSabiTeamProject
//
//  Created by Edwin Niwarlangga on 11/11/21.
//

import Foundation
import UIKit

//productUsedTableViewCell
//remindedTableViewCell
//locationReminderTableViewCell
//timerReminderTableViewCell
//buttonRoutineTableViewCell

class AddRoutineViewController : UIViewController{
    @IBOutlet weak var routineTableView: UITableView!
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var editButton: UIButton!
    @IBAction func editButtonPressed(_ sender: Any) {
        if(editButton.titleLabel?.text == "Save"){
            //kembalikan ke state edit
            self.isEdit = false
            DispatchQueue.main.async {
            
                UIView.setAnimationsEnabled(true)
                self.routineTableView.beginUpdates()
                self.routineTableView.reloadData()
                self.routineTableView.endUpdates()
                UIView.setAnimationsEnabled(true)
            }
            self.editButton.setTitle("Edit", for: .normal)
        }else if(editButton.titleLabel?.text == "Edit"){
            //kembalikan ke state save
            self.isEdit = true
            DispatchQueue.main.async {
                UIView.setAnimationsEnabled(true)
                self.routineTableView.beginUpdates()
                self.routineTableView.reloadData()
                self.routineTableView.endUpdates()
                UIView.setAnimationsEnabled(true)
            }
            self.editButton.setTitle("Save", for: .normal)
        }
        
        
    }
    
    @IBOutlet weak var detailButton: UIButton!
    @IBAction func detailButtonPressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "goToDetailSkinCareGuide", sender: self)
        
    }
    var products: [Product] = []
    var indexSelected: Int = 0
    var selectedRoutineString = ""
    
    @IBOutlet weak var routineLabel: UILabel!
    var selectedRoutine: Routines!
    var selectedProduct: Product!
    var isEdit: Bool = false
    var countTimer : Int = 0
    
    var skinTypeRoutine: [SkinRoutineProduct] = [
        SkinRoutineProduct(icon: "🌞", name: "Morning Skin Care", products: []),
        SkinRoutineProduct(icon: "🌓", name: "Night Skin Care", products: [])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // create an NSMutableAttributedString that we'll append everything to
//        let fullString = NSMutableAttributedString(string: "")
//
//        // create our NSTextAttachment
//        let image1Attachment = NSTextAttachment()
//        image1Attachment.image = UIImage(systemName: selectedRoutineString == "morning" ? "sun.max" : "moon.stars")
//
//        // wrap the attachment in its own attributed string so we can append it
//        let image1String = NSAttributedString(attachment: image1Attachment)
//
//        // add the NSTextAttachment wrapper to our full string, then add some more text.
//        fullString.append(image1String)
//        fullString.append(NSAttributedString(string: "Routine"))
//
//        // draw the result in a label
//        routineLabel.attributedText = fullString
//
        let attachment = NSTextAttachment()
        let config = UIImage.SymbolConfiguration(textStyle: .largeTitle)
        attachment.image = UIImage(systemName: selectedRoutineString == "morning" ? "sun.max" : "moon.stars", withConfiguration: config)

        let imageString = NSMutableAttributedString(attachment: attachment)
        let textString = NSAttributedString(string: "  Routine")
        imageString.append(textString)
        
        routineLabel.attributedText = imageString
        
        
//        self.navigationController?.navigationBar.prefersLargeTitles = true
//        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        detailButton.setTitle("", for: .normal)
        detailButton.setImage(UIImage(systemName: "info.circle"), for: .normal)
        
        outerView.layer.cornerRadius = 29
        outerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        outerView.layer.borderWidth = 2
        outerView.layer.borderColor = UIColor.white.cgColor
        
        
        
        registerCell()
        checkProduct()
        getCountReminder()
    }
    
    func checkProduct() {
        products = PersistanceManager.shared.fetchProduct(routine: selectedRoutine)
    }
    
    func getCountReminder() {
        countTimer = PersistanceManager.shared.fetchReminder(routine: selectedRoutine).count
    }
    
    func registerCell(){
        routineTableView.register(UINib.init(nibName: "ProductUsedTableViewCell", bundle: nil), forCellReuseIdentifier: "productUsedTableViewCell")
        
        routineTableView.register(UINib.init(nibName: "ButtonRoutinePageTableViewCell", bundle: nil), forCellReuseIdentifier: "buttonRoutineTableViewCell")
        routineTableView.register(UINib.init(nibName: "TimerReminderTableViewCell", bundle: nil), forCellReuseIdentifier: "timerReminderTableViewCell")
        
        routineTableView.register(UINib.init(nibName: "LocationReminderTableViewCell", bundle: nil), forCellReuseIdentifier: "locationReminderTableViewCell")
        
        routineTableView.register(UINib.init(nibName: "BeRemindedTableViewCell", bundle: nil), forCellReuseIdentifier: "remindedTableViewCell")
        
        
        
        routineTableView.delegate = self
        routineTableView.dataSource = self
        routineTableView.dragInteractionEnabled = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveToAddProduct"{
            
            guard let nav = segue.destination as? UINavigationController else {
                return
            }
            
            guard let addProductVC = nav.topViewController as? AddProductViewController else {
               return
            }
            print("\(selectedProduct.name) + \(selectedProduct.productType) ")
            addProductVC.selectedRoutine = self.selectedRoutine
            addProductVC.delegate = self
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
            
            timerReminderVC.delegate = self
            timerReminderVC.selectedRoutine = self.selectedRoutine
            
        }else if segue.identifier == "moveToLocationReminder"{
            
            guard let nav = segue.destination as? UINavigationController else {
                return
            }
            
            guard let AddProductVC = nav.topViewController as? LocationReminderViewController else {
                return
            }
        }else if segue.identifier == "goToDetailSkinCareGuide"{
//            print(selectedRoutine.name)
            guard let vc = segue.destination as? SkinCareGuideViewController else {
                return
            }
            
            
//            vc.modalPresentationStyle = .pageSheet
//            vc.modalPresentationStyle = .formSheet
//            vc.preferredContentSize = .init(width: self.view.frame.width, height: self.view.frame.height / 1.5)
            
            if let routineName = selectedRoutine.name{
                
                let skinTypeIndex = UserDefaults.standard.integer(forKey: "skinTypes")
                var levelIndex = UserDefaults.standard.integer(forKey: "levelIndex")
                print("LEVEL INDEX : \(levelIndex) :: Routine Name : \(routineName)")
                var productIndex: [Int] = []
                productIndex =  Utilities().levels[levelIndex].productIndex
                
                
                print("PRODUCT INDEX : \(productIndex)")
                if(routineName == "Morning Skin Care"){
                    //Go to morning skin care
                    
                    for index in 0..<productIndex.count {
                        let product = Utilities().skinTypeRoutineProduct[0].skinType[skinTypeIndex].products[productIndex[index]]
                        
                        if !(product.description == "") {
                            skinTypeRoutine[0].products.append(product)

                        }
                    }
                    
                    vc.skinTypeRoutine = skinTypeRoutine[0]
                }else{
                    //Go to Night Routine
                    for index in 0..<productIndex.count {
                        let product = Utilities().skinTypeRoutineProduct[1].skinType[skinTypeIndex].products[productIndex[index]]
                        
                        if !(product.description == "") {
                            skinTypeRoutine[1].products.append(product)

                        }
                    }
                    vc.skinTypeRoutine = skinTypeRoutine[1]
                }
            }
        }else if segue.identifier == "moveToImportRoutine"{
            guard let nav = segue.destination as? UINavigationController else {
                return
            }
            
            guard let importVC = nav.topViewController as? ImportViewController else {
               return
            }
            
            importVC.selectedRoutineToImport = selectedRoutine
        }
    }
    
    
    
}

extension AddRoutineViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count + 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row < products.count) {
            let row = tableView.dequeueReusableCell(withIdentifier: "productUsedTableViewCell") as! ProductUsedTableViewCell
            
            if(isEdit){
                //dragable and delete state
                row.setDragableandTrashIcon()
            }else{
                self.products[indexPath.row].isDone ? row.setStatusDone() : row.setStatusUndone()
                
            }
            
            
            if((products[indexPath.row].brand) != nil){
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
                print("Has image")
                    DispatchQueue.main.async {
                        row.setUIImage(image: image)
                    }
                
            }else{
                print("NO IMAGE")
                DispatchQueue.main.async {
                    row.setBlankImage(imageSystem: "plus")
                }
            }
            print("SELECTED PRODUCT \(self.products[indexPath.row])")
            row.selectedProduct = self.products[indexPath.row]
            row.delegate = self
            row.selectedIndexPath = indexPath
            
            return row
        }else if(indexPath.row == products.count){
            //button
            let row = tableView.dequeueReusableCell(withIdentifier: "buttonRoutineTableViewCell") as! ButtonRoutinePageTableViewCell
            
            row.delegate = self
            return row
        }else if(indexPath.row == products.count + 1){
            //reminder
            let row = tableView.dequeueReusableCell(withIdentifier: "remindedTableViewCell") as! BeRemindedTableViewCell
            
            return row

        }else if(indexPath.row == products.count + 2){
            //timer reminder
            let row = tableView.dequeueReusableCell(withIdentifier: "timerReminderTableViewCell") as! TimerReminderTableViewCell
            
            if(countTimer == 0){
                //set jadi tetep non
                row.setUI(counTimerText: "None")
            }else{
                row.setUI(counTimerText: "\(self.countTimer) Reminder")
            }
            
            return row
        }else if(indexPath.row == products.count + 3){
            //location reminder
            let row = tableView.dequeueReusableCell(withIdentifier: "locationReminderTableViewCell") as! LocationReminderTableViewCell
            
            return row

        }
        
        return UITableViewCell()
    }
}

extension AddRoutineViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var heightForRow : CGFloat = 0
        
        if(indexPath.row == products.count){
            //button
            heightForRow = 110
        }else if(indexPath.row == products.count + 1){
            //be reminded button
            heightForRow = 80
        }else if(indexPath.row == products.count + 2){
            //timer reminder
            heightForRow = 140
        }else if(indexPath.row == products.count + 3){
            //location reminder
            heightForRow = 140
        }else{
            heightForRow = 100
        }
        
        return heightForRow
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let verticalPadding: CGFloat = 10

        let maskLayer = CALayer()
        maskLayer.cornerRadius = 10    //if you want round edges
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
        cell.layer.mask = maskLayer
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(indexPath.row == products.count){
            //button
            print("BUTTON ROW CLICKED")
        }else if(indexPath.row == products.count + 1){
            //reminded
//            performSegue(withIdentifier: "moveToLocationReminder", sender: self)
        }else if(indexPath.row == products.count + 2){
            //timer reminder
            print("TIME REMINDER ROW CLICKED")
            performSegue(withIdentifier: "moveToTimeReminder", sender: self)
        }else if(indexPath.row == products.count + 3){
            //location reminder
            print("LOCATION REMINDER ROW CLICKED")
            performSegue(withIdentifier: "moveToLocationReminder", sender: self)
        }else{
//            if(!isEdit){
//                // MARK: Ketika tidak melakukan edit(dragable or delete)
//                print("ADD PRODUCT ROW CLICKED")
//                self.selectedProduct = products[indexPath.row]
//                performSegue(withIdentifier: "moveToAddProduct", sender: self)
//            }else{
//
//            }
            if((products[indexPath.row].brand) != nil){
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
            
            
        }
        
        
    }
    
    
}

extension AddRoutineViewController : AddProductDelegate{
    // MARK: Delegate From ButtonRoutinePageTableViewCell class
    func addNewProduct() {
        self.performSegue(withIdentifier: "moveToAddProduct", sender: self)
    }
    
    func importProductFromExisting() {
        self.performSegue(withIdentifier: "moveToImportRoutine", sender: self)
    }
}

extension AddRoutineViewController : SaveProductDelegate{
    // MARK: Delegate from AddProductViewController class
    func saveProductAndReloadIt() {
        DispatchQueue.main.async {
            self.checkProduct()
            self.routineTableView.reloadData()
            Loading.sharedInstance.hideIndicator()
        }
    }
    
    
}

extension AddRoutineViewController : EditDeletProductItemDelegate{
    // MARK: Delegate from ProductUsedTableViewCell trash icon
    func deleteProductItem(deletedProduct product: Product) {
        print("DELETE PRODUCT \(product.name)")
        PersistanceManager.shared.deleteProduct(product: product)
        DispatchQueue.main.async {
            self.checkProduct()
            self.routineTableView.reloadData()
        }
    }
    
    func editProductItem(editedProduct product: Product) {
        print("ADD PRODUCT ROW CLICKED")
        self.selectedProduct = product
        performSegue(withIdentifier: "moveToAddProduct", sender: self)
    }
    
}


extension AddRoutineViewController : GetDataAndReloadDelegate{
    func getDataAndReload(countTimer: Int) {
        print("counter timer : \(countTimer)")
        self.countTimer = countTimer
        DispatchQueue.main.async {
            UIView.setAnimationsEnabled(true)
            self.routineTableView.beginUpdates()
            self.routineTableView.reloadData()
            self.routineTableView.endUpdates()
            UIView.setAnimationsEnabled(true)
        }
    }
}
