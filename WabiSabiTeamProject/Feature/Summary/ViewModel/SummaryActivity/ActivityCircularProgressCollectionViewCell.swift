//
//  ActivityCircularProgressCollectionViewCell.swift
//  WabiSabiTeamProject
//
//  Created by Giovanni Tjahyamulia on 01/12/21.
//

import UIKit

class ActivityCircularProgressCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var circularProgressActivity: CircularProgressActivity!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var routineNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
