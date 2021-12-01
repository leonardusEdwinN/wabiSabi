//
//  OverlayCalenderView.swift
//  WabiSabiTeamProject
//
//  Created by Albert . on 18/11/21.
//

import UIKit


class OverlayCalenderView: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var delegate : OverlayButtonProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "MMM dd yyyy"
        
        guard let time = self.datePicker else {
            fatalError("Fatal error: Unexpectedly found nil while implicitly unwrapping an Optional value ")
        }

        let strDate = timeFormatter.string(from: time.date)
            // do what you want to do with the string.
        
        delegate?.buttonSavePressed(time: "\(strDate)")
        self.dismiss(animated: true, completion: nil)
        print("time : \(strDate)")
    }
    
    
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
}
