//
//  ProductTypeViewController.swift
//  WabiSabiTeamProject
//
//  Created by Edwin Niwarlangga on 16/11/21.
//

import Foundation
import UIKit

//productTypeTableViewCell
protocol SelectProductTypeDelegate {
    func selectProductTypeCell(productType : String, indexPath : IndexPath)
}

class ProductTypeViewController : UIViewController{
    
    // MARK: UIComponent
    @IBOutlet weak var productTypeTableView: UITableView!
    @IBAction func saveButtonPressed(_ sender: Any) {
        delegate?.selectProductTypeCell(productType: selectedItem, indexPath: indexPathSelected)
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    // MARK: Variable
    var productTypeArray: [ProductTypeModel] = []
    var delegate: SelectProductTypeDelegate?
    var selectedItem : String = ""
    var indexPathSelected: IndexPath = IndexPath(row: 0, section: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        
    }
    
    
    func setTableView(){
        
        productTypeTableView.delegate = self
        productTypeTableView.dataSource = self
        
        productTypeTableView.register(UINib.init(nibName: "ProductTypeTableViewCell", bundle: nil), forCellReuseIdentifier: "productTypeTableViewCell")
    }
    
}

extension ProductTypeViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productTypeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = tableView.dequeueReusableCell(withIdentifier: "productTypeTableViewCell") as! ProductTypeTableViewCell
        
        row.textLabel?.text = productTypeArray[indexPath.row].name
        if(productTypeArray[indexPath.row].isSelected){
            row.accessoryType = .checkmark
        }else{
            row.accessoryType = .none
        }
        
        return row
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // uncheck all cells
        tableView.visibleCells.forEach { cell in
            cell.accessoryType = .none
        }
        
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            selectedItem = productTypeArray[indexPath.row].name
            indexPathSelected = indexPath
            
//            let unit = Unit.allCases[indexPath.row]
//            settingsViewModel.selectedUnit = unit
        }
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if(productTypeArray[indexPath.row].isSelected){
//            row.accessoryType = .checkmark
//        }else{
//            row.accessoryType = .none
//        }
//    }
    
    
}
