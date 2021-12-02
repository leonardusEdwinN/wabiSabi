//
//  ProfileViewController.swift
//  WabiSabiTeamProject
//
//  Created by Edwin Niwarlangga on 10/11/21.
//

import Foundation
import UIKit

class ProfileViewController : UIViewController, UIViewControllerTransitioningDelegate{
    @IBOutlet weak var profileImage: UIView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var switchTableViewButton: UISegmentedControl!
    @IBOutlet weak var productTableView: UITableView!
    @IBOutlet weak var profileLevel: UILabel!
    
    var selectedRoutineIndex : Int = 0
    var selectedRoutine : Routines!
    
    var selectedProductIndex : Int = 0
    var selectedProduct : Product!
    
    var tableProductData: [Product] = PersistanceManager.shared.fetchProduct()
    var tableRoutinetData: [Routines] = PersistanceManager.shared.fetchRoutines()
    
    var currentProfileList: currentTableList = currentTableList.productList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUserData()
        setupView()
        setUpTableView()
        configureNavigationBar()
    }
    
    func configureUserData() {
        let user = PersistanceManager.shared.fetchUser()
        
        profileName.text = user.name
        profileLevel.text = user.level
    }
    
    func setupView(){
        profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2
    }
    
    private func setUpTableView() {
        productTableView.dataSource = self
        productTableView.delegate = self
        
        if (currentProfileList == currentTableList.productList) {
            let nib = UINib(nibName: "ProductTableViewCell", bundle: nil)
            productTableView.register(nib, forCellReuseIdentifier: "ProductTableViewCell")
        } else {
            let nib = UINib(nibName: "RoutineTableViewCell", bundle: nil)
            productTableView.register(nib, forCellReuseIdentifier: "RoutineTableViewCell")
        }
    }
    
    private func configureNavigationBar() {
        title = "Profile"
        let menuButton = UIBarButtonItem(image: UIImage(named: "Setting"), style: .plain, target: self, action: #selector(tapMenuButton))
        menuButton.tintColor = UIColor.black
        navigationItem.rightBarButtonItems = [menuButton]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveToAddRoutinePage"{
            guard let nav = segue.destination as? UINavigationController else {
                return
            }
            
            guard let addRoutineVC = nav.topViewController as? AddRoutineViewController else {
                return
            }
            
            addRoutineVC.selectedRoutine = self.tableRoutinetData[selectedRoutineIndex]
            nav.modalPresentationStyle = .fullScreen
        } else if segue.identifier == "moveToAddProduct"{
//            guard let nav = segue.destination as? UINavigationController else {
//                return
//            }
//
//            guard let addProductVC = nav.topViewController as? AddProductViewController else {
//               return
//            }
//
//            addProductVC.selectedRoutine = self.selectedRoutine
//            addProductVC.delegate = self
//            addProductVC.selectedProduct = self.selectedProduct
//            addProductVC.isEdit = (self.selectedProduct != nil) ? true : false
//            addProductVC.modalPresentationStyle = .fullScreen
            
        } else if segue.identifier == "goToNewHabitVC"{
            
            
            guard let nav = segue.destination as? UINavigationController else {
                return
            }
            
            guard let newHabitVC = nav.topViewController as? NewHabitViewController else {
                return
            }
            
            print("ROUTINE INDEX: \(selectedRoutine.name) :: \(selectedRoutine.category)")
            nav.modalPresentationStyle = .fullScreen
            newHabitVC.selectedRoutine = self.selectedRoutine
            newHabitVC.subcategoriesName = self.selectedRoutine.name ?? ""
            newHabitVC.subcategoriesDescription = self.selectedRoutine.categoryDetail ?? ""
            newHabitVC.selectedCategory = self.selectedRoutine.category ?? ""
            newHabitVC.isEditRoutine = true
            
            switch self.selectedRoutine.category{
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
        }
        
    }
    
    @IBAction func changeTableView(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            currentProfileList = currentTableList.productList
        } else {
            currentProfileList = currentTableList.routineList
        }
        
        setUpTableView()
        productTableView.reloadData()
    }
    
    @objc func tapMenuButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "EditProfileView", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "EditProfileViewController")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
        
        //        let vc = storyboard.instantiateViewController(withIdentifier: "EditProfileViewController") as? EditProfileViewController
        
        //        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if currentProfileList == currentTableList.productList {
            return tableProductData.count
        } else {
            return tableRoutinetData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
        
        if currentProfileList == currentTableList.productList {
            let tableData = tableProductData[indexPath.row]
            cell.setup(with: ProductAndRoutineList(
                image: UIImage(systemName: "sun.max.fill")!, name: tableData.name!,brand: tableData.brand ?? "", type: tableData.productType ??  ""))
            
            return cell
        } else {
            let tableData = tableRoutinetData[indexPath.row]
            cell.setup(with: ProductAndRoutineList(
                image: UIImage(systemName: "sun.max.fill")!, name: tableData.name!,brand: "", type: ""))
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if currentProfileList == currentTableList.productList  {
//            performSegue(withIdentifier: "moveToAddProduct", sender: self)
        } else {
            print("ROUTINE CLICK : \(tableRoutinetData[indexPath.row].name)")
            var selectedRoutineName = tableRoutinetData[indexPath.row].name
            switch selectedRoutineName {
            case "Morning Skin Care":
                self.selectedRoutineIndex = indexPath.row
                performSegue(withIdentifier: "moveToAddRoutinePage", sender: self)
            case "Night Skin Care" :
                self.selectedRoutineIndex = indexPath.row
                performSegue(withIdentifier: "moveToAddRoutinePage", sender: self)
            default:
                print("ROUTINE CLICK DEFAULT")
                self.selectedRoutineIndex = indexPath.row
                self.selectedRoutine = tableRoutinetData[indexPath.row]
                self.performSegue(withIdentifier: "goToNewHabitVC", sender: self)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let verticalPadding: CGFloat = 10
        
        let maskLayer = CALayer()
        maskLayer.cornerRadius = 10    //if you want round edges
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
        cell.layer.mask = maskLayer
    }
}

enum currentTableList {
    case productList
    case routineList
}
