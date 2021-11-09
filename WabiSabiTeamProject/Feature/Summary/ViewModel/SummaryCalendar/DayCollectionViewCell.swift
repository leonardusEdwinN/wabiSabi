//
//  DayCollectionViewCell.swift
//  CobaCalendar
//
//  Created by Edwin Niwarlangga on 26/10/21.
//

import UIKit

class DayCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var circularProgressView: CircularProgressBar!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        circularProgressView.progress = 0
    }
    
    func setUI(labelTanggal : String, progress: CGFloat){
        //dayString untuk hari, dateText untuk tanggal
        self.labelDate.text = labelTanggal
        circularProgressView.progress = progress
       
        
    }

}
