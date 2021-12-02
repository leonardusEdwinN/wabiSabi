//
//  QuestionLevelViewController.swift
//  WabiSabiTeamProject
//
//  Created by Giovanni Tjahyamulia on 28/10/21.
//

import UIKit

class QuestionExperienceViewController: UIViewController {
    @IBOutlet var background: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var skincareExperienceTableView: UITableView!
    @IBOutlet weak var buttonNext: UIButton!
    
    var skinCareExperience: [String] = [
        "I want to start from the basic",
        "I want to maintain my current routine",
        "I want to step up my skincare routine"
    ]
    
    var indexSelected: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        skincareExperienceTableView.delegate = self
        skincareExperienceTableView.dataSource = self
        
        buttonNext.isEnabled = false
        
        setUI()
    }
    
    func setUI() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(red: 181.0/255.0, green: 171.0/255.0, blue: 223.0/255.0, alpha: 1).cgColor, UIColor(red: 227.0/255.0, green: 208.0/255.0, blue: 197.0/255.0, alpha: 1).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at:0)
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
    }
    
    @IBAction func back(_ sender: Any) {
        Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { timer in
            DispatchQueue.main.async { [self] in
                var counter = progressView.progress - 0.01
                if counter >= 0.33 {
                    progressView.progress = counter
                }
                else {
                    timer.invalidate()
                    
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func next(_ sender: Any) {
        UserDefaults.standard.set(indexSelected, forKey: "skinCareExperience")
    }
}

extension QuestionExperienceViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skinCareExperience.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = skincareExperienceTableView.dequeueReusableCell(withIdentifier: "experienceskincarecell") as! OptionTableViewCell
        
        cell.optionTitle.text = skinCareExperience[indexPath.row]
        cell.whiteGradientBackground.frame.size = CGSize(width: cell.layer.frame.width, height: 70)
        
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
                    if counter <= 0.5 {
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
