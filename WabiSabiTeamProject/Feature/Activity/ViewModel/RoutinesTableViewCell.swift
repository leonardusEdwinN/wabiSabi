//
//  RoutinesTableViewCell.swift
//  WabiSabiTeamProject
//
//  Created by Albert . on 11/11/21.
//

import UIKit

class RoutinesTableViewCell: UITableViewCell {
    @IBOutlet weak var routineImage: UIImageView!
    @IBOutlet weak var routineName: UILabel!
    @IBOutlet weak var routineContentView: UIView!
    @IBOutlet weak var routineProduct: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(with routine: Routine) {
        let routineProductAmount : Float = 5
        let routineProgress : Float = 2
        
        routineImage.image = routine.image
        routineName.text = routine.name
        routineProduct.text = "\(Int(routineProgress)) / \(Int(routineProductAmount))"

        routineContentView.backgroundColor = UIColor.white
        routineContentView.layer.cornerRadius = 15.0
        routineContentView.layer.shadowColor = UIColor.gray.cgColor
        routineContentView.layer.shadowOffset = CGSize(width: 1, height: 1)
        routineContentView.layer.shadowRadius = 1
        routineContentView.layer.shadowOpacity = 5
        routineContentView.layer.masksToBounds = false
        
        progressView.progress = routineProgress / routineProductAmount
    }
    
}
