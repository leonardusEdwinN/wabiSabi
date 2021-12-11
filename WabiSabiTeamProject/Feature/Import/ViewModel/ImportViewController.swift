//
//  ImportViewController.swift
//  WabiSabiTeamProject
//
//  Created by Edwin Niwarlangga on 27/11/21.
//

import Foundation
import UIKit

//importTableViewCell

class ImportViewController : UIViewController{
    // MARK: UI Component
    @IBOutlet weak var importTableView: UITableView!
    @IBOutlet weak var closeButton: UIButton!
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Variable
    var routines : [Routines] = []
    var selectedRoutineToImport: Routines! // Routine yang akan di import datanya
    var selectedImportRoutineFrom : Routines? // Routine yang akan di ambil datanya
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        fetchRoutine()
//        refetchAllRoutine()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        refetchAllRoutine()
    }
    
    func registerCell(){
        importTableView.register(UINib.init(nibName: "ImportTableViewCell", bundle: nil), forCellReuseIdentifier: "importTableViewCell")
        
        importTableView.delegate = self
        importTableView.dataSource = self
    }
//
//    func fetchRoutine(){
//        print("FETCH ROUTINE")
//        self.routines = PersistanceManager.shared.fetchRoutines()
////        routines = routines.filter({$0.userroutine. })
//    }
    
    func refetchAllRoutine() {
        routines = []
            let user = PersistanceManager.shared.fetchUser()
            routines = PersistanceManager.shared.fetchRoutines().filter({$0.userroutine?.id == user.id})
            routines = routines.filter({ $0.startHabit != nil })
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveToImportProduct"{
           guard let nav = segue.destination as? UINavigationController else {
               return
           }
           
           guard let importVC = nav.topViewController as? ImportProductViewController else {
              return
           }
           
            importVC.selectedRoutineToImport = self.selectedRoutineToImport
            importVC.selectedImportRoutineFrom = self.selectedImportRoutineFrom
       }
    }
}


extension ImportViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = tableView.dequeueReusableCell(withIdentifier: "importTableViewCell") as! ImportTableViewCell
        
        if let name = routines[indexPath.row].name{
            row.setUI(setTitle : name)
        }
        
        
        return row
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedImportRoutineFrom = routines[indexPath.row]
        self.performSegue(withIdentifier: "moveToImportProduct", sender: self)
    }
    
    
}
