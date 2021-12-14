//
//  ImportProductViewController.swift
//  WabiSabiTeamProject
//
//  Created by Edwin Niwarlangga on 27/11/21.
//

import Foundation
import UIKit

class ImportProductViewController : UIViewController{
    // MARK: UIComponent
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func saveButtonPressed(_ sender: Any) {
        DispatchQueue.main.async {
            Loading.sharedInstance.showIndicator()
        }
        
        print("STATUS : \(selectedRoutineToImport.name)")
        for product in products{
            //get data to be imported
            print("STATUS : \(product.isSelected)")
            if(product.isSelected){
                selectedToBeImported.append(product)
            }
        }
        
        for insertData in selectedToBeImported{
            
            if let name = insertData.name,
               let brand = insertData.brand,
               let productType = insertData.productType,
               let expiredDate = insertData.expiredDate,
               let periodAfterOpen = insertData.periodAfterOpening,
               let image = insertData.picture{
                
                print("name : \(name), brand : \(brand), product type:\(productType), expdate: \(expiredDate), pao: \(periodAfterOpen)")
                PersistanceManager.shared.setProduct(brand: brand, expiredDate: expiredDate, name: name, periodAfterOpening: periodAfterOpen, picture: image, routine: selectedRoutineToImport, productType: productType, isDone: false)
            }
        }
        
       
        
//        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: {
//            self.presentingViewController.
//        })
        
//        let storyboard = UIStoryboard(name: "AddRoutine", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "addRoutineNVC") as! UINavigationController
//        vc.modalPresentationStyle = .fullScreen
//
//        guard let routineVC = vc.topViewController as? AddRoutineViewController else {
//           return
//        }
//        routineVC.selectedRoutine = selectedRoutineToImport
//        self.present(vc, animated: true, completion: nil)

        
        self.view.window!.rootViewController?.dismiss(animated: false,completion: {
            DispatchQueue.main.async {
                Loading.sharedInstance.hideIndicator()
            }

            self.performSegue(withIdentifier: "moveToRoutinePage", sender: self)
        })
//
        
        
        
    }
    
    @IBOutlet weak var productListTableView: UITableView!
    
    // MARK: variable
    var selectedRoutineToImport: Routines! // Routine yang akan di import datanya
    var selectedImportRoutineFrom : Routines! // Routine yang akan di ambil datanya
    var products: [Product] = []
    var selectedToBeImported : [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProduct()
        registerCell()
    }
    
    func fetchProduct(){
        self.products = PersistanceManager.shared.fetchProduct(routine: selectedImportRoutineFrom)
    }
    
    func registerCell(){
        productListTableView.register(UINib.init(nibName: "ProductUsedTableViewCell", bundle: nil), forCellReuseIdentifier: "productUsedTableViewCell")
        
        productListTableView.delegate = self
        productListTableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let nav = segue.destination as? UINavigationController else {
            return
        }
        
        guard let addRoutineVC = nav.topViewController as? AddRoutineViewController else {
            return
        }
        
        addRoutineVC.selectedRoutine = selectedRoutineToImport
        nav.modalPresentationStyle = .fullScreen
    }
}

extension ImportProductViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = tableView.dequeueReusableCell(withIdentifier: "productUsedTableViewCell") as! ProductUsedTableViewCell
        
        products[indexPath.row].isSelected ? row.setStatusDone() : row.setStatusUndone()
        
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
                row.setUIImage(image: image)
            }
            
        }
        print("SELECTED PRODUCT \(self.products[indexPath.row])")
        row.selectedProduct = self.products[indexPath.row]
        row.selectedIndexPath = indexPath
        
        return row
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var heightForRow : CGFloat = 0
        
        heightForRow = 100
        
        return heightForRow
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = tableView.dequeueReusableCell(withIdentifier: "productUsedTableViewCell") as! ProductUsedTableViewCell
        if(products[indexPath.row].isSelected){
            //di uncheck
            
            row.setStatusUndone()
            if let id = self.products[indexPath.row].id{
                //update data status
                PersistanceManager.shared.changeIsSelectedProductToBeImported(id: id, isSelected: false)
            }
            
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }else{
            // di check
            
            row.setStatusDone()
            if let id = self.products[indexPath.row].id{
                //update data status
                PersistanceManager.shared.changeIsSelectedProductToBeImported(id: id, isSelected: true)
            }
            
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
    
    }
    
}
