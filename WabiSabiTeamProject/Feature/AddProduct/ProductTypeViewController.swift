//
//  ProductTypeViewController.swift
//  WabiSabiTeamProject
//
//  Created by Edwin Niwarlangga on 16/11/21.
//

import Foundation
import UIKit

//productTypeTableViewCell

class ProductTypeViewController : UIViewController{
    @IBOutlet weak var productTypeTableView: UITableView!
    @IBOutlet weak var labelTitlePage: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        productTypeTableView.delegate = self
        productTypeTableView.dataSource = self
        
        productTypeTableView.register(UINib.init(nibName: "ProductTypeTableViewCell", bundle: nil), forCellReuseIdentifier: "productTypeTableViewCell")
    }
}

extension ProductTypeViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = tableView.dequeueReusableCell(withIdentifier: "productTypeTableViewCell") as! ProductTypeTableViewCell
        
        return row
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("CLICKED : \(indexPath.item)")
        
        
        self.dismiss(animated: false, completion: nil)
    }
    
}
