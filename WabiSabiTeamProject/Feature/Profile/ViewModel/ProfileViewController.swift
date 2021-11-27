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
    @IBOutlet weak var btnEditProfile: UIButton!
    @IBOutlet weak var switchTableViewButton: UISegmentedControl!
    @IBOutlet weak var productTableView: UITableView!
    
    var currentTableView: [RoutineAndProductList] = routinesProfile
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setUpTableView()
        configureNavigationBar()
    }
    
    func setupView(){
        profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2
        
        btnEditProfile.layer.borderWidth = 1
        btnEditProfile.layer.borderColor = UIColor.black.cgColor
        btnEditProfile.layer.cornerRadius = 10
    }
    
    private func setUpTableView() {
        productTableView.dataSource = self
        productTableView.delegate = self
        let nib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        productTableView.register(nib, forCellReuseIdentifier: "ProductTableViewCell")
    }
    
    private func configureNavigationBar() {
        title = "Profile"
        let menuButton = UIBarButtonItem(image: UIImage(named: "Setting"), style: .plain, target: self, action: #selector(tapMenuButton))
        menuButton.tintColor = UIColor.black
        navigationItem.rightBarButtonItems = [menuButton]
    }
    
    @IBAction func changeTableView(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            currentTableView = routinesProfile
        } else {
            currentTableView = productsProfile
        }
        
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
        currentTableView.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
        cell.setup(with: currentTableView[indexPath.row])
        
        return cell
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
