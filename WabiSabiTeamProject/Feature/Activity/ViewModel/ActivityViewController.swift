//
//  ActivityViewController.swift
//  WabiSabiTeamProject
//
//  Created by Albert . on 05/11/21.
//

import UIKit

class ActivityViewController: UIViewController {
    
    @IBOutlet weak var routineCollectionView: UICollectionView!
    @IBOutlet weak var circularProgress: CircularProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        setUpcircularProgress()
        routineCollectionView.dataSource = self
        routineCollectionView.delegate = self
        routineCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
    
    private func configureNavigationBar() {
        title = "Today"
        let menuButton = UIBarButtonItem(image: UIImage(named: "Calender"), style: .plain, target: self, action: nil)
        menuButton.tintColor = UIColor.systemIndigo
        navigationItem.rightBarButtonItems = [menuButton]
    }
    
    private func setUpcircularProgress() {
        circularProgress.progressColor = UIColor.systemIndigo
        circularProgress.trackColor = UIColor.systemGray4
        circularProgress.percentageValue = 0.8
    }
}

extension ActivityViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return routines.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoutineCollectionViewCell", for: indexPath) as! RoutineCollectionViewCell
        cell.setup(with: routines[indexPath.row])
        
        return cell
    }
}

extension ActivityViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 88)
    }
}

extension ActivityViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(routines[indexPath.row])
    }
}
