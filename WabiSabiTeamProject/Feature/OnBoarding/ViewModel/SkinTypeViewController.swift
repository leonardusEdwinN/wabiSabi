//
//  SkinTypeViewController.swift
//  WabiSabiTeamProject
//
//  Created by Giovanni Tjahyamulia on 01/11/21.
//

import UIKit

class SkinTypeViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
    }
    
    @IBAction func closeSegue(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
