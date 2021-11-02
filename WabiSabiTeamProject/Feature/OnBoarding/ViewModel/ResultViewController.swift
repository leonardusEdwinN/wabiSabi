//
//  ResultViewController.swift
//  WabiSabiTeamProject
//
//  Created by Giovanni Tjahyamulia on 01/11/21.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var skinCareRoutineCollectionView: UICollectionView!
    
    let skincareroutines: [SkinCareRoutine] = [
        SkinCareRoutine(icon: "🌞", name: "Morning Skin Care", product: 4),
        SkinCareRoutine(icon: "🌓", name: "Night Skin Care", product: 4)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        skinCareRoutineCollectionView.delegate = self
        skinCareRoutineCollectionView.dataSource = self
    }
}

extension ResultViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return skincareroutines.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = skinCareRoutineCollectionView.dequeueReusableCell(withReuseIdentifier: "skincareroutinecell", for: indexPath) as! SkinCareRoutineCollectionViewCell
        
        var data = skincareroutines[indexPath.row]
        cell.skinCareRoutineIconLabel.text = data.icon
        cell.skinCareRoutineNameLabel.text = data.name
        cell.skinCareRoutineProductLabel.text = "\(data.product) products"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "OnBoarding", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SkinCareGuide") as! SkinCareGuideViewController
        vc.indexSelected = indexPath.row
        
        self.show(vc, sender: nil)
    }
}
