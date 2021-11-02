//
//  SkinTypeQuestionViewController.swift
//  WabiSabiTeamProject
//
//  Created by Giovanni Tjahyamulia on 28/10/21.
//

import UIKit

class QuestionSkinTypeViewController: UIViewController {
    @IBOutlet weak var skinTypeColletionView: UICollectionView!
    @IBOutlet weak var buttonNext: UIButton!
    
    var skinTypes: [String] = ["Oily", "Dry", "Combination", "Normal"]
    
    var indexSelected: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        skinTypeColletionView.delegate = self
        skinTypeColletionView.dataSource = self
        
        buttonNext.isHidden = true
    }
    
    @IBAction func next(_ sender: Any) {
        UserDefaults.standard.set(skinTypes[(indexSelected - 1)], forKey: "skinTypes")
    }
}

extension QuestionSkinTypeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return skinTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = skinTypeColletionView.dequeueReusableCell(withReuseIdentifier: "skintypeoptioncell", for: indexPath) as! SkinTypeCollectionViewCell
        
        cell.skinTypeLabel.text = skinTypes[indexPath.row]

        cell.skinTypeCheckList.tag = (indexPath.row + 1)
        cell.skinTypeImageBackground.tag = ((indexPath.row + 1) * 10) + (indexPath.row + 1)
        cell.skinTypeImageBackground.backgroundColor = UIColor(named: "ColorPrimary")
        cell.skinTypeImageBackground.alpha = 0.5
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // return CGSize(width: view.frame.width / 3, height: view.frame.height / 3)
        return CGSize(width: 100, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if buttonNext.isHidden == true {
            buttonNext.isHidden = false
        }
        
        indexSelected = indexPath.row + 1
        
        for index in 0...skinTypes.count {
            if let imgView = collectionView.viewWithTag(index) as? UIImageView {
                imgView.image = UIImage(systemName: "circle")
            }
            if let backgroundView = collectionView.viewWithTag((index * 10) + index) as? UIImageView {
                // backgroundView.backgroundColor = UIColor(named: "ColorSecondary")
                backgroundView.alpha = 0.5
            }
        }
        
        if let imgView = collectionView.viewWithTag(indexSelected) as? UIImageView {
            imgView.image = UIImage(systemName: "checkmark.circle.fill")
        }
        if let backgroundView = collectionView.viewWithTag((indexSelected * 10) + indexSelected) as? UIImageView {
            // backgroundView.backgroundColor = UIColor(named: "ColorPrimary")
            backgroundView.alpha = 1
        }
    }
}
