//
//  SkinTypeTableViewCell.swift
//  WabiSabiTeamProject
//
//  Created by Giovanni Tjahyamulia on 02/11/21.
//

import UIKit

class SkinTypeTableViewCell: UITableViewCell {
    @IBOutlet weak var skinTypeIcon: UIImageView!
    @IBOutlet weak var skinTypeName: UILabel!
    @IBOutlet weak var skinTypeDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

struct SkinType {
    var icon: String, name: String, description: String;
}
