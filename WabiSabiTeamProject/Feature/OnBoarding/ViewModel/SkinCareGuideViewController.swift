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
    
    var indexSelected: Int = 0;
    
    var skinCareRoutineProducts: [SkinCareRoutineProduct] = [
        SkinCareRoutineProduct(name: "Morning Skin Care", products: [
                SkinCareProduct(icon: "", name: "Cleanser", description: "A gel, cream, or oil cleanser will be fine for a normal skin type.\n✔️ gentle cleanser\n✔️ lukewarm water\n✖️ avoid alcohol"),
                SkinCareProduct(icon: "", name: "Toner", description: "Avoid alcohol based toner"),
                SkinCareProduct(icon: "", name: "Moisturizer", description: "Use gel-based or a rich cream moisturizer."),
                SkinCareProduct(icon: "", name: "Sunscreen", description: "Choose a sunscreen with SPF 30+. Use sun protection to help prevent wrinkles, age spots, and skin cancer")
            ]
        ),
        SkinCareRoutineProduct(name: "Night Skin Care", products: [
            SkinCareProduct(icon: "", name: "Makeup Removal", description: "Use a. gentle makeup remover. Resist the temptation to rub your skin because rubbing irritates the skin."),
            SkinCareProduct(icon: "", name: "Cleanser", description: "Use a gentle, non-abrasive cleaner that does not contain alcohol. A cleanser helps remove excess oil and impurities from your face and keeps your pores unclogged."),
            SkinCareProduct(icon: "", name: "Toner", description: "Use a toner for your skin type to balance your skin and prepare it for moisturizing. Avoid alcohol-based toner."),
            SkinCareProduct(icon: "", name: "Moisturizer/Night Cream", description: "Apply a water-based moisturizer or night cream. It should be lightweight and absorb quickly.")
            ]
        )
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        skincareProductTableView.delegate = self
        skincareProductTableView.dataSource = self
        
        skincareRoutineTitle.text = skinCareRoutineProducts[indexSelected].name
    }

    
    @IBAction func closeSegue(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension SkinCareGuideViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skinCareRoutineProducts[indexSelected].products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = skincareProductTableView.dequeueReusableCell(withIdentifier: "skincareproductscell") as! SkinCareGuideTableViewCell
        
        // cell.skinCareProductIcon.image = UIImage(named: dataSources[indexSelected].detailDatas[indexPath.row].dataIcon)
        cell.skinCareProductName.text = skinCareRoutineProducts[indexSelected].products[indexPath.row].name
        cell.skinCareProductDescription.text = skinCareRoutineProducts[indexSelected].products[indexPath.row].description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75 + CGFloat((skinCareRoutineProducts[indexSelected].products[indexPath.row].description.count) / 28) * 18;
    }
}
