//
//  StartHabitTableViewCell.swift
//  WabiSabiTeamProject
//
//  Created by Edwin Niwarlangga on 30/11/21.
//

import UIKit
protocol DidSelectButtonAtStartHabitDelegate{
    func didtapTodayButton()
    func didtapTommorowButton()
    func didtapCustomButton()
}


class StartHabitTableViewCell: UITableViewCell {
    // MARK: UIComponent
    
    @IBAction func buttonCustomPressed(_ sender: Any) {
        buttonTommorow.isSelected = false
        buttonToday.isSelected = false
        buttonCustom.isSelected = true
        delegate?.didtapCustomButton()
    }
    @IBOutlet weak var buttonCustom: UIButton!
    @IBAction func buttonTommorowPressed(_ sender: Any) {
        buttonTommorow.isSelected = true
        buttonToday.isSelected = false
        buttonCustom.isSelected = false
        delegate?.didtapTommorowButton()
    }
    @IBOutlet weak var buttonTommorow: UIButton!
    @IBAction func buttonTodayPressed(_ sender: Any) {
        buttonTommorow.isSelected = false
        buttonToday.isSelected = true
        buttonCustom.isSelected = false
        delegate?.didtapTodayButton()
    }
    @IBOutlet weak var buttonToday: UIButton!
    
    // MARK: Varable
    var delegate : DidSelectButtonAtStartHabitDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        buttonToday.isSelected = true
        buttonCustom.isSelected = false
        buttonTommorow.isSelected = false
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
