//
//  RoutineCollectionViewCell.swift
//  WabiSabiTeamProject
//
//  Created by Albert . on 08/11/21.
//

import UIKit

class RoutineCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var routineName: UILabel!
    @IBOutlet weak var routineImage: UIImageView!
    @IBOutlet weak var routineProductAmount: UILabel!
    @IBOutlet weak var routineContentView: UIView!
    
    func setup(with routine: Routine) {
        routineImage.image = routine.image
        routineName.text = routine.name
        routineProductAmount.text = "0/\(routine.productAmount)"
        
        
        routineContentView.backgroundColor = UIColor.white
        routineContentView.layer.cornerRadius = 15.0
        routineContentView.layer.shadowColor = UIColor.gray.cgColor
        routineContentView.layer.shadowOffset = CGSize(width: 1, height: 1)
        routineContentView.layer.shadowRadius = 1
        routineContentView.layer.shadowOpacity = 5
        routineContentView.layer.masksToBounds = false //<-
    }
}
