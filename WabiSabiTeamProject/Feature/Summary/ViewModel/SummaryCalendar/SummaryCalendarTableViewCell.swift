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
    @IBOutlet weak var shadowView: UIView!
    
    @IBOutlet weak var monthView: UIView!
//    @IBOutlet weak var outerView: UIView!
    // MARK: Variable MonthView
    var monthsArr = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    var currentMonthIndex = 0
    var currentYear: Int = 0
    
    var choosenMonth = 0
    var choosenYear = 0
    
    @IBOutlet weak var buttonLeft: UIButton!
    @IBOutlet weak var buttonRight: UIButton!
    @IBOutlet weak var labelBulan: UILabel!
    
    // MARK: Variable Weekly
    @IBOutlet weak var horizontalStackView: UIStackView!
    var daysArr = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    // MARK: Variable Day
    var numOfDaysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
    var todaysDate = 0
    var firstWeekDayOfMonth = 0   //(Sunday-Saturday 1-7)
    
    var allRoutines: [Routines]!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        outerView.layer.shadowColor = UIColor.lightGray.cgColor
//        outerView.layer.shadowOpacity = 1
//        outerView.layer.shadowOffset = .zero
//        outerView.layer.shadowRadius = 10
//        outerView.layer.cornerRadius = 15
//        outerView.layer.masksToBounds = true
        
        shadowView.layer.cornerRadius = 15
        calendarDayCollectionView.layer.cornerRadius = 15
        
        //get bulan ini
        currentMonthIndex = Calendar.current.component(.month, from: Date()) - 1 //soalnya arraynya di mulai dari 0
        currentYear = Calendar.current.component(.year, from: Date())
    
        labelBulan.text="\(monthsArr[currentMonthIndex]) \(currentYear)"
        choosenMonth = currentMonthIndex
        choosenYear = currentYear
        
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
    }
    
    func filterRoutine(date: Date, routines: [Routines]) -> [Routines] {
        let filteredItems = routines.filter { $0.routineDate == date }
        return filteredItems
    }
    
    func filterTodayRoutine(routines: [Routines]) -> [Routines] {
        let calendar = Calendar.current
        let todayRoutine = routines.filter({calendar.isDateInToday(($0.routineDate ?? Date.yesterday) as Date)})
        return todayRoutine
    }
    
    func calculatePercentage(routines: [Routines]) -> CGFloat{
        var completedRoutine: CGFloat = 0.0
        
        if(routines != nil){
            for i in 0...1 {
                if routines[i] != nil {
                    if routines[i].isCompleted {
                        completedRoutine = completedRoutine + 1.0
                    }
                }
            }
        }
        return CGFloat(completedRoutine) / CGFloat(routines.count)
    }
}

extension SummaryCalendarTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.calendarDayCollectionView {
            return numOfDaysInMonth[currentMonthIndex] + firstWeekDayOfMonth - 1
        }
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        /*
        if buttonNext.isHidden == true {
            buttonNext.isHidden = false
        }
        
        indexSelected = indexPath.row + 1
        
        for index in 0...skinTypes.count {
            if let imgView = collectionView.viewWithTag(index) as? UIImageView {
                imgView.image = UIImage(systemName: "circle")
            }
            if let backgroundView = collectionView.viewWithTag((index * 10) + index) as? UIImageView {
                // backgroundView.backgroundColor = UIColor(named: "ColorSecondary")
                backgroundView.alpha = 0.5
            }
        }
        
        if let imgView = collectionView.viewWithTag(indexSelected) as? UIImageView {
            imgView.image = UIImage(systemName: "checkmark.circle.fill")
        }
        if let backgroundView = collectionView.viewWithTag((indexSelected * 10) + indexSelected) as? UIImageView {
            // backgroundView.backgroundColor = UIColor(named: "ColorPrimary")
            backgroundView.alpha = 1
        }
        */
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.calendarDayCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarDayCollectionViewCell", for: indexPath) as! DayCollectionViewCell
            cell.tag = (indexPath.row + 1)
            if indexPath.item <= firstWeekDayOfMonth - 2 {
                cell.isHidden = true
            } else {
                //Progress Ciruclar
                var calculateProgress: CGFloat = 0.0
                
                //calculate Date
                let calcDate = indexPath.row-firstWeekDayOfMonth+2
                cell.isHidden=false
                
                // check today
                var day = Calendar.current.component(.day, from: Date())
                var month = Calendar.current.component(.month, from: Date()) - 1 //soalnya arraynya di mulai dari 0
                var year = Calendar.current.component(.year, from: Date())
                
                if(calcDate == day && choosenMonth == month && choosenYear == year) {
                    cell.labelDate.textColor = UIColor.systemIndigo
                    
                    var temp: [Routines] = filterTodayRoutine(routines: allRoutines)
                    calculateProgress = calculatePercentage(routines: temp)
                }
                else {
                    cell.labelDate.textColor = UIColor.black
                }
                
                if( (calcDate > day && choosenMonth == month && choosenYear == year) || (choosenMonth > month && choosenYear == year) || (choosenYear > year) || calculateProgress == 0)  {
                    cell.circularProgressView.isHidden = true
                }
                else {
                    cell.circularProgressView.isHidden = false
                    
                    var dateComponents = DateComponents()
                    dateComponents.year = choosenYear
                    dateComponents.month = choosenMonth
                    dateComponents.day = calcDate
                    dateComponents.timeZone = TimeZone(abbreviation: "GMT") // Japan Standard Time
                    dateComponents.hour = 0
                    dateComponents.minute = 0

                    var date: Date = Calendar.current.date(from: dateComponents) ?? Date()
                    
                    var temp: [Routines] = filterRoutine(date: date, routines: allRoutines)
                    
                    calculateProgress = calculatePercentage(routines: temp)
                }
                
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
            // Set your item size here
            widthCell =  CGSize(width: (collectionView.frame.width) / 7 , height: collectionView.frame.width / 7 + 12) // Set your item size here
        }else{
            widthCell =  CGSize(width: 100, height:100)
        }
        
        return widthCell
    }
}

// MARK: MonthView
extension SummaryCalendarTableViewCell{
    
    @IBAction func buttonLeftOrRightPressed(_ sender: UIButton) {
        if sender == buttonRight {
            currentMonthIndex += 1
            if currentMonthIndex > 11 {
                currentMonthIndex = 0
                currentYear += 1
            }
        } else {
            currentMonthIndex -= 1
            if currentMonthIndex < 0 {
                currentMonthIndex = 11
                currentYear -= 1
            }
        }
        labelBulan.text="\(monthsArr[currentMonthIndex]) \(currentYear)"
        choosenMonth = currentMonthIndex
        choosenYear = currentYear
        
        didChangeMonth()
    }
}

// MARK: WeeklyView
extension SummaryCalendarTableViewCell{
    func setupViewWeekly() {
        for i in 0..<7 {
            let lbl = UILabel()
            lbl.text = daysArr[i].uppercased()
            lbl.textAlignment = .center
            lbl.textColor = UIColor.systemGray2
            lbl.font = UIFont.boldSystemFont(ofSize: 14)
            horizontalStackView.addArrangedSubview(lbl)
        }
        
        horizontalStackView.distribution = .fillEqually
    }
}

// MARK: DayView
extension SummaryCalendarTableViewCell{
    func setupViewDay(){
        currentMonthIndex = Calendar.current.component(.month, from: Date()) - 1
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
        let day = ("\(currentYear)-\(currentMonthIndex + 1)-01".date?.firstDayOfTheMonth.weekday)!
//        return day == 7 ? 1 : day
        return day
    }
    
    func didChangeMonth() {
        
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
