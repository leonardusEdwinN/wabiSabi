//
//  ProductTableViewCell.swift
//  WabiSabiTeamProject
//
//  Created by Edwin Niwarlangga on 10/11/21.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var brand: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var backgroundImage: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundImage.layer.cornerRadius = backgroundImage.frame.size.width / 2.0
        backgroundImage.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(with product: ProductAndRoutineList) {
        name.text = product.name
        brand.text = product.brand
        type.text = product.type
    }
}
