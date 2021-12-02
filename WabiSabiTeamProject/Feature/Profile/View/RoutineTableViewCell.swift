//
//  RoutineTableViewCell.swift
//  WabiSabiTeamProject
//
//  Created by Edwin Niwarlangga on 10/11/21.
//

import UIKit

class RoutineTableViewCell: UITableViewCell {
    @IBOutlet weak var routineName: UILabel!
    @IBOutlet weak var routineDate: UILabel!
    @IBOutlet weak var routineImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(with routine: Routines) {
        name.text = routine.name
        brand.text = routine.brand
        type.text = routine.type
    }
}
