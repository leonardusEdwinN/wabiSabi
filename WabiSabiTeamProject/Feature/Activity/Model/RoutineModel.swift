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

struct RoutineAndProductList{
    let image: UIImage
    let name: String
}

var routines: [Routine] = [
    Routine(image: UIImage(systemName: "sun.max.fill")!, name: "Morning Skin Care Routine", productAmount: 5),
    Routine(image: UIImage(systemName: "moon.stars.fill")!, name: "Night Skin Care Routine", productAmount: 5)
]

var routinesProfile: [RoutineAndProductList] = [
    RoutineAndProductList(image: UIImage(systemName: "sun.max.fill")!, name: "Morning Skin Care Routine"),
    RoutineAndProductList(image: UIImage(systemName: "moon.stars.fill")!, name: "Night Skin Care Routine"),
    RoutineAndProductList(image: UIImage(systemName: "moon.stars.fill")!, name: "Face Mask"),
    RoutineAndProductList(image: UIImage(systemName: "moon.stars.fill")!, name: "Face Exfoliation"),
]

var productsProfile: [RoutineAndProductList] = [
    RoutineAndProductList(image: UIImage(systemName: "sun.max.fill")!, name: "Cleanser"),
    RoutineAndProductList(image: UIImage(systemName: "moon.stars.fill")!, name: "Toner"),
    RoutineAndProductList(image: UIImage(systemName: "moon.stars.fill")!, name: "Serum"),
    RoutineAndProductList(image: UIImage(systemName: "moon.stars.fill")!, name: "Moisturizer"),
    RoutineAndProductList(image: UIImage(systemName: "moon.stars.fill")!, name: "Sun Care"),
]
