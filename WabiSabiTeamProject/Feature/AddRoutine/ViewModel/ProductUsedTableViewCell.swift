//
//  ProductUsedTableViewCell.swift
//  WabiSabiTeamProject
//
//  Created by Edwin Niwarlangga on 15/11/21.
//

import UIKit
protocol deleteProductItemDelegate{
    func deleteProductItem(deletedProduct product : Product)
}

class ProductUsedTableViewCell: UITableViewCell {

    // MARK: UIComponent
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var viewCheckBox: UIView!
    @IBOutlet weak var checkedIconImage: UIImageView!
    @IBOutlet weak var uncheckIconImage: UIImageView!
    @IBOutlet weak var viewOuterAdd: UIView!
    
    @IBOutlet weak var productBrandLabel: UILabel!
    @IBAction func trashButtonPressed(_ sender: Any) {
        guard let product = self.selectedProduct else{
            return
        }
        
        delegate?.deleteProductItem(deletedProduct: product)
    }
    @IBOutlet weak var trashButton: UIButton!
    @IBOutlet weak var viewDragable: UIView!
    @IBOutlet weak var dragableIconImage: UIImageView!
    
    // MARK: Variable
    var delegate : deleteProductItemDelegate?
    var selectedProduct : Product?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        trashButton.setTitle("", for: .normal)
        trashButton.setImage(UIImage(named: "deleteIcon"), for: .normal)
        
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.white.cgColor
        contentView.layer.shadowColor = UIColor(red: 0.91, green: 0.85, blue: 0.82, alpha: 1.00).cgColor
        
        imageCell.layer.cornerRadius = 15
        viewOuterAdd.layer.cornerRadius = 15
        viewDragable.isHidden = true
        dragableIconImage.isHidden = true
        checkedIconImage.isHidden = true
        trashButton.isHidden = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

        // Configure the view for the selected state
    }
    func setUIText(title : String, brand:String, desc: String){
        productNameLabel.text = title
        productBrandLabel.text = brand
        productDescriptionLabel.text = desc
    }
    
    func setUIImage(image: String, isDone : Bool){
        
        guard let decodedData = Data(base64Encoded: image, options: .ignoreUnknownCharacters) else { return }
        let decodedimage: UIImage = UIImage(data: decodedData)!
        
        imageCell.image = decodedimage
        imageCell.contentMode = .scaleToFill
        
        if(isDone){
            viewCheckBox.isHidden = false
            checkedIconImage.isHidden = false
            uncheckIconImage.isHidden = true
            viewDragable.isHidden = true
            dragableIconImage.isHidden = true
            trashButton.isHidden = true
        }else{
            viewCheckBox.isHidden = false
            checkedIconImage.isHidden = true
            uncheckIconImage.isHidden = false
            viewDragable.isHidden = true
            dragableIconImage.isHidden = true
            trashButton.isHidden = true
        }
    }
    
    func setDragableandTrashIcon(){
        
            viewDragable.isHidden = false
            dragableIconImage.isHidden = false
            trashButton.isHidden = false
            
            viewCheckBox.isHidden = true
            checkedIconImage.isHidden = true
            uncheckIconImage.isHidden = true
        
    }
    
}
