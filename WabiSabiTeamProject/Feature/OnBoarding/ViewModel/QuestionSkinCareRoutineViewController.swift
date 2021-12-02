//
//  QuestionSkinCareRoutineViewController.swift
//  WabiSabiTeamProject
//
//  Created by Giovanni Tjahyamulia on 28/10/21.
//

import UIKit

class QuestionSkinCareRoutineViewController: UIViewController {
    @IBOutlet var background: UIView!
    @IBOutlet weak var titleLabel: UILabel!
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
                if counter >= 0.16 {
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
