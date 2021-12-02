//
//  SummaryActivityEmptyStateTableViewCell.swift
//  WabiSabiTeamProject
//
//  Created by Edwin Niwarlangga on 09/11/21.
//

import UIKit

class SummaryActivityEmptyStateTableViewCell: UITableViewCell {

    @IBOutlet weak var shadowView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        shadowView.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
