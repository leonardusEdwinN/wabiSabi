//
//  SkinTypeViewController.swift
//  WabiSabiTeamProject
//
//  Created by Giovanni Tjahyamulia on 01/11/21.
//

import UIKit

class SkinTypeViewController: UIViewController {
    @IBOutlet weak var skinTypeTableView: UITableView!
    
    var skinTypes: [SkinType] = [
        SkinType(icon: "", name: "Skin Type", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus luctus tortor sit amet nisl semper iaculis."),
        SkinType(icon: "", name: "Skin Type", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus luctus tortor sit amet nisl semper iaculis."),
        SkinType(icon: "", name: "Skin Type", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus luctus tortor sit amet nisl semper iaculis."),
        SkinType(icon: "", name: "Skin Type", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus luctus tortor sit amet nisl semper iaculis.")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        skinTypeTableView.delegate = self
        skinTypeTableView.dataSource = self
    }

    
    @IBAction func closeSegue(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension SkinTypeViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skinTypes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = skinTypeTableView.dequeueReusableCell(withIdentifier: "skintypecell") as! SkinTypeTableViewCell
        
        // cell.skinTypeIcon.image = UIImage(named: detailDatas[indexPath.row].dataIcon)
        cell.skinTypeName.text = skinTypes[indexPath.row].name
        cell.skinTypeDescription.text = skinTypes[indexPath.row].description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75 + CGFloat((skinTypes[indexPath.row].description.count) / 28) * 20;
    }
}
