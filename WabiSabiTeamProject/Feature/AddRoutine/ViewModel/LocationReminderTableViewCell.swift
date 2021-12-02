//
//  LocationReminderTableViewCell.swift
//  WabiSabiTeamProject
//
//  Created by Edwin Niwarlangga on 15/11/21.
//

import UIKit

class LocationReminderTableViewCell: UITableViewCell {

    @IBOutlet weak var viewRounded: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewRounded.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
