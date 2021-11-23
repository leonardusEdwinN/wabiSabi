//
//  AddProductViewController.swift
//  WabiSabiTeamProject
//
//  Created by Edwin Niwarlangga on 15/11/21.
//

import Foundation
import UIKit

class AddProductViewController : UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    // MARK: variable
    private var imagePickerControler =  UIImagePickerController()
    var imagePicker = UIImagePickerController()
    
    // MARK: Navigation Bar
    @IBOutlet weak var labelTitlePage: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
            self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Photo
    @IBOutlet weak var viewAddPhoto: UIView!
    @IBOutlet weak var imageViewProduct: UIImageView!
    
    // MARK: FORM
    @IBOutlet weak var textfieldProductName: UITextField!
    @IBOutlet weak var labelProductName: UILabel!
    
    @IBOutlet weak var labelProductBrand: UILabel!
    @IBOutlet weak var textfieldProductBrand: UITextField!
    
    @IBOutlet weak var labelProductType: UILabel!
    @IBOutlet weak var viewProductType: UIView!
    
    @IBOutlet weak var labelDateInformation: UILabel!
    @IBOutlet weak var stackViewDateInformation: UIStackView!
    
    @IBOutlet weak var viewOpenDate: UIView!
    @IBOutlet weak var labelOpenDate: UILabel!
    @IBOutlet weak var textFieldOpenDate : UITextField!
    
    @IBOutlet weak var viewExpiredDate: UIView!
    @IBOutlet weak var labelExpiredDate: UILabel!
    @IBOutlet weak var textFieldExpiredDate: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewAddPhoto.layer.cornerRadius = viewAddPhoto.frame.size.width / 2
        imageViewProduct.layer.cornerRadius = imageViewProduct.frame.size.width / 2
        viewProductType.layer.cornerRadius = 15
        stackViewDateInformation.layer.cornerRadius = 15
        viewOpenDate.roundCorners(corners: [.topLeft, .topRight], radius: 15.0)
        viewExpiredDate.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 15.0)
        
//        imageViewProduct.frame = CGRect(x: viewAddPhoto.frame.size.width / 2 - 25 , y: viewAddPhoto.frame.size.height / 2 - 25, width: 25, height: 25)
        
        self.hideKeyboardWhenTappedAround()
        
        // 1. create a gesture recognizer (tap gesture)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addProductType(_:)))
        
        // 2. add the gesture recognizer to a view
        viewProductType.addGestureRecognizer(tapGesture)
        
        let addPhotoTapGesture = UITapGestureRecognizer(target: self, action: #selector(addPhotoFromGallery(_:)))
        viewAddPhoto.addGestureRecognizer(addPhotoTapGesture)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(QuestionNameViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func addProductType(_ sender: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "moveToProductTypeSelection", sender: self)
    }
    
    @objc func addPhotoFromGallery(_ sender: UITapGestureRecognizer) {
        
//        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
//            print("Button capture")
//
//            imagePicker.delegate = self
//            imagePicker.sourceType = .savedPhotosAlbum
//            imagePicker.allowsEditing = false
//
//            present(imagePicker, animated: true, completion: nil)
//        }else  if UIImagePickerController.isSourceTypeAvailable(.camera){
//            self.imagePickerControler.sourceType = .camera
//            self.imagePickerControler.delegate = self
//            self.imagePickerControler.allowsEditing = true
//            self.present(self.imagePickerControler, animated: true, completion: nil)
////                self.usingCamera = true
//        }
        PresentActionSheet()

    }
    
    //presentation Action sheet
    private func PresentActionSheet(){
        
        let actionSheet = UIAlertController(title: "Select Photo", message: "Choose", preferredStyle: .actionSheet)
        actionSheet.view.tintColor = UIColor(named: "ActionSheetCustomColor")
        
        //button photo library
        let libraryAction = UIAlertAction(title: "Photo Library", style: .default){ (action: UIAlertAction) in
            
            
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                self.imagePickerControler.sourceType = .photoLibrary
                self.imagePickerControler.delegate = self
                self.imagePickerControler.allowsEditing = false
                
                self.present(self.imagePickerControler, animated: true, completion: nil)
//                self.usingCamera = false
            }else{
                fatalError("Photo library not avaliable")
            }
        }
        
        //button camera
        let CameraAction = UIAlertAction(title: "Camera", style: .default){ (action: UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                self.imagePickerControler.sourceType = .camera
                self.imagePickerControler.delegate = self
                self.imagePickerControler.allowsEditing = true
                self.present(self.imagePickerControler, animated: true, completion: nil)
//                self.usingCamera = true
            }
            else{
                fatalError("Camera not Avaliable")
            }
            
        }
        
        //button cancel
        let cancel = UIAlertAction(title: "Cancel", style:.cancel, handler: nil)
        
        actionSheet.addAction(libraryAction)
        actionSheet.addAction(CameraAction)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }

//        if let image = info[.cropRect] as? UIImage {
        viewAddPhoto.backgroundColor = UIColor.clear
            imageViewProduct.image = selectedImage
//        }
    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//
//            // The info dictionary may contain multiple representations of the image. You want to use the original.
//            guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
//                fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
//            }
//
//            // Set photoImageView to display the selected image.
//            photoImageView.image = selectedImage
//
//            // Dismiss the picker.
//            dismiss(animated: true, completion: nil)
//        }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        <#code#>
//    }
    
    
}


extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
