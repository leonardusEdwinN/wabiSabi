//
//  RoutineNameTableViewCell.swift
//  WabiSabiTeamProject
//
//  Created by Edwin Niwarlangga on 30/11/21.
//

import UIKit

class RoutineNameTableViewCell: UITableViewCell {

    @IBOutlet weak var routineNameTextField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        routineNameTextField.placeholder = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUI(placeholder : String){
        routineNameTextField.placeholder = placeholder
    }
    
    func setUI(textFieldValue : String){
        routineNameTextField.text = textFieldValue
    }
    
}
