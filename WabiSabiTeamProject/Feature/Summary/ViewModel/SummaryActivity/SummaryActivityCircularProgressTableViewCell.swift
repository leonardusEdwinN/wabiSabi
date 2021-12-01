//
//  SummaryActivityCircularProgressTableViewCell.swift
//  WabiSabiTeamProject
//
//  Created by Giovanni Tjahyamulia on 01/12/21.
//

import UIKit

class SummaryActivityCircularProgressTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var data: [Routines]!
    var indexSelected: Int = 0
    var sectionSelected: Int = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.register(UINib.init(nibName: "ActivityCircularProgressCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ActivityCircularProgressCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}

extension SummaryActivityCircularProgressTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActivityCircularProgressCollectionViewCell", for: indexPath) as! ActivityCircularProgressCollectionViewCell
        
        if !data.isEmpty {
            cell.routineNameLabel.text = data[indexPath.row].name
            
            // get Asset
            for i in 0..<Utilities().routineCategory.count {
                var libraryData = Utilities().routineCategory[i].name
                var dataToSearch = data[indexPath.row].name
                if dataToSearch == libraryData {
                    cell.iconLabel.text = Utilities().routineCategory[i].icon
                    cell.routineNameLabel.textColor = Utilities().routineCategory[i].color
                    cell.circularProgressActivity.strokeColor = Utilities().routineCategory[i].color.cgColor
                    break;
                }
            }
            
            if data[indexPath.row].isCompleted {
                cell.circularProgressActivity.progress = 1.0
            }
            else {
                cell.circularProgressActivity.progress = 0.0
                cell.circularProgressActivity.fillColor = UIColor.lightGray.cgColor
                cell.circularProgressActivity.strokeColor = UIColor.clear.cgColor
                cell.routineNameLabel.textColor = UIColor.lightGray
            }
        }
        
        else {
            // DUMMY
            cell.circularProgressActivity.progress = CGFloat.random(in: 0.00...1.00)
            cell.circularProgressActivity.strokeColor = Utilities().routineCategory[indexPath.row].color.cgColor
            cell.iconLabel.text = Utilities().routineCategory[indexPath.row].icon
            cell.routineNameLabel.text = Utilities().routineCategory[indexPath.row].name
            cell.routineNameLabel.textColor = Utilities().routineCategory[indexPath.row].color
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
