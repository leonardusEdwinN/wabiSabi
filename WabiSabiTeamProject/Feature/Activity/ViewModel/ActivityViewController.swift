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
        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)]
    }
}

