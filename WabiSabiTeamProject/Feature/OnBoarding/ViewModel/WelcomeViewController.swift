//
//  WelcomeViewController.swift
//  WabiSabiTeamProject
//
//  Created by Giovanni Tjahyamulia on 30/11/21.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet var background: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var buttonGetStarted: UIButton!
    @IBOutlet weak var welcomeBackground: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    func setUI() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(red: 181.0/255.0, green: 171.0/255.0, blue: 223.0/255.0, alpha: 1).cgColor, UIColor(red: 227.0/255.0, green: 208.0/255.0, blue: 197.0/255.0, alpha: 1).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at:0)
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        
        welcomeBackground.transform = welcomeBackground.transform.rotated(by: CGFloat(-Double.pi / 2)) //90 degree
    }
}
