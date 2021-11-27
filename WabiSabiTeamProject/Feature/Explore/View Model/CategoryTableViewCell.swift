//
//  CategoryTableViewCell.swift
//  WabiSabiTeamProject
//
//  Created by Giovanni Tjahyamulia on 27/11/21.
//

import UIKit


protocol CollectionViewCellDelegate: class {
    func collectionView(collectionviewcell: SubcategoryCollectionViewCell?, index: Int, didTappedInTableViewCell: CategoryTableViewCell)
    // other delegate methods that you can define to perform action in viewcontroller
}

class CategoryTableViewCell: UITableViewCell {
    weak var cellDelegate: CollectionViewCellDelegate?
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var data: Categories!
    var indexSelected: Int = 0
    var sectionSelected: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        categoryLabel.font = UIFont.boldSystemFont(ofSize: 22)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}

extension CategoryTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.subcategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubCategoryCell", for: indexPath) as! SubcategoryCollectionViewCell
        cell.habitNameLabel.text = data.subcategories[indexPath.row].habitName
        cell.periodLabel.text = data.subcategories[indexPath.row].period
        cell.timeLabel.text = "~ \(data.subcategories[indexPath.row].timeInMinutes) mins"
        cell.notesLabel.text = data.subcategories[indexPath.row].notes
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UserDefaults.standard.set(sectionSelected, forKey: "sectionHabitSelected")
        UserDefaults.standard.set(indexPath.row, forKey: "habitSelected")
    }
}
