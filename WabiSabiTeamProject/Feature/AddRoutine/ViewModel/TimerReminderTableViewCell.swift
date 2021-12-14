//
//  TimerReminderTableViewCell.swift
//  WabiSabiTeamProject
//
//  Created by Edwin Niwarlangga on 15/11/21.
//

import UIKit

class TimerReminderTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTimer: UILabel!
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
    
    func setUI(counTimerText : String){
        labelTimer.text = counTimerText
        
    }
}
