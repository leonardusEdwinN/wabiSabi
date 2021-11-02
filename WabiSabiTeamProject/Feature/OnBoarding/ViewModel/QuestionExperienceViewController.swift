//
//  QuestionLevelViewController.swift
//  WabiSabiTeamProject
//
//  Created by Giovanni Tjahyamulia on 28/10/21.
//

import UIKit

class QuestionExperienceViewController: UIViewController {
    @IBOutlet weak var skincareExperienceTableView: UITableView!
    @IBOutlet weak var buttonNext: UIButton!
    
    var skinCareExperience: [String] = ["I want to start from the basic", "I want to maintain my routine", "I want to step up my skincare routine"]
    
    var indexSelected: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        skincareExperienceTableView.delegate = self
        skincareExperienceTableView.dataSource = self
        
        buttonNext.isHidden = true
    }
    
    @IBAction func next(_ sender: Any) {
        UserDefaults.standard.set(skinCareExperience[indexSelected], forKey: "skinCareExperience")
    }
}

extension QuestionExperienceViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skinCareExperience.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = skincareExperienceTableView.dequeueReusableCell(withIdentifier: "experienceskincarecell") as! SkinCareRoutineTableViewCell
        
        cell.skincareRoutineTitle.text = skinCareExperience[indexPath.row]
        cell.skincareRoutineDescription.text = "Description"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 73
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        indexSelected = indexPath.row
        
        if buttonNext.isHidden == true {
            buttonNext.isHidden = false
        }
    }
}
