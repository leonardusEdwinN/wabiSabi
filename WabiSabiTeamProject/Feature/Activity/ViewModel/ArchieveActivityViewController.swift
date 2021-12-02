//
//  ViewController.swift
//  WabiSabiTeamProject
//
//  Created by Edwin Niwarlangga on 26/10/21.
//

import UIKit

class ArchieveActivityViewController: UIViewController {
    
    @IBOutlet weak var progressIndicatorCollectionView: UICollectionView!
    
    let progressIndicatorCollectionViewCellId = "ProgressIndicatorHorizontalCollectionViewCell"
    
    var progressIndicators = [ProgressIndicator]()
    let cellScale:CGFloat = 0.6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        setUpCollectionView()
    }
    
    private func setUpCollectionView() {
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellScale)
        let cellHeight = floor(screenSize.height * cellScale)
        let insetX = (view.bounds.width - cellWidth) / 2.0
        let insetY = (view.bounds.height - cellHeight) / 2.0
        
        let layout = progressIndicatorCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        print("insetX");
        print(insetY)
        print(insetX)
        
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        progressIndicatorCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0 , bottom: 0, right: 0)
        
        // Register Cell
        let nibCell = UINib(nibName: progressIndicatorCollectionViewCellId, bundle: nil)
        progressIndicatorCollectionView.register(nibCell, forCellWithReuseIdentifier: progressIndicatorCollectionViewCellId)
        
        // Init Data
        for _ in 1...25 {
            let progressIndicator = ProgressIndicator()
            progressIndicator?.percentage = 80
            progressIndicator?.status = "Complete"
            progressIndicators.append(progressIndicator!)
        }
        
        progressIndicatorCollectionView.reloadData()
    }
    
    private func configureNavigationBar() {
        title = "Today"
        let menuButton = UIBarButtonItem(image: UIImage(named: "Calender"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItems = [menuButton]
    }
}

extension ArchieveActivityViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return progressIndicators.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset:CGFloat = 20
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 248, height: 177)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = progressIndicatorCollectionView.dequeueReusableCell(withReuseIdentifier: progressIndicatorCollectionViewCellId, for: indexPath) as! ProgressIndicatorHorizontalCollectionViewCell
        
        let progressIndicatorCell = progressIndicators[indexPath.row]
        cell.percentageLabel.text = String(progressIndicatorCell.percentage!) + "%"
        cell.statusLabel.text = progressIndicatorCell.status
        cell.percentageValue = CGFloat(progressIndicatorCell.percentage!) / CGFloat(100.0)
        
        print("PERCENTAGE2")
        print(progressIndicatorCell.percentage!)
        print(cell.percentageValue)
        
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = progressIndicatorCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
        
        targetContentOffset.pointee = offset
    }
}
