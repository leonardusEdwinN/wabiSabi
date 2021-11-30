//
//  RoutinesTableViewCell.swift
//  WabiSabiTeamProject
//
//  Created by Albert . on 11/11/21.
//

import UIKit

class RoutinesTableViewCell: UITableViewCell {
    @IBOutlet weak var routineName: UILabel!
    @IBOutlet weak var routineContentView: UIView!
    @IBOutlet weak var routineProduct: UILabel!
    @IBOutlet weak var routineColor: UIView!
    @IBOutlet weak var routineBackground: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(with routine: Routines) {
        let routineProductAmount : Float = 5
        let routineProgress : Float = 2
        
        routineName.text = routine.name
        routineProduct.text = "\(Int(routineProgress)) / \(Int(routineProductAmount))"

        routineBackground.backgroundColor = UIColor.clear
        
        routineContentView.backgroundColor = UIColor.white
        routineContentView.layer.cornerRadius = 15.0
        routineContentView.layer.shadowColor = UIColor.gray.cgColor
        routineContentView.layer.shadowOffset = CGSize(width: 1, height: 1)
        routineContentView.layer.shadowRadius = 1
        routineContentView.layer.shadowOpacity = 5
        routineContentView.layer.masksToBounds = false

        routineColor.layer.cornerRadius = routineColor.frame.width / 2
    }
    
}
