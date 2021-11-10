//
//  ProfileViewController.swift
//  WabiSabiTeamProject
//
//  Created by Edwin Niwarlangga on 10/11/21.
//

import Foundation
import UIKit

class ProfileViewController : UIViewController{
    @IBOutlet weak var profileImage: UIView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var btnSetting: UIButton!
    @IBOutlet weak var btnEditProfile: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    func setupView(){
        profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2
        
        btnEditProfile.layer.borderWidth = 1
        btnEditProfile.layer.borderColor = UIColor.white.cgColor
        btnEditProfile.layer.cornerRadius = 15
    }
}
