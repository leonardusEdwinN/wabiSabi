//
//  ResultViewController.swift
//  WabiSabiTeamProject
//
//  Created by Giovanni Tjahyamulia on 01/11/21.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var skinCareRoutineCollectionView: UICollectionView!
    
    let levels: [String] = ["Beginner", "Beginner", "Intermediate", "Advance"]
    
    var skinTypeIndex: Int = 0
    var skinCareRoutineIndex: Int = 0
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        skinCareRoutineCollectionView.delegate = self
        skinCareRoutineCollectionView.dataSource = self
        
        skinTypeIndex = UserDefaults.standard.integer(forKey: "skinTypes")
        skinCareRoutineIndex = UserDefaults.standard.integer(forKey: "skinCareRoutines")
        
        levelLabel.text = "Level:  \(levels[skinCareRoutineIndex])"
    }
}

extension ResultViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return skinTypeRoutineProduct.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = skinCareRoutineCollectionView.dequeueReusableCell(withReuseIdentifier: "skincareroutinecell", for: indexPath) as! SkinCareRoutineCollectionViewCell
        
        var data = skinTypeRoutineProduct[indexPath.row]
        cell.skinCareRoutineIconLabel.text = data.icon
        cell.skinCareRoutineNameLabel.text = data.name
        cell.skinCareRoutineProductLabel.text = "\(data.skinType[skinTypeIndex].products.count) products"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "OnBoarding", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SkinCareGuide") as! SkinCareGuideViewController
        vc.indexSelected = indexPath.row
        
        self.show(vc, sender: nil)
    }
}
