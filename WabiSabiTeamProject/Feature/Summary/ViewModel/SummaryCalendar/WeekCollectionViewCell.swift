//
//  WeekCollectionViewCell.swift
//  CobaCalendar
//
//  Created by Edwin Niwarlangga on 27/10/21.
//

import UIKit

class WeekCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var labelDay: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUI(labelDay : String){
        //dayString untuk hari, dateText untuk tanggal
        self.labelDay.text = labelDay
//        self.labelTanggal.text = dateText
//        self.isSelected = isToday ? true : false
//        self.viewOuter.backgroundColor = isToday ? UIColor(named: "SweetMango")  :  .systemBackground
//        changeUpdate()
        
    }
}
