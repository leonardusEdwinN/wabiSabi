//
//  ProductHeaderTableViewCell.swift
//  WabiSabiTeamProject
//
//  Created by Edwin Niwarlangga on 30/11/21.
//

import UIKit
protocol DidEditButtonPressed{
    func editButtonPressed(title status : String)
}

class ProductHeaderTableViewCell: UITableViewCell {

   var  delegate : DidEditButtonPressed?
    @IBOutlet weak var editButton: UIButton!
    @IBAction func productHeaderPressed(_ sender: Any) {
        
        if(editButton.titleLabel?.text == "Save"){
            //kembalikan ke state edit
            delegate?.editButtonPressed(title: "Save")
            self.editButton.setTitle("Edit", for: .normal)
        }else if(editButton.titleLabel?.text == "Edit"){
            //kembalikan ke state save
            delegate?.editButtonPressed(title: "Edit")
            self.editButton.setTitle("Save", for: .normal)
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
