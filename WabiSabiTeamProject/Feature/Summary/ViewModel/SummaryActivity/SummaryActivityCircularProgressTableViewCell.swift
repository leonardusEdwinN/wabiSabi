//
//  SummaryActivityCircularProgressTableViewCell.swift
//  WabiSabiTeamProject
//
//  Created by Giovanni Tjahyamulia on 01/12/21.
//

import UIKit

class SummaryActivityCircularProgressTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var noDataLabel: UILabel!
    
    var data: [Routines]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.register(UINib.init(nibName: "ActivityCircularProgressCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ActivityCircularProgressCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.reloadData()
        
        if !(data == [] || data == nil || data.isEmpty) {
            noDataLabel.isHidden = true
        }
        else{
            noDataLabel.isHidden = false
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(newData: [Routines]){
        data = newData
        collectionView.reloadData()
        
        if !(data == []) {
            noDataLabel.isHidden = true
        }
        else{
            noDataLabel.isHidden = false
        }
    }
    
    func filterRoutine(filterDate: Date, routines: [Routines]) -> [Routines] {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        
        var date: String = df.string(from: filterDate)
        
        var filteredItems: [Routines] = []
        for i in 0..<routines.count {
            let routineDate: String = df.string(from: routines[i].routineDate ?? Date())
            if (routineDate.elementsEqual(date)) {
                filteredItems.append(routines[i])
            }
        }
        return filteredItems
    }

    func calculateProgress(routine: Routines) -> CGFloat{
        var completedRoutine: CGFloat = 0.0
        var totalRoutine: CGFloat = 0.0
        if routine.routineproduct != nil {
            var products: [Product] = PersistanceManager.shared.fetchProduct(routine: routine)
            if !products.isEmpty{
                for productIndex in 0..<products.count {
                    totalRoutine += 1.0
                    if (products[productIndex].isDone) {
                        completedRoutine += 1.0
                    }
                }
            }
        }
        return CGFloat(completedRoutine) / CGFloat(totalRoutine)
    }
}

extension SummaryActivityCircularProgressTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActivityCircularProgressCollectionViewCell", for: indexPath) as! ActivityCircularProgressCollectionViewCell
        
        cell.routineNameLabel.text = data[indexPath.row].name
        
        var circularProgressValue = calculateProgress(routine: data[indexPath.row])
        cell.circularProgressActivity.progress = circularProgressValue
        
        print(indexPath.row, "-", circularProgressValue)
        
        if data[indexPath.row].isSkipped {
            cell.circularProgressActivity.progress = 0.0
            cell.circularProgressActivity.fillColor = UIColor.lightGray.cgColor
            cell.circularProgressActivity.strokeColor = UIColor.clear.cgColor
            cell.routineNameLabel.textColor = UIColor.lightGray
        }
        else {
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
        }
        
        if circularProgressValue == 0.0 {
            cell.circularProgressActivity.progress = 0.01
        }
        
        /*
        if data[indexPath.row].isCompleted {
            cell.circularProgressActivity.progress = 1.0
        }
        else if data[indexPath.row].isSkipped {
            cell.circularProgressActivity.progress = 0.0
            cell.circularProgressActivity.fillColor = UIColor.lightGray.cgColor
            cell.circularProgressActivity.strokeColor = UIColor.clear.cgColor
            cell.routineNameLabel.textColor = UIColor.lightGray
        }
        else {
            cell.circularProgressActivity.progress = 0.001
        }
        */
        
        /*
        // DUMMY
        cell.circularProgressActivity.progress = 0.0
        cell.circularProgressActivity.strokeColor = Utilities().routineCategory[indexPath.row].color.cgColor
        cell.iconLabel.text = Utilities().routineCategory[indexPath.row].icon
        cell.routineNameLabel.text = Utilities().routineCategory[indexPath.row].name
        cell.routineNameLabel.textColor = Utilities().routineCategory[indexPath.row].color
         */
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}
