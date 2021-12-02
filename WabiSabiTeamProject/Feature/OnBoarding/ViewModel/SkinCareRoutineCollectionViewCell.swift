//
//  SkinCareRoutineCollectionViewCell.swift
//  WabiSabiTeamProject
//
//  Created by Giovanni Tjahyamulia on 01/11/21.
//

import UIKit

class SkinCareRoutineCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var skinCareRoutineBackground: UIView!
    @IBOutlet weak var skinCareRoutineIconLabel: UILabel!
    @IBOutlet weak var skinCareRoutineNameLabel: UILabel!
    @IBOutlet weak var skinCareRoutineProductLabel: UILabel!
    
    override func awakeFromNib() {
        var whiteGradientBackground = CAGradientLayer()
        whiteGradientBackground.colors = [UIColor(red: 1, green: 1, blue: 1, alpha: 0.8).cgColor, UIColor(red: 1, green: 1, blue: 1, alpha: 0.4).cgColor]
        whiteGradientBackground.locations = [0.0, 1.0]
        whiteGradientBackground.cornerRadius = 15
        whiteGradientBackground.borderColor = UIColor.white.cgColor
        whiteGradientBackground.borderWidth = 2
        whiteGradientBackground.frame.size = CGSize(width: 140, height: 170)
        
        self.skinCareRoutineBackground.layer.insertSublayer(whiteGradientBackground, at:0)
        
    }
}
