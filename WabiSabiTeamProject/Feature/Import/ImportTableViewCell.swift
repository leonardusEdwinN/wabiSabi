//
//  ImportTableViewCell.swift
//  WabiSabiTeamProject
//
//  Created by Edwin Niwarlangga on 27/11/21.
//

import UIKit

class ImportTableViewCell: UITableViewCell {

    @IBOutlet weak var routineNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUI(setTitle title: String){
        routineNameLabel.text = title
    }
    
}
