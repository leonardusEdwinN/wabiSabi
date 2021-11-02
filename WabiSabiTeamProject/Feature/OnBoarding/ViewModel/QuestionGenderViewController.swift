//
//  QuestionGenderViewController.swift
//  WabiSabiTeamProject
//
//  Created by Giovanni Tjahyamulia on 28/10/21.
//

import UIKit

class QuestionGenderViewController: UIViewController {
    @IBOutlet weak var genderTableView: UITableView!
    @IBOutlet weak var buttonNext: UIButton!
    
    var genders: [String] = ["Female", "Male", "Non-Binary", "Prefer not to disclose"]
    
    var indexSelected: Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        genderTableView.delegate = self
        genderTableView.dataSource = self
    
        buttonNext.isHidden = true
    }
    
    @IBAction func next(_ sender: Any) {
        UserDefaults.standard.set(genders[indexSelected], forKey: "gender")
    }
}

extension QuestionGenderViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = genderTableView.dequeueReusableCell(withIdentifier: "gendercell") as! GenderTableViewCell
        
        cell.genderLabel.text = genders[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if buttonNext.isHidden == true {
            buttonNext.isHidden = false
        }
        
        indexSelected = indexPath.row
    }
}
