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
            self.routineTableView.reloadData()
            self.editButton.setTitle("Edit", for: .normal)
        }else if(editButton.titleLabel?.text == "Edit"){
            //kembalikan ke state save
            self.isEdit = true
            self.routineTableView.reloadData()
            self.editButton.setTitle("Save", for: .normal)
        }
        
        
    }
    
    @IBOutlet weak var detailButton: UIButton!
    @IBAction func detailButtonPressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "goToDetailSkinCareGuide", sender: self)
        
    }
    var products: [Product] = []
    var indexSelected: Int = 0
    
    var selectedRoutine: Routines!
    var selectedProduct: Product!
    var isEdit: Bool = false
    
    var skinTypeRoutine: [SkinRoutineProduct] = [
        SkinRoutineProduct(icon: "🌞", name: "Morning Skin Care", products: []),
        SkinRoutineProduct(icon: "🌓", name: "Night Skin Care", products: [])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        detailButton.setTitle("", for: .normal)
        detailButton.setImage(UIImage(systemName: "info.circle"), for: .normal)
        
        outerView.layer.cornerRadius = 29
        outerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        outerView.layer.borderWidth = 2
        outerView.layer.borderColor = UIColor.white.cgColor
        
        
        
        registerCell()
        checkProduct()
    }
    
    func checkProduct() {
        products = PersistanceManager.shared.fetchProduct(routine: selectedRoutine)
    }
    
    func registerCell(){
        routineTableView.register(UINib.init(nibName: "ProductUsedTableViewCell", bundle: nil), forCellReuseIdentifier: "productUsedTableViewCell")
        
        routineTableView.register(UINib.init(nibName: "ButtonRoutinePageTableViewCell", bundle: nil), forCellReuseIdentifier: "buttonRoutineTableViewCell")
        routineTableView.register(UINib.init(nibName: "TimerReminderTableViewCell", bundle: nil), forCellReuseIdentifier: "timerReminderTableViewCell")
        
        routineTableView.register(UINib.init(nibName: "LocationReminderTableViewCell", bundle: nil), forCellReuseIdentifier: "locationReminderTableViewCell")
        
        routineTableView.register(UINib.init(nibName: "BeRemindedTableViewCell", bundle: nil), forCellReuseIdentifier: "remindedTableViewCell")
        
        
        
        routineTableView.delegate = self
        routineTableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveToAddProduct"{
            
            guard let nav = segue.destination as? UINavigationController else {
                return
            }
            
            guard let addProductVC = nav.topViewController as? AddProductViewController else {
               return
            }
            
            addProductVC.selectedRoutine = self.selectedRoutine
            addProductVC.delegate = self
            addProductVC.selectedProduct = self.selectedProduct
            addProductVC.isEdit = (self.selectedProduct != nil) ? true : false
            addProductVC.modalPresentationStyle = .fullScreen
            
        }else if segue.identifier == "moveToTimeReminder"{
            
            guard let nav = segue.destination as? UINavigationController else {
                fatalError("NavigationController not found")
            }
            
            guard let TimerReminderVC = nav.topViewController as? TimerReminderViewController else {
                fatalError("TimerReminderViewController not found")
            }
        }else if segue.identifier == "moveToLocationReminder"{
            
            guard let nav = segue.destination as? UINavigationController else {
                fatalError("NavigationController not found")
            }
            
            guard let AddProductVC = nav.topViewController as? LocationReminderViewController else {
                fatalError("LocationReminderViewController not found")
            }
        }else if segue.identifier == "goToDetailSkinCareGuide"{
            print(selectedRoutine.name)
            guard let vc = segue.destination as? SkinCareGuideViewController else {
                return
            }
            
            if let routineName = selectedRoutine.name{
                if(routineName == "Morning Skin Care"){
                    //Go to morning skin care
                    vc.skinTypeRoutine = skinTypeRoutine[0]
                }else{
                    //Go to Night Routine
                    vc.skinTypeRoutine = skinTypeRoutine[1]
                }
            }
        }
    }
    
}

extension AddRoutineViewController : UITableViewDelegate, UITableViewDataSource{
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
                if((products[indexPath.row].brand) != nil){
                    if let name = self.products[indexPath.row].name, let brand = self.products[indexPath.row].brand{
                        DispatchQueue.main.async {
                            row.setUIText(title: self.products[indexPath.row].productType ?? "", brand: "\(brand)", desc: "\(name)")
                        }
                    }
                }else{
                    DispatchQueue.main.async {
                        row.setUIText(title: self.products[indexPath.row].name ?? "", brand: "Product Brand", desc: "Add your Product")
                    }
                }
               
                
                if let image = products[indexPath.row].picture{
                        DispatchQueue.main.async {
                            row.setUIImage(image: image, isDone: true)
                        }
                    
                }
            }
            
            
            
            
            print("SELECTED PRODUCT \(self.products[indexPath.row])")
            row.selectedProduct = self.products[indexPath.row]
            row.delegate = self
            
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
            
            return row
        }else if(indexPath.row == products.count + 3){
            //location reminder
            let row = tableView.dequeueReusableCell(withIdentifier: "locationReminderTableViewCell") as! LocationReminderTableViewCell
            
            return row

        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var heightForRow : CGFloat = 0
        
        if(indexPath.row == products.count){
            //button
            heightForRow = 110
        }else if(indexPath.row == products.count + 1){
            //save button
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
            if(!isEdit){
                // MARK: Ketika tidak melakukan edit(dragable or delete)
                print("ADD PRODUCT ROW CLICKED")
                self.selectedProduct = products[indexPath.row]
                performSegue(withIdentifier: "moveToAddProduct", sender: self)
            }else{
                
            }
        }
        
        
    }
    
    
}

extension AddRoutineViewController : AddProductDelegate{
    // MARK: Delegate From ButtonRoutinePageTableViewCell class
    func addNewProduct() {
        self.performSegue(withIdentifier: "moveToAddProduct", sender: self)
    }
}

extension AddRoutineViewController : SaveProductDelegate{
//    func saveProductAndReloadIt(completion: () -> Void) {
//        print("DELEGATE VBERHASIL")
//        checkProduct()
//        DispatchQueue.main.async {
//            self.routineTableView.reloadData()
//        }
//
//    }
    

    
    // MARK: Delegate from AddProductViewController class
    func saveProductAndReloadIt() {
        DispatchQueue.main.async {
            print("checkProduct")
            self.checkProduct()
            print("reload data")
            self.routineTableView.reloadData()
            print("STOP INDICATOR")
            Loading.sharedInstance.hideIndicator()
        }
    }
    
    
}

extension AddRoutineViewController : deleteProductItemDelegate{
    // MARK: Delegate from ProductUsedTableViewCell trash icon
    func deleteProductItem(deletedProduct product: Product) {
        print("DELETE PRODUCT \(product.name)")
//        PersistanceManager.shared.deleteProduct(product: product)
//        DispatchQueue.main.async {
//            self.routineTableView.reloadData()
//        }
    }
}
