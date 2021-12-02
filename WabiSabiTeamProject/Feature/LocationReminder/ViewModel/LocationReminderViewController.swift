//
//  LocationReminderViewController.swift
//  WabiSabiTeamProject
//
//  Created by Edwin Niwarlangga on 16/11/21.
//

import UIKit
struct LocationModel {
    var locationName : String
    var locationImage : String
}

class LocationReminderViewController: UIViewController {
    // MARK: Navigation
    @IBOutlet weak var buttonAdd: UIButton!
    @IBOutlet weak var labelTitlePage: UILabel!
    @IBOutlet weak var buttonBack: UIButton!
    
    @IBAction func buttonBackPressed(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func buttonAddPressed(_ sender: Any) {
        performSegue(withIdentifier: "GoToAddGeoLocationPage", sender: self)
    }
    
    // MARK: TableView
    @IBOutlet weak var locationsReminderTableView: UITableView!
    
    // MARK: EmptyState
    @IBOutlet weak var viewEmptyState: UIView!
    @IBOutlet weak var viewCircle: UIView!
    var tableLocationArray : [LocationModel] = []
//    = [ LocationModel(locationName: "Bandung, Jawa Barat", locationImage: "mappin")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewCircle.layer.cornerRadius = viewCircle.frame.size.width / 2
        
        if tableLocationArray.count == 0 {
            locationsReminderTableView.isHidden = true
            viewEmptyState.isHidden = false
        }else{
            
            locationsReminderTableView.isHidden = false
            viewEmptyState.isHidden = true
        }
        
        registerCell()
    }
    
    
    func registerCell(){
        
        
        locationsReminderTableView.register(UINib.init(nibName: "LocationTableViewCell", bundle: nil), forCellReuseIdentifier: "locationTableViewCell")
        
        locationsReminderTableView.delegate = self
        locationsReminderTableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToAddGeoLocationPage"{
            if let destVC = segue.destination as? AddGeotificationController {
                destVC.modalPresentationStyle = .fullScreen
            }
        }
    }

}


extension LocationReminderViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableLocationArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = tableView.dequeueReusableCell(withIdentifier: "locationTableViewCell") as! LocationTableViewCell
        
        row.setUI(
            title: tableLocationArray[indexPath.item].locationName,
            image: tableLocationArray[indexPath.item].locationImage
        )
        return row
        
    }
    
    
}
