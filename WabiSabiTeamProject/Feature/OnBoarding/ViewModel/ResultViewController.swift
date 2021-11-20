//
//  ResultViewController.swift
//  WabiSabiTeamProject
//
//  Created by Giovanni Tjahyamulia on 01/11/21.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var skinCareRoutineCollectionView: UICollectionView!
    
    var skinTypeIndex: Int = 0
    var levelIndex: Int = 0
    var skinExperienceIndex: Int = 0
    
    var user: User!
    
    var skinTypeRoutine: [SkinRoutineProduct] = [
        SkinRoutineProduct(icon: "🌞", name: "Morning Skin Care", products: []),
        SkinRoutineProduct(icon: "🌓", name: "Night Skin Care", products: [])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        skinCareRoutineCollectionView.delegate = self
        skinCareRoutineCollectionView.dataSource = self
        
        skinTypeIndex = UserDefaults.standard.integer(forKey: "skinTypes")
        levelIndex = UserDefaults.standard.integer(forKey: "skinCareRoutines")
        skinExperienceIndex = UserDefaults.standard.integer(forKey: "skinCareExperience")
        
        calculateLevel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let birthdate = UserDefaults.standard.object(forKey: "birthdate") as! Date
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy HH:mm"
        
        PersistanceManager.shared.setUser(
            dateOfBirth: birthdate,
            gender: Utilities().genders[UserDefaults.standard.integer(forKey: "gender")],
            isNotify: false,
            level: Utilities().levels[levelIndex].level,
            localization: "en",
            name: UserDefaults.standard.string(forKey: "name") ?? "",
            skinType: Utilities().skinTypeRoutineProduct[0].skinType[skinTypeIndex].name)
        
        checkProduct()
    }
    
    func calculateLevel() {
        // check index bigger than first "Beginner"
        if levelIndex > 0 {
            levelIndex = levelIndex - 1
        }
        
        // user want to start from basic
        if skinExperienceIndex == 0 {
            levelIndex = 0
        }
        
        // user want to do current routine (do nothing...)
        
        // user want to step up
        else if skinExperienceIndex == 2 {
            levelIndex = levelIndex + 1
        }
        if levelIndex > 2 {
            levelIndex = 2
        }
        
        levelLabel.text = "Level:  \(Utilities().levels[levelIndex].level)"
        
        UserDefaults.standard.set(levelIndex, forKey: "levelIndex")
    }
    
    func checkProduct(){
        let productIndex: [Int] = Utilities().levels[levelIndex].productIndex
        for routineIndex in 0...1 {
            PersistanceManager.shared.setRoutine(isEveryday: true, name: skinTypeRoutine[routineIndex].name)
            
            for index in 0..<productIndex.count {
                let product = Utilities().skinTypeRoutineProduct[routineIndex].skinType[skinTypeIndex].products[productIndex[index]]
                
                if !(product.description == "") {
                    skinTypeRoutine[routineIndex].products.append(product)
                    
                    PersistanceManager.shared.setProduct(name: product.name)
                }
            }
        }
    }
    
    @IBAction func getStarted(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainTabBarController")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}

extension ResultViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Utilities().skinTypeRoutineProduct.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = skinCareRoutineCollectionView.dequeueReusableCell(withReuseIdentifier: "skincareroutinecell", for: indexPath) as! SkinCareRoutineCollectionViewCell
        
        let data = skinTypeRoutine[indexPath.row]
        cell.skinCareRoutineIconLabel.text = data.icon
        cell.skinCareRoutineNameLabel.text = data.name
        cell.skinCareRoutineProductLabel.text = "\(data.products.count) products"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "OnBoarding", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SkinCareGuide") as! SkinCareGuideViewController
        vc.skinTypeRoutine = skinTypeRoutine[indexPath.row]
        
        self.show(vc, sender: nil)
    }
    
    
}
