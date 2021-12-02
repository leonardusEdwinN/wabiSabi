//
//  LoadingViewController.swift
//  WabiSabiTeamProject
//
//  Created by Giovanni Tjahyamulia on 01/11/21.
//

import UIKit

class LoadingViewController: UIViewController {
    @IBOutlet var background: UIView!
    @IBOutlet weak var circularProgressLabel: UILabel!
    @IBOutlet weak var circularProgress: CircularProgressBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    func setUI() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(red: 181.0/255.0, green: 171.0/255.0, blue: 223.0/255.0, alpha: 1).cgColor, UIColor(red: 227.0/255.0, green: 208.0/255.0, blue: 197.0/255.0, alpha: 1).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        circularProgress.progress = 0
        circularProgressLabel.text = "0%"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Timer.scheduledTimer(withTimeInterval: 0.025, repeats: true) { timer in
            DispatchQueue.main.async { [self] in
                var counter = circularProgress.progress + 0.01
                if counter <= 1.01 {
                    circularProgress.progress = counter
                    circularProgressLabel.text = "\(Int(counter * 100))%"
                }
                else {
                    timer.invalidate()
                    
                    let storyboard = UIStoryboard(name: "OnBoarding", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "Result") as UIViewController
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }
            }
        }
    }
}
