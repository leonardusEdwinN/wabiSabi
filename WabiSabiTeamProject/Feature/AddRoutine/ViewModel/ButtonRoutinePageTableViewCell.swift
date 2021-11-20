//
//  ButtonRoutinePageTableViewCell.swift
//  WabiSabiTeamProject
//
//  Created by Edwin Niwarlangga on 15/11/21.
//

import UIKit
protocol AddProductDelegate{
    func addNewProduct()
}

class ButtonRoutinePageTableViewCell: UITableViewCell {

    @IBOutlet weak var buttonImport: UIButton!
    @IBOutlet weak var buttonAddOtherProduct: UIButton!
    
    // MARK: Variable
    var delegate: AddProductDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        buttonAddOtherProduct.layer.cornerRadius = 15
        buttonImport.layer.cornerRadius = 15
        buttonImport.layer.borderWidth = 2
        buttonImport.layer.borderColor = UIColor(named: "ColorPrimary")?.cgColor
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func buttonImportPressed(_ sender: Any) {
    }
    @IBAction func buttonAddOtherProductPressed(_ sender: Any) {
        delegate?.addNewProduct()
        
    }
}
