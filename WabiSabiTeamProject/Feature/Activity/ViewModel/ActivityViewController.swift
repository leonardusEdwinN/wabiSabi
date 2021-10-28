//
//  ViewController.swift
//  WabiSabiTeamProject
//
//  Created by Edwin Niwarlangga on 26/10/21.
//

import UIKit

class ActivityViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        // Do any additional setup after loading the view.
    }
    
    private func configureNavigationBar() {
        title = "Today"
        let menuButton = UIBarButtonItem(image: UIImage(named: "Calender"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItems = [menuButton]
    }
}

