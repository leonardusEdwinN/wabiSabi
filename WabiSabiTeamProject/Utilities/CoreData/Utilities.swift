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
                SkinCareProduct(icon: "", name: "Eye Cream", description: ""),
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
    
    let category: [Categories] = [
        Categories(categoryName: "Face", subcategories: [
            SubCategories(habitName: "Sheet Mask", description: "Facial mask will help you to solve your skin concern, and you can use it 1-3 times per week or look the instructions on the product label.", period: "Weekly", timeInMinutes: 10, notes: "All Skin Type"),
            SubCategories(habitName: "Sleeping Mask", description: "Facial mask will help you to solve your skin concern, and you can use it 1-3 times per week or look the instructions on the product label.", period: "Weekly", timeInMinutes: 10, notes: "All Skin Type"),
            SubCategories(habitName: "Physical Face Exfoliation", description: "Physical Exfoliator will help you to sloughs off dead skin. The product is grainy-tectured, contains natural microbeads or scrub, you can also use sponge to exfoliate your face. You can exfoliate your skin maximum 3 times per week.", period: "Weekly", timeInMinutes: 10, notes: "Normal to Oily"),
            SubCategories(habitName: "Clay Mask", description: "Facial mask will help you to solve your skin concern, and you can use it 1-3 times per week or look the instructions on the product label.", period: "Weekly", timeInMinutes: 10, notes: "Oily Skin and Combination Skin"),
            SubCategories(habitName: "Charcoal Mask", description: "Facial mask will help you to solve your skin concern, and you can use it 1-3 times per week or look the instructions on the product label.", period: "Weekly", timeInMinutes: 10, notes: "Oily Skin and Combination Skin"),
            SubCategories(habitName: "Cream Mask", description: "Facial mask will help you to solve your skin concern, and you can use it 1-3 times per week or look the instructions on the product label.", period: "Weekly", timeInMinutes: 10, notes: "Dry Skin"),
            SubCategories(habitName: "Chemical Face Exfoliation", description: "Chemical Exfoliator will help you to sloughs off dead skin. The product is a combination of safe-for-skin acids. You can exfoliate your skin maximum 3 times per week.", period: "Weekly", timeInMinutes: 10, notes: "Sensitive"),
            SubCategories(habitName: "Peel-Off Mask", description: "Facial mask will help you to solve your skin concern, and you can use it 1-3 times per week or look the instructions on the product label.", period: "Weekly", timeInMinutes: 10, notes: "Not for Sensitive Skin"),
            SubCategories(habitName: "Lip Exfoliation Routine", description: "Lip care routine is great for dry lips, you only need to exfoliate if you have a dry lips. You can exfoliate your lips 1-2 times per week. Exfoliate using scrub then moisturise using balm.", period: "Weekly", timeInMinutes: 10, notes: ""),
            SubCategories(habitName: "Face Serum", description: "Face serum is a light moisturiser packed with full of active ingredients. Serum is the problem solver for your skin concerns. Use it base on the product label information.", period: "Weekly", timeInMinutes: 10, notes: ""),
            SubCategories(habitName: "Treatment", description: "Treatment products are used to address specific skin concerns such as acne, dark spots, hyperpigmentation, fine lines and inflammation.", period: "Weekly", timeInMinutes: 10, notes: "")
        ]),
        Categories(categoryName: "Body & Scalp", subcategories: [
            SubCategories(habitName: "Hair Mask", description: "Hair mask help you to nutrient and moisturize your scalp. ", period: "Weekly", timeInMinutes: 20, notes: ""),
            SubCategories(habitName: "Creambath", description: "Creambath using special hair cream for hair and scalp treatment. It nourish the hair. The effect depends on the concern you have.", period: "Weekly", timeInMinutes: 20, notes: ""),
            SubCategories(habitName: "Body Scrub", description: "Body scrub will help you to sloughs off dead body skin.", period: "Weekly", timeInMinutes: 20, notes: ""),
            SubCategories(habitName: "Body Lotion", description: "Body lotion will nourish your skin. It is recommended to use it after shower.", period: "Weekly", timeInMinutes: 20, notes: ""),
            SubCategories(habitName: "Body Butter", description: "Body butter effectively used for dry part on the body. It is recommended to use it before sleep.", period: "Weekly", timeInMinutes: 20, notes: ""),
            SubCategories(habitName: "Body Serum", description: "Body serum is the lightest product to nourish and moisturize the skin. It is suitable for dry skin area in your body.", period: "Weekly", timeInMinutes: 20, notes: "")
        ]),
        Categories(categoryName: "Health", subcategories: [
            SubCategories(habitName: "Exercise", description: "It is recommended that with just 30 minutes of exercise each day will effect the skin health.", period: "Daily", timeInMinutes: 30, notes: ""),
            SubCategories(habitName: "Dietary Supplements", description: "There are vitamins that beneficial for skin, such as Vitamin A, B, C, and E", period: "Daily", timeInMinutes: 20, notes: ""),
            SubCategories(habitName: "Stay Hydrated", description: "We recommend you to drink 8 glasses of water per day!", period: "Daily", timeInMinutes: 3, notes: ""),
            SubCategories(habitName: "Enough Sleep", description: "Create a bedtime routine and stick to it. Strive for 7 to 9 hours of sleep every night.", period: "Daily", timeInMinutes: 480, notes: "")
        ]),
        Categories(categoryName: "Others", subcategories: [
            SubCategories(habitName: "Clean Make Up Tools", description: "It is important to clean your make up tools weekly to avoid build up products and bacteria that can cause irritation to the skin.", period: "Weekly", timeInMinutes: 30, notes: ""),
            SubCategories(habitName: "Change Pillow Cover", description: "Changing pillow cover once a week will prevent breakouts, because pillowcases could be the one of the cause. Residual makeup, bacteria, dirt, and oil can build up on your pillowcase.", period: "Weekly", timeInMinutes: 30, notes: ""),
            SubCategories(habitName: "Don't Sleep with Your Make Up On", description: "Not removing your make up before sleep will effect badly to your skin.", period: "Daily", timeInMinutes: 15, notes: ""),
            SubCategories(habitName: "Don't Forget to Use Hat", description: "Excessive exposure from sun can damage your skin cells and can lead your skin to sunburns, wrinkles, and dehydration. Using hat can help to prevent it. Don't got expose between 10am - 4pm!", period: "Daily", timeInMinutes: 2, notes: "")
        ])
    ]
}
