//
//  SummaryCalendarTableViewCell.swift
//  WabiSabiTeamProject
//
//  Created by Edwin Niwarlangga on 04/11/21.
//

import UIKit

protocol SummaryCollectionViewCellDelegate: class {
    func didTapAtCell(date : Date)
}

class SummaryCalendarTableViewCell: UITableViewCell {
    weak var cellDelegate: SummaryCollectionViewCellDelegate?
    
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
    
    var indexSelected: Int = 0
    
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
        var filteredItems: [Routines] = []
        for i in 0..<routines.count {
            /*
             var dayToBeCompared = Calendar.current.component(.day, from: routines[i].routineDate ?? Date())
             var monthToBeCompared = Calendar.current.component(.month, from: routines[i].routineDate ?? Date())
             var yearToBeCompared = Calendar.current.component(.year, from: routines[i].routineDate ?? Date())
             
             var dayFilter = Calendar.current.component(.day, from: date ?? Date())
             var monthFilter = Calendar.current.component(.month, from: date ?? Date())
             var yearFilter = Calendar.current.component(.year, from: date ?? Date())
             
             print(dayToBeCompared, "-", dayFilter)
             print(monthToBeCompared, "-", monthFilter)
             print(yearToBeCompared, "-", yearFilter)
             
             if (dayToBeCompared == dayFilter && monthToBeCompared == monthFilter && yearToBeCompared == yearFilter) {
                 
                 filteredItems.append(routines[i])
             }
            */
            
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd"
            let routineDate: String = df.string(from: routines[i].routineDate ?? Date())
            let filterDate: String = df.string(from: date)
            
            if (routineDate.elementsEqual(filterDate)) {
                print(routines[i].isCompleted, "on", routineDate)
                filteredItems.append(routines[i])
            }
        }
        return filteredItems
    }
    
    func calculatePercentage(routines: [Routines]) -> CGFloat{
        var completedRoutine: CGFloat = 0.0
        if !routines.isEmpty {
            for i in 0..<routines.count {
                if routines[i].isCompleted {
                    completedRoutine = completedRoutine + 1.0
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
        
        indexSelected = indexPath.row + 1
        for index in 0...numOfDaysInMonth[currentMonthIndex] + firstWeekDayOfMonth - 1 {
            if let cell = collectionView.viewWithTag(index) as? DayCollectionViewCell {
                cell.circularProgressView.fillColor = UIColor.clear.cgColor
                cell.circularProgressView.alpha = 1
                
                // check today
                var day = Calendar.current.component(.day, from: Date())
                var month = Calendar.current.component(.month, from: Date()) - 1 //soalnya arraynya di mulai dari 0
                var year = Calendar.current.component(.year, from: Date())
                
                var today = Int(cell.labelDate.text ?? "0")
                
                if (today == day && choosenMonth == month && choosenYear == year) {
                    cell.labelDate.textColor = UIColor.systemIndigo
                }
                else {
                    cell.labelDate.textColor = UIColor.black
                }
            }
        }
        
        if let cell = collectionView.viewWithTag(indexSelected) as? DayCollectionViewCell {
            cell.circularProgressView.fillColor = UIColor.systemIndigo.cgColor
            cell.circularProgressView.alpha = 0.6
            
            cell.labelDate.textColor = UIColor.white
            
            var day: Int? = Int(cell.labelDate.text ?? "0")
            
            var dateComponents = DateComponents()
            dateComponents.year = choosenYear
            dateComponents.month = choosenMonth + 1
            dateComponents.day = Int(day!)
            dateComponents.timeZone = TimeZone.current.localizedName(for: .shortStandard, locale: .current) as? TimeZone
            dateComponents.hour = 0
            dateComponents.minute = 0

            var date: Date = Calendar.current.date(from: dateComponents) ?? Date()
            
            cellDelegate?.didTapAtCell(date: date)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.calendarDayCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarDayCollectionViewCell", for: indexPath) as! DayCollectionViewCell
            cell.tag = (indexPath.row + 1)
            cell.circularProgressView.fillColor = UIColor.clear.cgColor
            cell.circularProgressView.alpha = 1
            
            if indexPath.item <= firstWeekDayOfMonth - 2 {
                cell.isHidden = true
            } else {
                //Progress Ciruclar
                var calculateProgress: CGFloat = 0.0
                
                //calculate Date
                let calcDate = indexPath.row-firstWeekDayOfMonth+2
                cell.isHidden = false
                
                // check today
                var day = Calendar.current.component(.day, from: Date())
                var month = Calendar.current.component(.month, from: Date()) - 1 //soalnya arraynya di mulai dari 0
                var year = Calendar.current.component(.year, from: Date())
                
                var dateComponents = DateComponents()
                dateComponents.year = choosenYear
                dateComponents.month = choosenMonth + 1
                dateComponents.day = calcDate
                dateComponents.timeZone = TimeZone.current.localizedName(for: .shortStandard, locale: .current) as? TimeZone
                dateComponents.hour = 0
                dateComponents.minute = 0

                var date: Date = Calendar.current.date(from: dateComponents) ?? Date()
                
                var temp: [Routines] = filterRoutine(date: date, routines: allRoutines)
                
                if !(temp.isEmpty) {
                    cell.circularProgressView.isHidden = false
                    calculateProgress = calculatePercentage(routines: temp)
                    cell.circularProgressView.progress = calculateProgress
                }
                
                if (calcDate == day && choosenMonth == month && choosenYear == year) {
                    cell.labelDate.textColor = UIColor.systemIndigo
                    if (calculateProgress == 0){
                        calculateProgress = 0.001
                        cell.circularProgressView.progress = calculateProgress
                    }
                }
                else if( (calcDate > day && choosenMonth == month && choosenYear == year) || (choosenMonth > month && choosenYear == year) || (choosenYear > year) || calculateProgress == 0)  {
                    cell.circularProgressView.progress = 0
                    calculateProgress = 0.0
                    cell.labelDate.textColor = UIColor.black
                }
                else {
                    cell.labelDate.textColor = UIColor.black
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
            widthCell =  CGSize(width: (collectionView.frame.width) / 7 , height: collectionView.frame.width / 7 + 5) // Set your item size here
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
