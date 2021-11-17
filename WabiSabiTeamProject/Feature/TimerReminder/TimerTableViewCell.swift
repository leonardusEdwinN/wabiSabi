//
//  TimerTableViewCell.swift
//  WabiSabiTeamProject
//
//  Created by Edwin Niwarlangga on 16/11/21.
//

import UIKit

class TimerTableViewCell: UITableViewCell {

    @IBOutlet weak var imageTimer: UIImageView!
    @IBOutlet weak var labelAlarm: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setUI(title : String, image: UIImage){
        labelAlarm.text = title
    }
    
}
