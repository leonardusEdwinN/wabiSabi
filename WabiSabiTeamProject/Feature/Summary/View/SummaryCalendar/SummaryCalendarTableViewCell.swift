//
//  SummaryCalendarTableViewCell.swift
//  WabiSabiTeamProject
//
//  Created by Edwin Niwarlangga on 04/11/21.
//

import UIKit

class SummaryCalendarTableViewCell: UITableViewCell {
    
    @IBOutlet weak var calendarDayCollectionView: UICollectionView!
    
    //for Month
//    var delegate: MonthViewDelegate?
    
    @IBOutlet weak var monthView: UIView!
//    @IBOutlet weak var outerView: UIView!
    // MARK: Variable MonthView
    var monthsArr = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    var currentMonthIndex = 0
    var currentYear: Int = 0
    
    @IBOutlet weak var buttonLeft: UIButton!
    @IBOutlet weak var buttonRight: UIButton!
    @IBOutlet weak var labelBulan: UILabel!
    
    // MARK: Variable Weekly
    @IBOutlet weak var horizontalStackView: UIStackView!
    var daysArr = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]
    
    // MARK: Variable Day
    var numOfDaysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
    var todaysDate = 0
    var firstWeekDayOfMonth = 0   //(Sunday-Saturday 1-7)
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        outerView.layer.shadowColor = UIColor.lightGray.cgColor
//        outerView.layer.shadowOpacity = 1
//        outerView.layer.shadowOffset = .zero
//        outerView.layer.shadowRadius = 10
//        outerView.layer.cornerRadius = 15
//        outerView.layer.masksToBounds = true
        
        //get bulan ini
        currentMonthIndex = Calendar.current.component(.month, from: Date()) - 1 //soalnya arraynya di mulai dari 0
        currentYear = Calendar.current.component(.year, from: Date())
        
        print("current month index : \(currentMonthIndex) :: \(monthsArr[currentMonthIndex])")
        labelBulan.text="\(monthsArr[currentMonthIndex]) \(currentYear)"
        
        setupViewWeekly()
        setupViewDay()
        
        calendarDayCollectionView.register(UINib.init(nibName: "DayCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "calendarDayCollectionViewCell")
        calendarDayCollectionView.delegate = self
        calendarDayCollectionView.dataSource = self
        
        
        buttonLeft.addTarget(self, action: #selector(buttonLeftOrRightPressed), for : .touchUpInside)
        buttonRight.addTarget(self, action: #selector(buttonLeftOrRightPressed), for : .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension SummaryCalendarTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.calendarDayCollectionView {
            print("CELL month index : \(currentMonthIndex) :: \(numOfDaysInMonth[currentMonthIndex]) :: \(firstWeekDayOfMonth - 1))")
            return numOfDaysInMonth[currentMonthIndex] + firstWeekDayOfMonth - 1
        }
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.calendarDayCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarDayCollectionViewCell", for: indexPath) as! DayCollectionViewCell

            if indexPath.item <= firstWeekDayOfMonth - 2 {
                cell.isHidden=true
            } else {
                
                
                //Progress Ciruclar
                let totalActivity: CGFloat = 10 //banyak aktivitas nanti
                let activityDone: CGFloat = CGFloat(Float.random(in: 0..<7)) //banyak aktivitas nanti
                let calculateProgress = CGFloat(activityDone / totalActivity)
                
                //calculate Date
                let calcDate = indexPath.row-firstWeekDayOfMonth+2
                cell.isHidden=false
                
                DispatchQueue.main.async {
                    cell.setUI(labelTanggal: "\(calcDate)", progress: calculateProgress)
                }
                
            }
            
            
            return cell
            
        }
        
        return UICollectionViewCell()
    }
}

extension SummaryCalendarTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var widthCell : CGSize = CGSize(width: 100, height: 100)
        
        if collectionView == self.calendarDayCollectionView{
            let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            layout.invalidateLayout()
            
            widthCell =  CGSize(width: (self.frame.width - 30) / 7 , height: self.frame.width / 7) // Set your item size here
        }else{
            widthCell =  CGSize(width: 125 , height:150)
        }
        
        return widthCell
    }
}

// MARK: MonthView
extension SummaryCalendarTableViewCell{
    
    @IBAction func buttonLeftOrRightPressed(_ sender: UIButton) {
        print("BUTTON CLICK")
        if sender == buttonRight {
            print("MASUK KE KANAN")
            currentMonthIndex += 1
            if currentMonthIndex > 11 {
                currentMonthIndex = 0
                currentYear += 1
            }
        } else {
            print("MASUK KE KIRI")
            currentMonthIndex -= 1
            if currentMonthIndex < 0 {
                currentMonthIndex = 11
                currentYear -= 1
            }
        }
        print("current index disini : \(currentMonthIndex)")
        labelBulan.text="\(monthsArr[currentMonthIndex]) \(currentYear)"
        didChangeMonth()
        print("BUTTON END CLICK")
        print("")
    }
}

// MARK: WeeklyView
extension SummaryCalendarTableViewCell{
    func setupViewWeekly() {
        for i in 0..<7 {
            let lbl=UILabel()
            lbl.text=daysArr[i]
            lbl.textAlignment = .center
            horizontalStackView.addArrangedSubview(lbl)
        }
        
        horizontalStackView.distribution = .fillEqually
    }
}

// MARK: DayView
extension SummaryCalendarTableViewCell{
    func setupViewDay(){
        currentMonthIndex = Calendar.current.component(.month, from: Date()) - 1
        print("CURRENT MONTH INDEX SETUPVIEWDAY : \(currentMonthIndex)")
        currentYear = Calendar.current.component(.year, from: Date())
        todaysDate = Calendar.current.component(.day, from: Date())
        firstWeekDayOfMonth = getFirstWeekDay()
        
        //for leap years, make february month of 29 days
        if currentMonthIndex == 1 && currentYear % 4 == 0 {
            numOfDaysInMonth[currentMonthIndex] = 29
        }
        //end
        
    }
    
    func getFirstWeekDay() -> Int {
        print("current year : \(currentYear) ::currentmonth : \(currentMonthIndex) ")
        let day = ("\(currentYear)-\(currentMonthIndex + 1)-01".date?.firstDayOfTheMonth.weekday)!
        print("D : \(day)")
//        return day == 7 ? 1 : day
        return day
    }
    
    func didChangeMonth() {
//        var index = monthIndex+1
        print("DID CHANGE MONTH : \(currentMonthIndex)")
        
        //for leap year, make february month of 29 days
        if currentMonthIndex == 1 {
            if currentYear % 4 == 0 {
                numOfDaysInMonth[currentMonthIndex] = 29
            } else {
                numOfDaysInMonth[currentMonthIndex] = 28
            }
        }
        //end
        
        firstWeekDayOfMonth = getFirstWeekDay()
        
        calendarDayCollectionView.reloadData()
    }
}
