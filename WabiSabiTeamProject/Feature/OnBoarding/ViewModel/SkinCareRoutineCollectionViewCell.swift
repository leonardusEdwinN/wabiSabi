//
//  SkinCareRoutineCollectionViewCell.swift
//  WabiSabiTeamProject
//
//  Created by Giovanni Tjahyamulia on 01/11/21.
//

import UIKit

class SkinCareRoutineCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var skinCareRoutineIconLabel: UILabel!
    @IBOutlet weak var skinCareRoutineNameLabel: UILabel!
    @IBOutlet weak var skinCareRoutineProductLabel: UILabel!
}

struct SkinCareRoutine {
    var icon: String, name: String, product: Int;
}
