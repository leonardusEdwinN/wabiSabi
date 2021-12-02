//
//  AddProductViewController.swift
//  WabiSabiTeamProject
//
//  Created by Edwin Niwarlangga on 15/11/21.
//

import Foundation
import UIKit
protocol SaveProductDelegate{
//    func saveProductAndReloadIt(completion : () -> Void)
    func saveProductAndReloadIt()
}

protocol SaveNewProductRoutineDelegate{
    func saveNewProductRoutine(for product : ProductModel)
    func updateNewProductRoutine(for product : ProductModel)
}

class AddProductViewController : UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    // MARK: variable
    private var imagePickerControler =  UIImagePickerController()
    var imagePicker = UIImagePickerController()
    var selectedRoutine: Routines!
    var productTypeArray: [ProductTypeModel] = []
    var delegate: SaveProductDelegate?
    var delegateAddProduct: SaveNewProductRoutineDelegate?
    var selectedProduct: Product!
    var isEdit: Bool = false
    var imgStrBase64 : String = ""
    var isNotConnectToDB = false
    
    // MARK: Navigation Bar
    @IBOutlet weak var labelTitlePage: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    @IBAction func saveButtonPressed(_ sender: Any) {
//        DispatchQueue.main.async {
//            print("SHOW INDICATOR LAODING")
//            self.loadingIndicator.isHidden = false
//            self.loadingIndicator.startAnimating()
//
//        }
        
        DispatchQueue.main.async {
            Loading.sharedInstance.showIndicator()
        }
        
//        if let name = textfieldProductName.text,
//           let brand = textfieldProductBrand.text,
//           let productType = labelProductTypeValue.text,
//           let expiredDate = paoDatePicker,
//           let periodAfterOpen = expDatePicker,
//           let image = imageViewProduct.image{
            
        if let image = imageViewProduct.image{
            let imageData:Data = image.pngData()!
            imgStrBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        }
            
            
        
        
            
        if selectedProduct != nil && selectedProduct.id != ""{
                if let id = selectedProduct.id{
                    
                    if(isNotConnectToDB){
                        print("UPDATE")
                        var productId = "\(UUID())"
                        print("SELECTED PRODUCT UUID : \(productId)")
                        delegateAddProduct?.updateNewProductRoutine(for: ProductModel(image: imgStrBase64, name: textfieldProductName.text ?? "", brand: textfieldProductBrand.text ?? "", productType: labelProductTypeValue.text ?? "", openedDate: paoDatePicker.date, expired: expDatePicker.date, isDone: false, id: productId))
                    }else{
                        
                        //update data
                        PersistanceManager.shared.updateProduct(id: id, name: textfieldProductName.text ?? "", brand: textfieldProductBrand.text ?? "", periodAfterOpening: paoDatePicker.date , picture: imgStrBase64, routine: selectedRoutine, expiredDate: expDatePicker.date, productType: labelProductTypeValue.text ?? "")
                    }
                }
            }else{
                
                if isNotConnectToDB{
                    print("CREATE")
                    var productId = "\(UUID())"
                    print("SELECTED PRODUCT UUID : \(productId)")
                    delegateAddProduct?.saveNewProductRoutine(for: ProductModel(image: imgStrBase64, name: textfieldProductName.text ?? "", brand: textfieldProductBrand.text ?? "", productType: labelProductTypeValue.text ?? "", openedDate: paoDatePicker.date, expired: expDatePicker.date, isDone: false, id: productId))
                }else{
                    //create data
                    PersistanceManager.shared.setProduct(brand: textfieldProductBrand.text ?? "", expiredDate: expDatePicker.date, name: textfieldProductName.text ?? "", periodAfterOpening: paoDatePicker.date, picture: imgStrBase64, routine: selectedRoutine, productType: labelProductTypeValue.text ?? "", isDone: false)
                }
                
                
                
            }
            
            delegate?.saveProductAndReloadIt()
                
                
            
            
            
//        }else {
//            Util.displayAlert(title: "Please fill the data properly", message: "Something missing when you add product")
//        }
        
//        delegate?.saveProductAndReloadIt(completion: {
//            print("STOP ANIMATING AND MOVE")
//            self.loadingIndicator.stopAnimating()
//            self.loadingIndicator.isHidden = true
//            self.dismiss(animated: false, completion: nil)
//        })
        
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
    @IBOutlet weak var labelProductTypeValue: UILabel!
    
    @IBOutlet weak var labelDateInformation: UILabel!
    @IBOutlet weak var stackViewDateInformation: UIStackView!
    
    @IBOutlet weak var viewOpenDate: UIView!
    @IBOutlet weak var labelOpenDate: UILabel!
    @IBOutlet weak var paoDatePicker: UIDatePicker!
    
    @IBOutlet weak var viewExpiredDate: UIView!
    @IBOutlet weak var labelExpiredDate: UILabel!
    @IBOutlet weak var expDatePicker: UIDatePicker!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if self.isEdit{
            
            //true, melakukan update data
            if let product = selectedProduct{
                
                
                if let name = product.name{
                    textfieldProductName.text = name
                }
                if let brand = product.brand{
                    textfieldProductBrand.text = brand
                }
                if let image = product.picture{
                    guard let decodedData = Data(base64Encoded: image, options: .ignoreUnknownCharacters) else { return  }
                    let decodedimage: UIImage = UIImage(data: decodedData) ?? UIImage(systemName: "camera") as! UIImage
                    
                    imageViewProduct.contentMode = .scaleToFill
                    imageViewProduct.image = decodedimage
                }
                if let productType = product.productType{
                    labelProductTypeValue.text = productType
                }
                if  let pao = product.periodAfterOpening{
                    paoDatePicker.date = pao
                }
                if let exp = product.expiredDate{
                    expDatePicker.date = exp
                }
            }
            
            
            
        }else{
            textfieldProductName.text = ""
            textfieldProductBrand.text = ""
            labelProductTypeValue.text = ""
            imageViewProduct.image = UIImage(systemName: "camera")
        }
        
        
        
        
        setDataProductType()
        setUI()
        
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(QuestionNameViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setDataProductType(){
        // MARK: ProductType
        productTypeArray.append(ProductTypeModel(name: "Cleanser", isSelected: false))
        productTypeArray.append(ProductTypeModel(name: "Chemical Peel", isSelected: false))
        productTypeArray.append(ProductTypeModel(name: "Exfoliator", isSelected: false))
        productTypeArray.append(ProductTypeModel(name: "Eye Cream", isSelected: false))
        productTypeArray.append(ProductTypeModel(name: "Face Mask", isSelected: false))
        productTypeArray.append(ProductTypeModel(name: "Face Oil", isSelected: false))
        productTypeArray.append(ProductTypeModel(name: "Makeup Remover", isSelected: false))
        productTypeArray.append(ProductTypeModel(name: "Moizturizer", isSelected: false))
        productTypeArray.append(ProductTypeModel(name: "Serum", isSelected: false))
        productTypeArray.append(ProductTypeModel(name: "Sunscreen", isSelected: false))
        productTypeArray.append(ProductTypeModel(name: "Toner", isSelected: false))
        productTypeArray.append(ProductTypeModel(name: "Treatment", isSelected: false))
        productTypeArray.append(ProductTypeModel(name: "Other", isSelected: false))
    }
    
    func setUI(){
        // MARK: SET UI
        viewAddPhoto.layer.cornerRadius = viewAddPhoto.frame.size.width / 2
        imageViewProduct.layer.cornerRadius = imageViewProduct.frame.size.width / 2
        viewProductType.layer.cornerRadius = 15
        stackViewDateInformation.layer.cornerRadius = 15
        viewOpenDate.roundCorners(corners: [.topLeft, .topRight], radius: 15.0)
        viewExpiredDate.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 15.0)
        
        
        self.hideKeyboardWhenTappedAround()
        
        // 1. create a gesture recognizer (tap gesture)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addProductType(_:)))
        
        // 2. add the gesture recognizer to a view
        viewProductType.addGestureRecognizer(tapGesture)
        
        let addPhotoTapGesture = UITapGestureRecognizer(target: self, action: #selector(addPhotoFromGallery(_:)))
        viewAddPhoto.addGestureRecognizer(addPhotoTapGesture)
    }
    
    
    @objc func addProductType(_ sender: UITapGestureRecognizer) {
        self.dismissKeyboard()
        self.performSegue(withIdentifier: "moveToProductTypeSelection", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        guard let nav = segue.destination as? UINavigationController else {
            return
        }
        
        if let destVC = nav.topViewController as? ProductTypeViewController {
            destVC.delegate = self
            destVC.productTypeArray = self.productTypeArray
        }
    }
    
    @objc func addPhotoFromGallery(_ sender: UITapGestureRecognizer) {
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
            }
            else{
                Util.displayAlert(title: "Camera Not Available", message: "")
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
            imageViewProduct.contentMode = .scaleToFill
            imageViewProduct.image = selectedImage
//        }
    }
    
}


extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}


extension AddProductViewController : SelectProductTypeDelegate{
    func selectProductTypeCell(productType: String, indexPath : IndexPath) {
        print("PRODUCT TYPE : \(productType)")
        
        
        for (index, productType) in productTypeArray.enumerated(){
            productTypeArray[index].isSelected = false
        }
        
        labelProductTypeValue.text = productType
        self.productTypeArray[indexPath.row].isSelected = true
    }
}
