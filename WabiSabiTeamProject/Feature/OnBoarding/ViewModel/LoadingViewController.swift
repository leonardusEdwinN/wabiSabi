//
//  LoadingViewController.swift
//  WabiSabiTeamProject
//
//  Created by Giovanni Tjahyamulia on 01/11/21.
//

import UIKit

class LoadingViewController: UIViewController {
    @IBOutlet weak var circularProgressLabel: UILabel!
    @IBOutlet weak var circularProgress: CircularProgressBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        circularProgress.progress = 0
        circularProgressLabel.text = "0%"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
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
