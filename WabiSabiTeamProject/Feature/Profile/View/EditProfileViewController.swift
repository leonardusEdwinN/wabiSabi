//
//  EditProfileViewController.swift
//  WabiSabiTeamProject
//
//  Created by Albert . on 26/11/21.
//

import UIKit

class EditProfileViewController: UIViewController {
    @IBOutlet weak var notificationSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem()
        backButton.title = "My Back Button Title"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        // Do any additional setup after loading the view.
    }
    
    // MARK: CHANGE USER NOTIFICATION STATUS
    @IBAction func switchNotificationValueChange(_ sender: Any) {
        if let userID: String = UserDefaults.standard.string(forKey: "userID") {
            PersistanceManager.shared.changeUserNotification(id: userID, status: notificationSwitch.isOn)
        }
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
