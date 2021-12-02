//
//  RoutineNameTableViewCell.swift
//  WabiSabiTeamProject
//
//  Created by Edwin Niwarlangga on 30/11/21.
//

import UIKit
protocol TextfieldCellGetName{
    func getValueInsideTextfield(for textfield : String)
}

class RoutineNameTableViewCell: UITableViewCell, UITextFieldDelegate {

    var delegate : TextfieldCellGetName?
    @IBOutlet weak var routineNameTextField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        routineNameTextField.placeholder = ""
        routineNameTextField.delegate = self
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        print("TEXTFIELD : \(textField.text)")
        
        delegate?.getValueInsideTextfield(for: textField.text ?? "")
        
        
        
       textField.resignFirstResponder()
       return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("TEXTFIELD END EDITING : \(textField.text)")
        delegate?.getValueInsideTextfield(for: textField.text ?? "")
        textField.resignFirstResponder()
    }
    
}
