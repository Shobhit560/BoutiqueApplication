//
//  RegistrationVC.swift
//  Boutique
//
//  Created by Shobhit Saxena on 04/07/18.
//  Copyright © 2018 Shobhit Saxena. All rights reserved.
//

import UIKit
import Alamofire



@available(iOS 10.0, *)
class RegistrationVC: UIViewController,UIPopoverPresentationControllerDelegate,ClassPopUpVCDelegate,UITextFieldDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtCompany: UITextField!
    @IBOutlet var txtMobile: UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet weak var txtIndustry: UITextField!
    @IBOutlet weak var txtFind: UITextField!
    @IBOutlet weak var txtBudget: UITextField!
    @IBOutlet weak var txtWish: UITextField!
    
    @IBOutlet var age_Img1: UIImageView!
    @IBOutlet var age_Img2: UIImageView!
    @IBOutlet var age_Img3: UIImageView!
    @IBOutlet var age_Img4: UIImageView!
    @IBOutlet var age_Img5: UIImageView!
    
    @IBOutlet var income_Img1: UIImageView!
    @IBOutlet var income_Img2: UIImageView!
    @IBOutlet var income_Img3: UIImageView!
    @IBOutlet var income_Img4: UIImageView!
    @IBOutlet var income_Img5: UIImageView!
    
    @IBOutlet var property_Img1: UIImageView!
    @IBOutlet var property_Img2: UIImageView!
    @IBOutlet var property_Img3: UIImageView!
    
    @IBOutlet var imgArrow0: UIImageView!
    @IBOutlet var imgArrow1: UIImageView!
    @IBOutlet var imgArrow2: UIImageView!
    @IBOutlet var imgArrow3: UIImageView!
    
    @IBOutlet weak var viewFirst: UIView!

    @IBOutlet var imgProfile: UIImageView!
    var boolSubscribe = false
    
    var age = ""
    var propertyType = ""
    var annualIncome = ""
    
    var wishStr = ""
    var indusStr = ""
    var findStr = ""
    var budgetStr = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        imgProfile.image = dictDataFlow.value(forKey: "key_Image") as? UIImage
        viewFirst.addDashedBorder()
//        dataTest()
    }
    

    func dataTest(){
        txtName.text = "Shobhit Saxena"
        txtCompany.text = "AdGlobal360"
        txtMobile.text = "9540867766"
        txtIndustry.text = "Information Technology"
        txtEmail.text = "shobhitsaxena001@gmail.com"
        findStr = "paper Advertisement"
        indusStr = ""
        wishStr = "Yes"
        budgetStr = "2 L - 20 L"
    }
    
    
    func validateForm() -> (String,Bool){
        var msg = ""
        var boolDataAvailable = true
        if txtName.text == ""{
            msg =  msg + "\n" + "Your Name"
            boolDataAvailable = false
        }
        if txtMobile.text! == "" || (txtMobile.text?.count)! < 10{
            msg = msg + "\n" + "Mobile Number"
            boolDataAvailable = false
        }
        if txtEmail.text == ""{
            msg = msg + "\n" + "Email-Id"
            boolDataAvailable = false
        }
        if findStr == ""{
            msg = msg + "\n" + "How did you find us"
            boolDataAvailable = false
        }
        return (msg,boolDataAvailable)
    }
    func showErrorAlert(message: String){
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: Constants.app_name.rawValue, message: message, preferredStyle: .alert)
            let OkAction = UIAlertAction(title: ButtonTitle.ok.description, style: .default) { (action:
                UIAlertAction) in
            }
            alertController.addAction(OkAction)
            self.present(alertController, animated: true, completion:nil)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnRegisterationNow(_ sender: Any) {
        let (missingField, isValidated) = validateForm()
        if isValidated {
            dictDataFlow.setValue(txtName.text, forKey: "key_Name")
            dictDataFlow.setValue(txtCompany.text, forKey: "key_Company")
            dictDataFlow.setValue(txtMobile.text, forKey: "key_Mobile")
            dictDataFlow.setValue(txtEmail.text, forKey: "key_Mail")
            dictDataFlow.setValue(txtFind.text, forKey: "key_Find")
            dictDataFlow.setValue(txtIndustry.text, forKey: "key_Industry")
            dictDataFlow.setValue(txtBudget.text, forKey: "key_Budget")
            dictDataFlow.setValue(txtWish.text, forKey: "key_Wish")
            dictDataFlow.setValue(age, forKey: "key_Age")
            dictDataFlow.setValue(annualIncome, forKey: "key_AnIncome")
            dictDataFlow.setValue(propertyType, forKey: "key_Property")
            
            DispatchQueue.main.async {
                let viewVC = ControllerFetcher().locationVC
                self.navigationController?.pushViewController(viewVC, animated: true)
            }
        }else{
            self.showCustomAlertViewOkButton(titleName:"Please add the following details", message: missingField)
        }
    }
   
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txtEmail{
            if !(AppHelper.isValidEmail(testStr: textField.text!)){
                txtEmail.text = ""
                self.showErrorAlert(message: "Please enter valid E-mail")
            }
        }
        if textField == txtMobile{
            if !(AppHelper.isValidPhone(value: textField.text!)) || ((textField.text?.count)! < 10) {
                txtMobile.text = ""
                self.showErrorAlert(message: "Please enter valid Mobile Number")
            }
        }
        if textField == txtCompany{
            txtCompany.text? = (textField.text?.capitalized)!
        }
        textField.resignFirstResponder()
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtMobile{
            let set = CharacterSet(charactersIn: "0123456789")
            if(txtMobile.text?.rangeOfCharacter(from: set.inverted) != nil ){
//                print("Character")
                txtMobile.text?.removeLast()
                return false
            }else{
//                print("Number")
                guard let text = textField.text else { return true }
                let newLength = text.count + string.count - range.length
                return newLength <= 10
            }
        }
        else if textField == txtName{
            let set = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ ")
            if(txtName.text?.rangeOfCharacter(from: set.inverted) != nil ){
//                print("Number")
                txtName.text?.removeLast()
                return false
            }else{
//                print("Character")
            }
        }
        return true
    }
   
    @IBAction func btnWish(_ sender: UIButton) {
        txtName.resignFirstResponder()
        txtCompany.resignFirstResponder()
        txtMobile.resignFirstResponder()
        txtEmail.resignFirstResponder()
        var arrPopUp = NSArray()
        var comingPageID = 1
        var str = ""
        switch sender.tag {
        case 0:
            arrPopUp = dictApplicationArray.value(forKey: "arrIndus") as! NSArray
            comingPageID = 0
            str = indusStr
            imgArrow0.image = #imageLiteral(resourceName: "arrow-up")
        case 1:
            arrPopUp = dictApplicationArray.value(forKey: "arrFind") as! NSArray
            comingPageID = 1
            str = findStr
            imgArrow1.image = #imageLiteral(resourceName: "arrow-up")
        case 2:
            arrPopUp = dictApplicationArray.value(forKey: "arrBudget") as! NSArray
            str = budgetStr
            comingPageID = 2
            imgArrow2.image = #imageLiteral(resourceName: "arrow-up")
        case 3:
            arrPopUp = dictApplicationArray.value(forKey: "arrWish") as! NSArray
            comingPageID = 3
            str = wishStr
            imgArrow3.image = #imageLiteral(resourceName: "arrow-up")
        default:
            print("Nothing to do")
        }
        
        DispatchQueue.main.async {
            let popOverController = ControllerFetcher().popVC
            popOverController.modalPresentationStyle = UIModalPresentationStyle.popover
            popOverController.preferredContentSize = CGSize(width:(sender as UIView).frame.width, height:(comingPageID == 3 ? 180 : 300))
            popOverController.isModalInPopover = true
            popOverController.delegatePop = self
            popOverController.pageArray = arrPopUp
            popOverController.pageId = comingPageID
            popOverController.selectedItem = str
            popOverController.view.backgroundColor = UIColor.black.withAlphaComponent(0.1)
            popOverController.popoverPresentationController?.permittedArrowDirections = comingPageID > 1 ? .down : .up
            popOverController.popoverPresentationController?.delegate = self
            popOverController.popoverPresentationController?.sourceView = sender as UIView
            popOverController.popoverPresentationController?.sourceRect = comingPageID > 1 ? CGRect(x:sender.bounds.midX, y:sender.bounds.midY-30 , width:0.0, height: 0.0) : CGRect(x:sender.bounds.midX, y:sender.bounds.midY+30 , width:0.0, height: 0.0)
            self.present(popOverController, animated: true, completion: nil)
        }
    }
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
    func btnDoneClicked(str: String, index: Int, selectedRow:Int){
        imgArrow0.image = #imageLiteral(resourceName: "sort-down")
        imgArrow1.image = #imageLiteral(resourceName: "sort-down")
        imgArrow2.image = #imageLiteral(resourceName: "sort-down")
        imgArrow3.image = #imageLiteral(resourceName: "sort-down")
        if index != 100{
            switch index {
            case 0:
                indusStr = str
                txtIndustry.text = str
            case 1:
                findStr = str
                txtFind.text = str
            case 2:
                budgetStr = str
                txtBudget.text = str
            case 3:
                wishStr = str
                txtWish.text = str
            default:
                println_debug("Nothing to print here")
            }
        }
    }
    
    @IBAction func btnAgeSelection(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            age = "20-25 Yrs"
            age_Img1.image = UIImage(named:"checkbox_empty")
            age_Img2.image = UIImage(named:"checkbox_grey")
            age_Img3.image = UIImage(named:"checkbox_empty")
            age_Img4.image = UIImage(named:"checkbox_empty")
            age_Img5.image = UIImage(named:"checkbox_empty")
        case 1:
            age = "25-35 Yrs"
            age_Img1.image = UIImage(named:"checkbox_grey")
            age_Img2.image = UIImage(named:"checkbox_empty")
            age_Img3.image = UIImage(named:"checkbox_empty")
            age_Img4.image = UIImage(named:"checkbox_empty")
            age_Img5.image = UIImage(named:"checkbox_empty")
        case 2:
            age = "35-45 Yrs"
            age_Img1.image = UIImage(named:"checkbox_empty")
            age_Img2.image = UIImage(named:"checkbox_empty")
            age_Img3.image = UIImage(named:"checkbox_grey")
            age_Img4.image = UIImage(named:"checkbox_empty")
            age_Img5.image = UIImage(named:"checkbox_empty")
        case 3:
            age = "45-60 Yrs"
            age_Img1.image = UIImage(named:"checkbox_empty")
            age_Img2.image = UIImage(named:"checkbox_empty")
            age_Img3.image = UIImage(named:"checkbox_empty")
            age_Img4.image = UIImage(named:"checkbox_grey")
            age_Img5.image = UIImage(named:"checkbox_empty")
        case 4:
            age = "60 Yrs"
            age_Img1.image = UIImage(named:"checkbox_empty")
            age_Img2.image = UIImage(named:"checkbox_empty")
            age_Img3.image = UIImage(named:"checkbox_empty")
            age_Img4.image = UIImage(named:"checkbox_empty")
            age_Img5.image = UIImage(named:"checkbox_grey")
        default:
            age = ""
//            print("Not Selected")
        }
    }
    
    @IBAction func btnAnnualIncome(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            annualIncome = "0-5 Lakhs"
            income_Img1.image = UIImage(named:"checkbox_grey")
            income_Img2.image = UIImage(named:"checkbox_empty")
            income_Img3.image = UIImage(named:"checkbox_empty")
            income_Img4.image = UIImage(named:"checkbox_empty")
            income_Img5.image = UIImage(named:"checkbox_empty")
        case 1:
            annualIncome = "5-10 Lakhs"
            income_Img1.image = UIImage(named:"checkbox_empty")
            income_Img2.image = UIImage(named:"checkbox_grey")
            income_Img3.image = UIImage(named:"checkbox_empty")
            income_Img4.image = UIImage(named:"checkbox_empty")
            income_Img5.image = UIImage(named:"checkbox_empty")
        case 2:
            annualIncome = "10-15 Lakhs"
            income_Img1.image = UIImage(named:"checkbox_empty")
            income_Img2.image = UIImage(named:"checkbox_empty")
            income_Img3.image = UIImage(named:"checkbox_grey")
            income_Img4.image = UIImage(named:"checkbox_empty")
            income_Img5.image = UIImage(named:"checkbox_empty")
        case 3:
            annualIncome = "15-25 Lakhs"
            income_Img1.image = UIImage(named:"checkbox_empty")
            income_Img2.image = UIImage(named:"checkbox_empty")
            income_Img3.image = UIImage(named:"checkbox_empty")
            income_Img4.image = UIImage(named:"checkbox_grey")
            income_Img5.image = UIImage(named:"checkbox_empty")
        case 4:
            annualIncome = "25 Lakhs"
            income_Img1.image = UIImage(named:"checkbox_empty")
            income_Img2.image = UIImage(named:"checkbox_empty")
            income_Img3.image = UIImage(named:"checkbox_empty")
            income_Img4.image = UIImage(named:"checkbox_empty")
            income_Img5.image = UIImage(named:"checkbox_grey")
        default:
            annualIncome = ""
//            print("Not Selected")
        }
    }
    
    @IBAction func btnPropertyType(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            propertyType = "Plots"
            property_Img1.image = UIImage(named:"checkbox_grey")
            property_Img2.image = UIImage(named:"checkbox_empty")
            property_Img3.image = UIImage(named:"checkbox_empty")
        case 1:
            propertyType = "Villas"
            property_Img1.image = UIImage(named:"checkbox_empty")
            property_Img2.image = UIImage(named:"checkbox_grey")
            property_Img3.image = UIImage(named:"checkbox_empty")
        case 2:
            propertyType = "Apartments"
            property_Img1.image = UIImage(named:"checkbox_empty")
            property_Img2.image = UIImage(named:"checkbox_empty")
            property_Img3.image = UIImage(named:"checkbox_grey")
        default:
            propertyType = ""
//            print("Not Selected")
        }
    }
    @IBAction func btnBack(_ sender: UIButton) {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        for aViewController in viewControllers {
                if aViewController is ViewController {
                    self.navigationController!.popToViewController(aViewController, animated: true)
                }
        }
    }
}
extension Date {
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}
