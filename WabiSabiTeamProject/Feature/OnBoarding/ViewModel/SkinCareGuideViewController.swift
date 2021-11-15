//
//  SkinCareGuideViewController.swift
//  WabiSabiTeamProject
//
//  Created by Giovanni Tjahyamulia on 02/11/21.
//

import UIKit

class SkinCareGuideViewController: UIViewController {

    @IBOutlet weak var skincareRoutineTitle: UILabel!
    @IBOutlet weak var skincareProductTableView: UITableView!
    
    let skinTypeRoutineProduct: [SkinTypeRoutine] = [
        SkinTypeRoutine(icon: "🌞", name: "Morning Skin Care", skinType: [
            SkinTypeProduct(name: "Oily", products: [
                SkinCareProduct(icon: "", name: "Cleanser", description: "Gel/Foam Cleanser that contain salicylic/glycolic acid"),
                SkinCareProduct(icon: "", name: "Toner", description: "Avoid alcohol based toner"),
                SkinCareProduct(icon: "", name: "Serum", description: "Antioxidant Serum"),
                SkinCareProduct(icon: "", name: "Sunscreen", description: "Zinc Oxide")
            ]),
            SkinTypeProduct(name: "Dry", products: [
                SkinCareProduct(icon: "", name: "Cleanser", description: "Micellar water/cream Cleanser with humectants such as hyaluronic acid and glycerin"),
                SkinCareProduct(icon: "", name: "Toner", description: "Avoid alcohol based toner"),
                SkinCareProduct(icon: "", name: "Serum", description: "Antioxidant Serum"),
                SkinCareProduct(icon: "", name: "Sunscreen", description: "Moisturizer with SPF")
            ]),
            SkinTypeProduct(name: "Combination", products: [
                SkinCareProduct(icon: "", name: "Cleanser", description: "Gel/Foam Cleanser"),
                SkinCareProduct(icon: "", name: "Toner", description: "Avoid alcohol based toner"),
                SkinCareProduct(icon: "", name: "Moisturizer", description: "Lightweight"),
                SkinCareProduct(icon: "", name: "Sunscreen", description: "Zinc Oxide")
            ]),
            SkinTypeProduct(name: "Normal", products: [
                SkinCareProduct(icon: "", name: "Cleanser", description: "Micellar Water, Gel, Oil, or Cream Cleanser with Hyaluronic Acid to keep the complexion youthful and glowing"),
                SkinCareProduct(icon: "", name: "Toner", description: "Avoid alcohol based toner"),
                SkinCareProduct(icon: "", name: "Moisturizer", description: "Moisturizer with SPF")
            ])
        ]),
        SkinTypeRoutine(icon: "🌓", name: "Night Skin Care", skinType: [
            SkinTypeProduct(name: "Oily", products: [
                SkinCareProduct(icon: "", name: "Cleanser", description: "Gel/Foam Cleanser that contain salicylic/glycolic acid"),
                SkinCareProduct(icon: "", name: "Toner", description: "Avoid alcohol based toner"),
                SkinCareProduct(icon: "", name: "Serum", description: "AHA/BHA, Retinol"),
                SkinCareProduct(icon: "", name: "Moisturizer", description: "Oil-Free Water-Based"),
                SkinCareProduct(icon: "", name: "Extras", description: "Clay Mask, Face Oil")
            ]),
            SkinTypeProduct(name: "Dry", products: [
                SkinCareProduct(icon: "", name: "Cleanser", description: "Micellar water/cream Cleanser with humectants such as hyaluronic acid and glycerin"),
                SkinCareProduct(icon: "", name: "Toner", description: "Avoid alcohol based toner"),
                SkinCareProduct(icon: "", name: "Serum", description: "Retinol Serum"),
                SkinCareProduct(icon: "", name: "Moisturizer", description: "Hydrating Moisturizer"),
                SkinCareProduct(icon: "", name: "Extras", description: "At-Home Peel, Face Oil")
            ]),
            SkinTypeProduct(name: "Combination", products: [
                SkinCareProduct(icon: "", name: "Cleanser", description: "Gel/Foam Cleanser"),
                SkinCareProduct(icon: "", name: "Toner", description: "Avoid alcohol based toner"),
                SkinCareProduct(icon: "", name: "Serum", description: "AHA/BHA, Retinol"),
                SkinCareProduct(icon: "", name: "Moisturizer", description: "Lightweight"),
                SkinCareProduct(icon: "", name: "Extras", description: "Clay Mask, Face Oil")
            ]),
            SkinTypeProduct(name: "Normal", products: [
                SkinCareProduct(icon: "", name: "Cleanser", description: "Micellar Water, Gel, Oil, or Cream Cleanser with Hyaluronic Acid to keep the complexion youthful and glowing"),
                SkinCareProduct(icon: "", name: "Toner", description: "Avoid alcohol based toner"),
                SkinCareProduct(icon: "", name: "Serum", description: "Antioxidant"),
                SkinCareProduct(icon: "", name: "Moisturizer", description: "Moisturizer"),
                SkinCareProduct(icon: "", name: "Extras", description: "Glycolic Acid Serum")
            ])
        ])
    ]
    
    var indexSelected: Int = 0;
    var skinTypeIndex: Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        skincareProductTableView.delegate = self
        skincareProductTableView.dataSource = self
        
        skinTypeIndex = UserDefaults.standard.integer(forKey: "skinTypes")
        
        skincareRoutineTitle.text = skinTypeRoutineProduct[indexSelected].name
    }

    
    @IBAction func closeSegue(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension SkinCareGuideViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skinTypeRoutineProduct[indexSelected].skinType[skinTypeIndex].products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = skincareProductTableView.dequeueReusableCell(withIdentifier: "skincareproductscell") as! SkinCareGuideTableViewCell
        
        // cell.skinCareProductIcon.image = UIImage(named: dataSources[indexSelected].detailDatas[indexPath.row].dataIcon)
        cell.skinCareProductName.text = skinTypeRoutineProduct[indexSelected].skinType[skinTypeIndex].products[indexPath.row].name
        cell.skinCareProductDescription.text = skinTypeRoutineProduct[indexSelected].skinType[skinTypeIndex].products[indexPath.row].description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75 + CGFloat((skinTypeRoutineProduct[indexSelected].skinType[skinTypeIndex].products[indexPath.row].description.count) / 28) * 18;
    }
}
