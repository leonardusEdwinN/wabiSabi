//
//  SkinTypeTableViewCell.swift
//  WabiSabiTeamProject
//
//  Created by Giovanni Tjahyamulia on 01/11/21.
//

import UIKit

class SkinCareGuideTableViewCell: UITableViewCell {
    @IBOutlet weak var skinCareProductIcon: UIImageView!
    @IBOutlet weak var skinCareProductName: UILabel!
    @IBOutlet weak var skinCareProductDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
struct SkinCareRoutineProduct {
    var name: String, products: [SkinCareProduct];
}

struct SkinCareProduct {
    var icon: String, name: String, description: String;
}
