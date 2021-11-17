//
//  Utilities.swift
//  WabiSabiTeamProject
//
//  Created by Giovanni Tjahyamulia on 15/11/21.
//

import Foundation

struct Utilities {
    let genders: [String] = ["Female", "Male", "Non-Binary", "Prefer not to disclose"]
    
    let levels: [SkinRoutineLevel] = [
        SkinRoutineLevel(level: "Beginner", productIndex: [0, 1, 4, 5]),
        SkinRoutineLevel(level: "Intermediate", productIndex: [0, 1, 2, 3, 4, 5]),
        SkinRoutineLevel(level: "Advance", productIndex: [0, 1, 2, 3, 4, 5, 6])
    ]
    
    let skinTypeRoutineProduct: [SkinTypeRoutine] = [
        SkinTypeRoutine(icon: "🌞", name: "Morning Skin Care", skinType: [
            SkinTypeProduct(name: "Oily", products: [
                SkinCareProduct(icon: "", name: "Cleanser", description: "Gel/Foam Cleanser that contain salicylic/glycolic acid"),
                SkinCareProduct(icon: "", name: "Toner", description: "Avoid alcohol based toner"),
                SkinCareProduct(icon: "", name: "Serum", description: "Antioxidant Serum"),
                SkinCareProduct(icon: "", name: "Eye Cream", description: ""),
                SkinCareProduct(icon: "", name: "Moisturizer", description: ""),
                SkinCareProduct(icon: "", name: "Sunscreen", description: "Zinc Oxide"),
                SkinCareProduct(icon: "", name: "Extras", description: "")
            ]),
            SkinTypeProduct(name: "Dry", products: [
                SkinCareProduct(icon: "", name: "Cleanser", description: "Micellar water/cream Cleanser with humectants such as hyaluronic acid and glycerin"),
                SkinCareProduct(icon: "", name: "Toner", description: "Avoid alcohol based toner"),
                SkinCareProduct(icon: "", name: "Serum", description: "Antioxidant Serum"),
                SkinCareProduct(icon: "", name: "Eye Cream", description: ""),
                SkinCareProduct(icon: "", name: "Moisturizer", description: ""),
                SkinCareProduct(icon: "", name: "Sunscreen", description: "Moisturizer with SPF"),
                SkinCareProduct(icon: "", name: "Extras", description: "")
            ]),
            SkinTypeProduct(name: "Combination", products: [
                SkinCareProduct(icon: "", name: "Cleanser", description: "Gel/Foam Cleanser"),
                SkinCareProduct(icon: "", name: "Toner", description: "Avoid alcohol based toner"),
                SkinCareProduct(icon: "", name: "Serum", description: ""),
                SkinCareProduct(icon: "", name: "Moisturizer", description: "Lightweight"),
                SkinCareProduct(icon: "", name: "Sunscreen", description: "Zinc Oxide"),
                SkinCareProduct(icon: "", name: "Extras", description: "")
            ]),
            SkinTypeProduct(name: "Normal", products: [
                SkinCareProduct(icon: "", name: "Cleanser", description: "Micellar Water, Gel, Oil, or Cream Cleanser with Hyaluronic Acid to keep the complexion youthful and glowing"),
                SkinCareProduct(icon: "", name: "Toner", description: "Avoid alcohol based toner"),
                SkinCareProduct(icon: "", name: "Serum", description: ""),
                SkinCareProduct(icon: "", name: "Eye Cream", description: ""),
                SkinCareProduct(icon: "", name: "Moisturizer", description: "Moisturizer with SPF"),
                SkinCareProduct(icon: "", name: "Sunscreen", description: ""),
                SkinCareProduct(icon: "", name: "Extras", description: "")
            ])
        ]),
        SkinTypeRoutine(icon: "🌓", name: "Night Skin Care", skinType: [
            SkinTypeProduct(name: "Oily", products: [
                SkinCareProduct(icon: "", name: "Cleanser", description: "Gel/Foam Cleanser that contain salicylic/glycolic acid"),
                SkinCareProduct(icon: "", name: "Toner", description: "Avoid alcohol based toner"),
                SkinCareProduct(icon: "", name: "Serum", description: "AHA/BHA, Retinol"),
                SkinCareProduct(icon: "", name: "Eye Cream", description: ""),
                SkinCareProduct(icon: "", name: "Moisturizer", description: "Oil-Free Water-Based"),
                SkinCareProduct(icon: "", name: "Sunscreen", description: ""),
                SkinCareProduct(icon: "", name: "Extras", description: "Clay Mask, Face Oil")
            ]),
            SkinTypeProduct(name: "Dry", products: [
                SkinCareProduct(icon: "", name: "Cleanser", description: "Micellar water/cream Cleanser with humectants such as hyaluronic acid and glycerin"),
                SkinCareProduct(icon: "", name: "Toner", description: "Avoid alcohol based toner"),
                SkinCareProduct(icon: "", name: "Serum", description: "Retinol Serum"),
                SkinCareProduct(icon: "", name: "Eye Cream", description: ""),
                SkinCareProduct(icon: "", name: "Moisturizer", description: "Hydrating Moisturizer"),
                SkinCareProduct(icon: "", name: "Sunscreen", description: ""),
                SkinCareProduct(icon: "", name: "Extras", description: "At-Home Peel, Face Oil")
            ]),
            SkinTypeProduct(name: "Combination", products: [
                SkinCareProduct(icon: "", name: "Cleanser", description: "Gel/Foam Cleanser"),
                SkinCareProduct(icon: "", name: "Toner", description: "Avoid alcohol based toner"),
                SkinCareProduct(icon: "", name: "Serum", description: "AHA/BHA, Retinol"),
                SkinCareProduct(icon: "", name: "Eye Cream", description: ""),
                SkinCareProduct(icon: "", name: "Moisturizer", description: "Lightweight"),
                SkinCareProduct(icon: "", name: "Sunscreen", description: ""),
                SkinCareProduct(icon: "", name: "Extras", description: "Clay Mask, Face Oil")
            ]),
            SkinTypeProduct(name: "Normal", products: [
                SkinCareProduct(icon: "", name: "Cleanser", description: "Micellar Water, Gel, Oil, or Cream Cleanser with Hyaluronic Acid to keep the complexion youthful and glowing"),
                SkinCareProduct(icon: "", name: "Toner", description: "Avoid alcohol based toner"),
                SkinCareProduct(icon: "", name: "Serum", description: "Antioxidant"),
                SkinCareProduct(icon: "", name: "Eye Cream", description: ""),
                SkinCareProduct(icon: "", name: "Moisturizer", description: "Moisturizer"),
                SkinCareProduct(icon: "", name: "Sunscreen", description: ""),
                SkinCareProduct(icon: "", name: "Extras", description: "Glycolic Acid Serum")
            ])
        ])
    ]
}
