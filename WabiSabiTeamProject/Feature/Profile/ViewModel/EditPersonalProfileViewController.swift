//
//  EditPersonalProfileViewController.swift
//  WabiSabiTeamProject
//
//  Created by Giovanni Tjahyamulia on 02/12/21.
//

import UIKit

class EditPersonalProfileViewController: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var genderButton: UIButton!
    @IBOutlet weak var birthdateButton: UIButton!
    @IBOutlet weak var skinTypeButton: UIButton!
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    var user: User = PersistanceManager.shared.fetchUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        nameTextField.text = user.name
        genderButton.setTitle(user.gender, for: .normal)
        
        let df = DateFormatter()
        df.dateFormat = "dd / MM / yyyy"
        var date: String = df.string(from: user.dateOfBirth ?? Date())
        birthdateButton.setTitle(date, for: .normal)
        
        skinTypeButton.setTitle(user.skinType, for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Something Else"
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }
    
    @IBAction func seeSkinTypeModal(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "OnBoarding", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SkinTypeDetail") as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
