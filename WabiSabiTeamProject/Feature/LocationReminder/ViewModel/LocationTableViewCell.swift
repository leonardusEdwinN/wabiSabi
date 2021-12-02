//
//  LocationTableViewCell.swift
//  WabiSabiTeamProject
//
//  Created by Edwin Niwarlangga on 16/11/21.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    @IBOutlet weak var imageLocation: UIImageView!
    @IBOutlet weak var labelLocationName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUI(title : String, image: String){
        labelLocationName.text = title
        imageLocation.image = UIImage(named: image)
    }
    
}
