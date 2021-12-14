//
//  ProductTableViewCell.swift
//  WabiSabiTeamProject
//
//  Created by Edwin Niwarlangga on 10/11/21.
//

import Foundation
import UIKit

class ProductTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var brand: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var imageBackground: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageBackground.layer.cornerRadius = imageProduct.frame.size.width / 2.0
        imageBackground.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(with product: ProductAndRoutineList) {
        name.text = product.name
        brand.text = product.brand
        type.text = product.type
        if product.image != nil{
            guard let decodedData = Data(base64Encoded: product.image, options: .ignoreUnknownCharacters) else { return  }
            let decodedimage: UIImage = UIImage(data: decodedData) ?? UIImage(systemName: "plus") as! UIImage

            imageProduct.contentMode = UIImage(data: decodedData) != nil ? .scaleToFill : .center
            imageProduct.image = decodedimage
            imageProduct.tintColor = .black
        }
    }
}
