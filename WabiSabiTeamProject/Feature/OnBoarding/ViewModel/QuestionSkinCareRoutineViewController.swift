//
//  QuestionSkinCareRoutineViewController.swift
//  WabiSabiTeamProject
//
//  Created by Giovanni Tjahyamulia on 28/10/21.
//

import UIKit

class QuestionSkinCareRoutineViewController: UIViewController {
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var skinCareRoutineTableView: UITableView!
    @IBOutlet weak var buttonNext: UIButton!
    
    var skinCareRoutines: [String] = ["I barely know any skin care routine", "I only do it if I remember", "I’m quite familiar with it", "You can call me a skin care expert"]
    
    var indexSelected: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        skinCareRoutineTableView.delegate = self
        skinCareRoutineTableView.dataSource = self
        
        buttonNext.isEnabled = false
    }
    
    @IBAction func next(_ sender: Any) {
        UserDefaults.standard.set(indexSelected, forKey: "skinCareRoutines")
    }
}

extension QuestionSkinCareRoutineViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skinCareRoutines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = skinCareRoutineTableView.dequeueReusableCell(withIdentifier: "routineskincarecell") as! OptionTableViewCell
        
        cell.optionTitle.text = skinCareRoutines[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexSelected = indexPath.row
        if buttonNext.isEnabled == false {
            Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { timer in
                DispatchQueue.main.async { [self] in
                    var counter = progressView.progress + 0.01
                    if counter <= 0.33 {
                        progressView.progress = counter
                    }
                    else {
                        timer.invalidate()
                        
                        buttonNext.isEnabled = true
                    }
                    
                }
            }
        }
    }
}
