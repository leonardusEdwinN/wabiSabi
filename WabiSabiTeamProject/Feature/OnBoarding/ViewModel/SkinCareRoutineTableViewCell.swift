//
//  SkinCareRoutineTableViewCell.swift
//  WabiSabiTeamProject
//
//  Created by Giovanni Tjahyamulia on 01/11/21.
//

import UIKit

class SkinCareRoutineTableViewCell: UITableViewCell {
    @IBOutlet weak var skincareRoutineBackground: UIView!
    @IBOutlet weak var skincareRoutineChecklist: UIImageView!
    @IBOutlet weak var skincareRoutineTitle: UILabel!
    @IBOutlet weak var skincareRoutineDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if(selected) {
            skincareRoutineBackground.backgroundColor = UIColor(named: "ColorPrimary")
            skincareRoutineChecklist.image = UIImage(systemName: "checkmark.circle.fill")
        } else {
            skincareRoutineBackground.backgroundColor = UIColor(named: "ColorSecondary")
            skincareRoutineChecklist.image = UIImage(systemName: "circle")
        }
    }
}


