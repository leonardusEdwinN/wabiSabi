//
//  SubcategoryCollectionViewCell.swift
//  WabiSabiTeamProject
//
//  Created by Giovanni Tjahyamulia on 23/11/21.
//

import UIKit

class SubcategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var habitNameLabel: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let whiteGradient = CAGradientLayer()
        whiteGradient.colors = [UIColor(red: 1, green: 1, blue: 1, alpha: 0.8).cgColor, UIColor(red: 1, green: 1, blue: 1, alpha: 0.4).cgColor]
        whiteGradient.locations = [0.0, 1.0]
        whiteGradient.borderColor = UIColor.white.cgColor
        whiteGradient.borderWidth = 2
        whiteGradient.cornerRadius = 15
        whiteGradient.frame.size = CGSize(width: 180, height: 120)
        self.layer.insertSublayer(whiteGradient, at:0)
        
        
    }

}
