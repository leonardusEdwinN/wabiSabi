
import UIKit

protocol OverlayButtonProtocol {
    func buttonSavePressed(time : String)
}

class OverlayView: UIViewController {

    
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    var delegate : OverlayButtonProtocol?
    
    @IBOutlet weak var slideIdicator: UIView!
    @IBOutlet weak var timePickerAlarm: UIDatePicker!
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = DateFormatter.Style.short
        
        guard let time = self.timePickerAlarm else{
            fatalError("Fatal error: Unexpectedly found nil while implicitly unwrapping an Optional value ")
        }

        let strDate = timeFormatter.string(from: time.date)
            // do what you want to do with the string.
        
        delegate?.buttonSavePressed(time: "\(strDate)")
//        print("time : \(strDate)")
    }
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
        
//        slideIdicator.roundCorners(.allCorners, radius: 10)
//        self.timePickerAlarm.datePickerStyle = .wheels
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 300)
                }
            }
        }
    }
}

