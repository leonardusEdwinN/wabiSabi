//
//  SkinCareRoutineTableViewCell.swift
//  WabiSabiTeamProject
//
//  Created by Giovanni Tjahyamulia on 01/11/21.
//

import UIKit

class OptionTableViewCell: UITableViewCell {
    @IBOutlet weak var optionBackgroundView: UIView!
    @IBOutlet weak var optionChecklist: UIImageView!
    @IBOutlet weak var optionTitle: UILabel!
    
    var whiteGradientBackground: CAGradientLayer!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }
    
    func setUI(){
        optionBackgroundView.layer.borderColor = UIColor(named: "ColorSecondary")?.cgColor
        optionBackgroundView.layer.borderWidth = 2
        
        whiteGradientBackground = CAGradientLayer()
        whiteGradientBackground.colors = [UIColor(red: 1, green: 1, blue: 1, alpha: 0.8).cgColor, UIColor(red: 1, green: 1, blue: 1, alpha: 0.4).cgColor]
        whiteGradientBackground.locations = [0.0, 1.0]
        whiteGradientBackground.cornerRadius = 15
        whiteGradientBackground.borderColor = UIColor.white.cgColor
        whiteGradientBackground.borderWidth = 2
        // whiteGradientBackground.frame = CGRect(x: 0, y: 0, width: optionBackgroundView.frame.width, height: optionBackgroundView.frame.height)
        optionBackgroundView.layer.addSublayer(whiteGradientBackground)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if(selected) {
            optionChecklist.image = UIImage(systemName: "checkmark.circle.fill")
            optionChecklist.tintColor = UIColor.white
            optionTitle.textColor = UIColor.white
            
            optionBackgroundView.backgroundColor = UIColor(named: "ColorPrimary")
            optionBackgroundView.layer.borderWidth = 2
            
            whiteGradientBackground.removeFromSuperlayer()
            
        } else {
            optionChecklist.image = UIImage(systemName: "circle")
            optionChecklist.tintColor = UIColor.black
            optionTitle.textColor = UIColor.black
            
            optionBackgroundView.backgroundColor = .clear
            optionBackgroundView.layer.borderWidth = 0
            
            // whiteGradientBackground.frame = CGRect(x: 0, y: 0, width: optionBackgroundView.frame.width, height: optionBackgroundView.frame.height)
            
            optionBackgroundView.layer.addSublayer(whiteGradientBackground)
        }
    }
}


