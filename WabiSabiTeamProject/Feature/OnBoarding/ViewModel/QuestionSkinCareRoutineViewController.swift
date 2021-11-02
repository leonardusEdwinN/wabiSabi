//
//  QuestionSkinCareRoutineViewController.swift
//  WabiSabiTeamProject
//
//  Created by Giovanni Tjahyamulia on 28/10/21.
//

import UIKit

class QuestionSkinCareRoutineViewController: UIViewController {
    @IBOutlet weak var skinCareRoutineTableView: UITableView!
    @IBOutlet weak var buttonNext: UIButton!
    
    var skinCareRoutines: [String] = ["I just started", "I do it if I remember", "I do it everyday, but not routinely", "Everyday complete skincare routine"]
    
    var indexSelected: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        skinCareRoutineTableView.delegate = self
        skinCareRoutineTableView.dataSource = self
        
        buttonNext.isHidden = true
    }
    
    @IBAction func next(_ sender: Any) {
        UserDefaults.standard.set(skinCareRoutines[indexSelected], forKey: "skinCareRoutines")
    }
}

extension QuestionSkinCareRoutineViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skinCareRoutines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = skinCareRoutineTableView.dequeueReusableCell(withIdentifier: "routineskincarecell") as! SkinCareRoutineTableViewCell
        
        cell.skincareRoutineTitle.text = skinCareRoutines[indexPath.row]
        cell.skincareRoutineDescription.text = "Description"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 73
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if buttonNext.isHidden == true {
            buttonNext.isHidden = false
        }
    }
}
