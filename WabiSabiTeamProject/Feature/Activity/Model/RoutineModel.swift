//
//  RoutineModel.swift
//  WabiSabiTeamProject
//
//  Created by Albert . on 08/11/21.
//

import Foundation
import UIKit

struct Routine{
    let image: UIImage
    let name: String
    let productAmount: Int
}

struct ProductAndRoutineList{
    let image: UIImage
    let name: String
    let brand: String
    let type: String
}

var routines: [Routine] = [
    Routine(image: UIImage(systemName: "sun.max.fill")!, name: "Morning Skin Care Routine", productAmount: 5),
    Routine(image: UIImage(systemName: "moon.stars.fill")!, name: "Night Skin Care Routine", productAmount: 5)
]
