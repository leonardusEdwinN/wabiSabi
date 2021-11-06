//
//  SkinTypeQuestionViewController.swift
//  WabiSabiTeamProject
//
//  Created by Giovanni Tjahyamulia on 28/10/21.
//

import UIKit

class QuestionSkinTypeViewController: UIViewController {
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var skinTypeTableView: UITableView!
    @IBOutlet weak var buttonNext: UIButton!
    
    var skinTypes: [String] = ["Oily", "Dry", "Combination", "Normal"]
    
    var indexSelected: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        skinTypeTableView.delegate = self
        skinTypeTableView.dataSource = self
        
        buttonNext.isEnabled = false
    }
    
    @IBAction func next(_ sender: Any) {
        UserDefaults.standard.set(indexSelected, forKey: "skinTypes")
    }
}

extension QuestionSkinTypeViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skinTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = skinTypeTableView.dequeueReusableCell(withIdentifier: "skintypecell") as! OptionTableViewCell
        
        cell.optionTitle.text = skinTypes[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        indexSelected = indexPath.row
        
        if buttonNext.isEnabled == false {
            Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { timer in
                DispatchQueue.main.async { [self] in
                    var counter = progressView.progress + 0.01
                    if counter <= 0.17 {
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
