//
//  SelectWeekTableViewCell.swift
//  WabiSabiTeamProject
//
//  Created by Edwin Niwarlangga on 30/11/21.
//

import UIKit

protocol SelectDayOfTheWeekDelegate{
    func didTapSelectWeek(dayOfTheWeek : String, isSelected: Bool)
}

class SelectWeekTableViewCell: UITableViewCell {
    
    var delegate : SelectDayOfTheWeekDelegate?
    
    @IBOutlet weak var buttonMonday: UIButton!
    @IBAction func buttonMondayPressed(_ sender: Any) {
        buttonMonday.isSelected = !buttonMonday.isSelected
//        if(buttonMonday.isSelected){
        delegate?.didTapSelectWeek(dayOfTheWeek: "Monday", isSelected: buttonMonday.isSelected)
//        }
    }
    @IBOutlet weak var buttonTuesday: UIButton!
    @IBAction func buttonTuesdayPressed(_ sender: Any) {
        buttonTuesday.isSelected = !buttonTuesday.isSelected
        delegate?.didTapSelectWeek(dayOfTheWeek: "Tuesday", isSelected: buttonTuesday.isSelected)
//        if(buttonTuesday.isSelected){
//            delegate?.didTapSelectWeek(dayOfTheWeek: "Tuesday")
//        }
    }
    @IBOutlet weak var buttonWednesday: UIButton!
    @IBAction func buttonWednesdayPressed(_ sender: Any) {
        buttonWednesday.isSelected = !buttonWednesday.isSelected
        delegate?.didTapSelectWeek(dayOfTheWeek: "Wednesday", isSelected: buttonWednesday.isSelected)
//        if(buttonWednesday.isSelected){
//            delegate?.didTapSelectWeek(dayOfTheWeek: "Wednesday")
//        }
    }
    @IBOutlet weak var buttonThursday: UIButton!
    @IBAction func buttonThursdayPressed(_ sender: Any) {
        buttonThursday.isSelected = !buttonThursday.isSelected
        delegate?.didTapSelectWeek(dayOfTheWeek: "Thursday", isSelected: buttonThursday.isSelected)
//        if(buttonThursday.isSelected){
//            delegate?.didTapSelectWeek(dayOfTheWeek: "Thursday")
//        }
    }
    @IBOutlet weak var buttonFriday: UIButton!
    @IBAction func buttonFridayPressed(_ sender: Any) {
        buttonFriday.isSelected = !buttonFriday.isSelected
        delegate?.didTapSelectWeek(dayOfTheWeek: "Friday", isSelected: buttonFriday.isSelected)
//        if(buttonFriday.isSelected){
//            delegate?.didTapSelectWeek(dayOfTheWeek: "Friday")
//        }
    }
    @IBOutlet weak var buttonSaturday: UIButton!
    @IBAction func buttonSaturdayPressed(_ sender: Any) {
        buttonSaturday.isSelected = !buttonSaturday.isSelected
        delegate?.didTapSelectWeek(dayOfTheWeek: "Saturday", isSelected: buttonSaturday.isSelected)
//        if(buttonSaturday.isSelected){
//            delegate?.didTapSelectWeek(dayOfTheWeek: "Saturday")
//        }
    }
    @IBOutlet weak var buttonSunday: UIButton!
    @IBAction func buttonSundayPressed(_ sender: Any) {
        buttonSunday.isSelected = !buttonSunday.isSelected
        delegate?.didTapSelectWeek(dayOfTheWeek: "Sunday", isSelected: buttonSunday.isSelected)
//        if(buttonSunday.isSelected){
//            delegate?.didTapSelectWeek(dayOfTheWeek: "Sunday")
//        }
    }
    @IBOutlet weak var buttonEveryday: UIButton!
    @IBAction func buttonEverydayPressed(_ sender: Any) {
        
        buttonEveryday.isSelected = !buttonEveryday.isSelected
        delegate?.didTapSelectWeek(dayOfTheWeek: "All", isSelected: buttonEveryday.isSelected)
//        if(buttonEveryday.isSelected){
//            delegate?.didTapSelectWeek(dayOfTheWeek: "All")
//        }
        
        if(buttonEveryday.isSelected){
            buttonMonday.isSelected = true
            buttonTuesday.isSelected = true
            buttonWednesday.isSelected = true
            buttonThursday.isSelected = true
            buttonFriday.isSelected = true
            buttonSaturday.isSelected = true
            buttonSunday.isSelected = true
        }else{
            buttonMonday.isSelected = false
            buttonTuesday.isSelected = false
            buttonWednesday.isSelected = false
            buttonThursday.isSelected = false
            buttonFriday.isSelected = false
            buttonSaturday.isSelected = false
            buttonSunday.isSelected = false
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
