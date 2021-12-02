//
//  AddGeotificationViewController.swift
//  WabiSabiTeamProject
//
//  Created by Edwin Niwarlangga on 18/11/21.
//

import Foundation
import UIKit
import MapKit

protocol AddGeotificationsViewControllerDelegate: class {
  func addGeotificationViewController(_ controller: AddGeotificationController, didAddGeotification: Geotification)
}

class AddGeotificationController : UIViewController{
    
    // MARK: navigation
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var locationFinderButton: UIButton!
    
    // MARK: segmentedControl
    @IBOutlet weak var eventTypeSegmentedControl: UISegmentedControl!
    // MARK: MAPVIEW
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var searchResultTableView: UITableView!
    
    // MARK: variable
    weak var delegate: AddGeotificationsViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
    }
    
    func registerCell(){
        searchResultTableView.register(UINib.init(nibName: "SearchResultTableViewCell", bundle: nil), forCellReuseIdentifier: "searchResultTableViewCell")
        
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
    }
}

extension AddGeotificationController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = tableView.dequeueReusableCell(withIdentifier: "searchResultTableViewCell") as! SearchResultTableViewCell
        
        return row
    }
    
    
}


extension AddGeotificationController{
    // MARK: EXTENSION NAVIGATION
    
    @IBAction func buttonSavePressed(_ sender: Any) {
        let coordinate = mapView.centerCoordinate
//        let radius = Double(radiusTextField.text ?? "") ?? 0
        let identifier = NSUUID().uuidString
//        let note = noteTextField.text ?? ""
        let eventType: Geotification.EventType = (eventTypeSegmentedControl.selectedSegmentIndex == 0) ? .onEntry : .onExit
        let geotification = Geotification(
          coordinate: coordinate,
          radius: Double(100),
          identifier: identifier,
          note: "",
          eventType: eventType)
        
        delegate?.addGeotificationViewController(self, didAddGeotification: geotification)
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func locationFinderButtonPressed(_ sender: Any) {
        print("CLIKCED")
        mapView.zoomToLocation(mapView.userLocation.location)
    }
}

extension MKMapView {
  func zoomToLocation(_ location: CLLocation?) {
    guard let coordinate = location?.coordinate else { return }
    let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10_000, longitudinalMeters: 10_000)
    setRegion(region, animated: true)
  }
}
