//
//  ExploreViewController.swift
//  WabiSabiTeamProject
//
//  Created by Giovanni Tjahyamulia on 23/11/21.
//

import UIKit

class ExploreViewController: UIViewController {
    
    @IBOutlet weak var tableViewBackground: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var createYourOwnHabitLabel: UILabel!
    @IBOutlet weak var buttonCreateYourOwn: UIButton!
    
    var sectionSelected: Int = 0
    var selectedCategory: String = ""
    var selectedSubCategory : SubCategories!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonCreateYourOwn.layer.cornerRadius = 30
        
        tableView.delegate = self
        tableView.dataSource = self
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 34)
        createYourOwnHabitLabel.font = UIFont.boldSystemFont(ofSize: 22)
        
//        buttonCreateYourOwn.tintColor = UIColor(named: "ColorPrimary")
        buttonCreateYourOwn.backgroundColor = UIColor(named: "ColorPrimary")
        
        let whiteGradient = CAGradientLayer()
        whiteGradient.colors = [UIColor(red: 1, green: 1, blue: 1, alpha: 0.8).cgColor, UIColor(red: 1, green: 1, blue: 1, alpha: 0.4).cgColor]
        whiteGradient.locations = [0.0, 1.0]
        whiteGradient.borderColor = UIColor.white.cgColor
        whiteGradient.borderWidth = 2
        whiteGradient.cornerRadius = 30
        whiteGradient.frame = CGRect(x: 2, y: 0, width: self.tableView.frame.width - 4, height: 1000)
        tableViewBackground.layer.insertSublayer(whiteGradient, at:0)
    }
}

extension ExploreViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Utilities().category.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryTableViewCell
        cell.categoryLabel.text = Utilities().category[indexPath.section].categoryName
        cell.data = Utilities().category[indexPath.section]
        cell.sectionSelected = indexPath.section
        cell.cellDelegate = self
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
}


extension ExploreViewController : CollectionViewCellDelegate{
    func didTapAtCell(section: Int, cellIndex: IndexPath, subcategoriesData: SubCategories) {
        self.selectedCategory = Utilities().category[section].categoryName
        self.selectedSubCategory = subcategoriesData
        self.performSegue(withIdentifier: "goToNewHabitVC", sender: self)
        
        
//        goToNewHabitVC
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToNewHabitVC"){
            guard let nav = segue.destination as? UINavigationController else {
                return
            }
            
            guard let newHabitVC = nav.topViewController as? NewHabitViewController else {
               return
            }
            
//            PersistanceManager.shared.setRoutine(isEveryday: false, name: selectedSubCategory.habitName)
//
//            if let routineId = UserDefaults.standard.string(forKey: "routineID"){
//                let newRoutine =  PersistanceManager.shared.fetchRoutine(id: routineId)
//                newHabitVC.selectedRoutine = newRoutine
//            }
            
            nav.modalPresentationStyle = .fullScreen
            
            var routineDummy = Routines(context: PersistanceManager.shared.persistentContainer.viewContext)
            routineDummy.name = self.selectedSubCategory.habitName
            
            newHabitVC.selectedRoutine = routineDummy
            newHabitVC.subcategoriesName = self.selectedSubCategory.habitName
            newHabitVC.subcategoriesDescription = self.selectedSubCategory.description
            newHabitVC.selectedCategory = self.selectedCategory
            
            
            switch self.selectedCategory{
            case "Face" :
                newHabitVC.arrayRoutine = ["name","start", "schedule","headerp", "products","button", "reminder", "timer", "location"]
                break
            case "Body & Scalp" :
                newHabitVC.arrayRoutine = ["name","start", "schedule","headerp", "products","button", "reminder", "timer", "location"]
                break
                
            default:
                //Tidak Mempunyai Product
                newHabitVC.arrayRoutine = ["name","start", "schedule", "reminder", "timer", "location"]
                break
            }
        }else{
            
        }
        
        
        
        
        
    }
    
}
