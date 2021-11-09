//
//  SummaryAwardsCollectionViewCell.swift
//  WabiSabiTeamProject
//
//  Created by Edwin Niwarlangga on 09/11/21.
//

import UIKit

class SummaryAwardsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewCircle: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        viewCircle.layer.cornerRadius = viewCircle.frame.size.width / 2
        viewCircle.clipsToBounds = true
    }

}
