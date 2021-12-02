//
//  ProgressIndicatorHorizontalCollectionViewCell.swift
//  WabiSabiTeamProject
//
//  Created by Albert . on 01/11/21.
//

import UIKit

class ProgressIndicatorHorizontalCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var CircularProgress: CircularProgressView!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    var percentageValue : CGFloat!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
    }
    
    private func setUpCollectionView() {
        CircularProgress.progressColor = UIColor.systemIndigo
        CircularProgress.trackColor = UIColor.systemGray4
        CircularProgress.percentageValue = 0.8
    }
}
