//
//  SkinCareGuideViewController.swift
//  WabiSabiTeamProject
//
//  Created by Giovanni Tjahyamulia on 02/11/21.
//

import UIKit

class SkinCareGuideViewController: UIViewController {

    @IBOutlet weak var skinCareGuideTitle: UILabel!
    @IBOutlet weak var skincareRoutineTitle: UILabel!
    @IBOutlet weak var skincareProductTableView: UITableView!
    
    var skinTypeIndex: Int = 0;
    var levelIndex: Int = 0;
    
    var skinTypeRoutine: SkinRoutineProduct!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        skincareProductTableView.delegate = self
        skincareProductTableView.dataSource = self
        
        skinTypeIndex = UserDefaults.standard.integer(forKey: "skinTypes")
        levelIndex = UserDefaults.standard.integer(forKey: "levelIndex")
        
        skincareRoutineTitle.text = skinTypeRoutine.name
        
        skinCareGuideTitle.font = UIFont.boldSystemFont(ofSize: 28)
    }

    
    @IBAction func closeSegue(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension SkinCareGuideViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skinTypeRoutine.products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = skincareProductTableView.dequeueReusableCell(withIdentifier: "skincareproductscell") as! SkinCareGuideTableViewCell
        
        let data = skinTypeRoutine.products[indexPath.row]
        
        // cell.skinCareProductIcon.image = UIImage(named: data.icon)
        cell.skinCareProductName.text = data.name
        cell.skinCareProductDescription.text = data.description
        
        return cell
    }
    
    /*
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75 + CGFloat((skinTypeRoutine.products[indexPath.row].description.count) / 28) * 18;
    }
    */
}
