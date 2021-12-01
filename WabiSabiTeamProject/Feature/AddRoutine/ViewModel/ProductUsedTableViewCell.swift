//
//  ProductUsedTableViewCell.swift
//  WabiSabiTeamProject
//
//  Created by Edwin Niwarlangga on 15/11/21.
//

import UIKit
protocol deleteProductItemDelegate{
    func deleteProductItem(deletedProduct product : Product)
    func editProductItem(editedProduct product: Product)
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
    @IBOutlet weak var viewEdit: UIView!
//    @IBOutlet weak var editIconImage: UIImageView!
    @IBOutlet weak var buttonEdit: UIButton!
    @IBAction func buttonEditPressed(_ sender: Any) {
        guard let product = self.selectedProduct else{
            return
        }
        
        delegate?.editProductItem(editedProduct: product)
    }
    
    // MARK: Variable
    var delegate : deleteProductItemDelegate?
    var selectedProduct : Product?
    var selectedIndexPath : IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        trashButton.setTitle("", for: .normal)
        trashButton.setImage(UIImage(named: "deleteIcon"), for: .normal)
        buttonEdit.setTitle("", for: .normal)
        buttonEdit.setImage(UIImage(named: "editIcon"), for: .normal)
        
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.white.cgColor
        contentView.layer.shadowColor = UIColor(red: 0.91, green: 0.85, blue: 0.82, alpha: 1.00).cgColor
        
        imageCell.layer.cornerRadius = 15
        viewOuterAdd.layer.cornerRadius = 15
        viewEdit.isHidden = true
        buttonEdit.isHidden = true
        checkedIconImage.isHidden = true
        trashButton.isHidden = true
        // Initialization code
        
        
        // 1. create a gesture recognizer (tap gesture)
        let editGesture = UITapGestureRecognizer(target: self, action: #selector(editProduct(_:)))
        checkedIconImage.addGestureRecognizer(editGesture)
//
//        let uncheckedGesture = UITapGestureRecognizer(target: self, action: #selector(uncheckedStatus(_:)))
//        checkedIconImage.addGestureRecognizer(uncheckedGesture)
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
    
    func setUIImage(image: String){
        
        guard let decodedData = Data(base64Encoded: image, options: .ignoreUnknownCharacters) else { return }
        let decodedimage: UIImage = UIImage(data: decodedData) ?? UIImage(named: "Mascot")!
        
        imageCell.image = decodedimage
        imageCell.contentMode = .scaleToFill
        
//        if(isDone){
//            viewCheckBox.isHidden = false
//            checkedIconImage.isHidden = false
//            uncheckIconImage.isHidden = true
//            viewEdit.isHidden = true
//            editIconImage.isHidden = true
//            trashButton.isHidden = true
//        }else{
//            viewCheckBox.isHidden = false
//            checkedIconImage.isHidden = true
//            uncheckIconImage.isHidden = false
//            viewEdit.isHidden = true
//            editIconImage.isHidden = true
//            trashButton.isHidden = true
//        }
    }
    
    func setDragableandTrashIcon(){
        
            viewEdit.isHidden = false
            buttonEdit.isHidden = false
            trashButton.isHidden = false
            
            viewCheckBox.isHidden = true
            checkedIconImage.isHidden = true
            uncheckIconImage.isHidden = true
    }
    
    func setStatusDone(){
            viewEdit.isHidden = true
            buttonEdit.isHidden = true
            trashButton.isHidden = true
            
            viewCheckBox.isHidden = false
            checkedIconImage.isHidden = false
            uncheckIconImage.isHidden = true
    }
    
    func hideAll(){
        viewEdit.isHidden = true
        buttonEdit.isHidden = true
        trashButton.isHidden = true
        
        viewCheckBox.isHidden = true
        checkedIconImage.isHidden = true
        uncheckIconImage.isHidden = true
    }
    
    @objc func editProduct(_ sender: UITapGestureRecognizer) {
        if let editProduct = selectedProduct{
            delegate?.editProductItem(editedProduct: editProduct)
        }

    }


//    @objc func uncheckedStatus(_ sender: UITapGestureRecognizer) {
//        if let indexPath = selectedIndexPath{
//            delegateCheckUncheck?.uncheckedItem(for: indexPath)
//        }
//    }
    
    func setStatusUndone(){
        
            viewEdit.isHidden = true
            buttonEdit.isHidden = true
            trashButton.isHidden = true
            
            viewCheckBox.isHidden = false
            checkedIconImage.isHidden = true
            uncheckIconImage.isHidden = false
        
    }
    
}
