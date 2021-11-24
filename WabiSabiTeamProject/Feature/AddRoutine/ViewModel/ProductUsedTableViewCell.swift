//
//  ProductUsedTableViewCell.swift
//  WabiSabiTeamProject
//
//  Created by Edwin Niwarlangga on 15/11/21.
//

import UIKit

class ProductUsedTableViewCell: UITableViewCell {

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var viewCheckBox: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageCell.layer.cornerRadius = 15
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

        // Configure the view for the selected state
    }
    func setUIText(title : String, desc: String){
        productNameLabel.text = title
        productDescriptionLabel.text = desc
    }
    
    func setUIImage(image: UIImage, isDone : Bool){
        imageCell.image = image
        imageCell.contentMode = .scaleToFill
        
        if(isDone){
            viewCheckBox.backgroundColor = UIColor.systemIndigo
        }else{
            viewCheckBox.backgroundColor = UIColor.white
        }
    }
    
}
