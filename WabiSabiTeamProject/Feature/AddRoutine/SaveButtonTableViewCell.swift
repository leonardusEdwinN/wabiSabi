//
//  SaveButtonTableViewCell.swift
//  WabiSabiTeamProject
//
//  Created by Edwin Niwarlangga on 20/11/21.
//

import UIKit
protocol AddRoutineDelegate{
    func addRoutineDidSave()
}

class SaveButtonTableViewCell: UITableViewCell {

    @IBAction func saveButtonPressed(_ sender: Any) {
        delegate?.addRoutineDidSave()
    }
    
    var delegate : AddRoutineDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
