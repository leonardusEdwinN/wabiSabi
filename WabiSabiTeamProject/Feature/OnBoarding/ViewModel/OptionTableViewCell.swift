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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if(selected) {
            optionBackgroundView.backgroundColor = UIColor(named: "ColorPrimary")
            optionChecklist.image = UIImage(systemName: "checkmark.circle.fill")
        } else {
            optionBackgroundView.backgroundColor = UIColor(named: "ColorSecondary")
            optionChecklist.image = UIImage(systemName: "circle")
        }
    }
}


