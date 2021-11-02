//
//  GenderTableViewCell.swift
//  WabiSabiTeamProject
//
//  Created by Giovanni Tjahyamulia on 01/11/21.
//

import UIKit

class GenderTableViewCell: UITableViewCell {
    @IBOutlet weak var genderBackground: UIView!
    @IBOutlet weak var genderCheckList: UIImageView!
    @IBOutlet weak var genderLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if(selected) {
            genderBackground.backgroundColor = UIColor(named: "ColorPrimary")
            genderCheckList.image = UIImage(systemName: "checkmark.circle.fill")
        } else {
            genderBackground.backgroundColor = UIColor(named: "ColorSecondary")
            genderCheckList.image = UIImage(systemName: "circle")
        }
    }

}
