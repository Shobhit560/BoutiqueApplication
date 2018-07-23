//
//  RegistrationVC.swift
//  Boutique
//
//  Created by Shobhit Saxena on 04/07/18.
//  Copyright © 2018 Shobhit Saxena. All rights reserved.
//

import UIKit
import Alamofire



class RegistrationVC: UIViewController,UIPopoverPresentationControllerDelegate,ClassPopUpVCDelegate,UITextFieldDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtCompany: UITextField!
    @IBOutlet var txtMobile: UITextField!
    @IBOutlet var txtDeignation: UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtCLocation: UITextField!
    @IBOutlet weak var txtIndustry: UITextField!
    @IBOutlet weak var txtFind: UITextField!
    @IBOutlet weak var txtBudget: UITextField!
    @IBOutlet weak var txtWish: UITextField!
    @IBOutlet weak var txtInterestedLocation: UITextField!
    
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
    
    @IBOutlet var imgArrow1: UIImageView!
    @IBOutlet var imgArrow2: UIImageView!
    @IBOutlet var imgArrow3: UIImageView!
    @IBOutlet weak var imgArrow4: UIImageView!
    
    @IBOutlet var btnSubscribe: UIButton!
    
    @IBOutlet weak var viewFirst: UIView!
    @IBOutlet weak var viewSecond: UIView!
    
    var boolSubscribe = false
    
    var dictBroucherList = NSDictionary()
    var wishArray = NSArray()
    var findArray = NSArray()
    var locationArray = NSArray()
    var budgetArray = NSArray()
    var userImage = UIImage()
    var userImageName = ""
    var age = ""
    var propertyType = ""
    var annualIncome = ""
    var wishStr = ""
    var findStr = ""
    var locStr = ""
    var budgetStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchDetailWebService()
        
    }

    override func viewDidAppear(_ animated: Bool) {
//        txtName.text = "Shobhit"
//        txtMobile.text = "9540867766"
//        txtEmail.text = "shobhitsaxena001@gmail.com"
//        findStr = "Shobhit Saxena"
        
        
        
        viewFirst.addDashedBorder()
        viewSecond.addDashedBorder()
    }
    func fetchDetailWebService(){
        if AppHelper.isConnectedToNetwork() {
            DispatchQueue.main.async {
                AppHelper.showActivityUsingMBProgressHUD(uiView: self.view, message: "Please Wait \n Loading some data")
            }
            ServicesClass.sharedInstance.makeGetRequest(path: ServiceUrls.baseURL.description+kHomeBuyer) { (type: ServicesClass.ResponseType, response: AnyObject?) in
                if response != nil
                {
                    DispatchQueue.main.async {
                        AppHelper.hideActivityIndicator_MBProgressHUD(view: self.view)
                    }
                    
                    self.wishArray = ((response as! NSDictionary).object(forKey: "wishTo") != nil) ? ((response as! NSDictionary).value(forKey: "wishTo")! as! NSArray) : []
                    
                    self.findArray = ((response as! NSDictionary).object(forKey: "howDid") != nil) ? ((response as! NSDictionary).value(forKey: "howDid")! as! NSArray) : []
                    
                    self.locationArray = ((response as! NSDictionary).object(forKey: "locations") != nil) ? ((response as! NSDictionary).value(forKey: "locations")! as! NSArray) : []
                    
                    self.budgetArray = ["2 L - 20 L",
                        "20 L - 40 L",
                        "40 L - 50 L",
                        "50 L - 1 Cr",
                        "1 Cr - 5 Cr",
                        "5 Cr - 10 Cr",
                        "10 Cr+"]
                }
                else {
                    DispatchQueue.main.async {
                        AppHelper.hideActivityIndicator_MBProgressHUD(view: self.view)
                    }
                    self.showErrorAlert(message: AlertMessages.alertForNoDataFound.description)
                }
            }
        }
        else
        {
            DispatchQueue.main.async {
                self.showAlertViewOkButton(message: AlertMessages.alertForNetwork.description)
            }
        }
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
            msg = msg + "\n" + "Wish to join us on Home Buying Tour"
            boolDataAvailable = false
        }
        return (msg,boolDataAvailable)
    }
    
    func pushDetailWebService(){
//        let viewVC = ControllerFetcher().broucherVC
//        viewVC.userName = "Shobhit Saxena"
//        self.navigationController?.pushViewController(viewVC, animated: true)
        
        
        let (missingField, isValidated) = validateForm()
        if isValidated {
            println_debug("Post data")
            if AppHelper.isConnectedToNetwork() {
                DispatchQueue.main.async {
                    AppHelper.showActivityUsingMBProgressHUD(uiView: self.view, message: "Updating Record...")
                }

                var pName = ""
                var pMobile = ""
                var pEmail = ""
                var pIndustry = ""
                var pCompany = ""
                var pLocation = ""

                if (txtName.text?.count)! > 0{
                    pName = txtName.text!
                }
                if (txtMobile.text?.count)! > 0{
                    pMobile = txtMobile.text!
                }
                if (txtEmail.text?.count)! > 0{
                    pEmail = txtEmail.text!
                }
                if (txtIndustry.text?.count)! > 0{
                    pIndustry = txtIndustry.text!
                }
                if (txtCompany.text?.count)! > 0{
                    pCompany = txtCompany.text!
                }
                if (txtCLocation.text?.count)! > 0{
                    pLocation = txtCLocation.text!
                }


                let params = "name=\(pName)&mobile=\(pMobile)&email=\(pEmail)&age=\(age)&occupation_industry=\(pIndustry)& annual_income=\(annualIncome)&company_name=\(pCompany)&current_location=\(pLocation)&investment_end_use=test&how_find_us=\(findStr)&budget=\(budgetStr)&images=\((pName).trimmingCharacters(in: .whitespaces)).jpeg"
               ServicesClass.sharedInstance.makePostRequest(path: ServiceUrls.baseURL.description+kleadCapture , params: params ) { (type: ServicesClass.ResponseType, response: AnyObject?) in
                    if response != nil
                    {
                        DispatchQueue.main.async {
                            AppHelper.hideActivityIndicator_MBProgressHUD(view: self.view)
                        }
                        if ((response as! NSDictionary).value(forKey: "Status")) as! Int == 1{
                            self.dictBroucherList = (response as! NSDictionary)
                            DispatchQueue.main.async {
                                self.pushDetailWebServiceLeadGenerate()
                            }
                        }else{
                            self.showSuccessAlert(message: "Data Uploaded Succesfully")
                        }
                    }else{
                        DispatchQueue.main.async {
                            AppHelper.hideActivityIndicator_MBProgressHUD(view: self.view)
                        }
                        self.showErrorAlert(message: AlertMessages.alertForNoDataFound.description)
                    }
                }
            }
            else
            {
                DispatchQueue.main.async {
                    self.showAlertViewOkButton(message: AlertMessages.alertForNetwork.description)
                }
            }
        }else{
            self.showCustomAlertViewOkButton(titleName:"Please Enter Following Details", message: missingField)
        }
    }
    func pushDetailWebServiceLeadGenerate(){
        let (missingField, isValidated) = validateForm()
        if isValidated {
            println_debug("Post data")
            if AppHelper.isConnectedToNetwork() {
                DispatchQueue.main.async {
                    AppHelper.showActivityUsingMBProgressHUD(uiView: self.view, message: "Updating Leads...")
                }
                
                var pName = ""
                var pMobile = ""
                var pEmail = ""
                var pIndustry = ""
                var pCompany = ""
                var pLocation = ""
                
                
                if (txtName.text?.count)! > 0{
                    pName = txtName.text!
                }
                if (txtMobile.text?.count)! > 0{
                    pMobile = txtMobile.text!
                }
                if (txtEmail.text?.count)! > 0{
                    pEmail = txtEmail.text!
                }
                if (txtIndustry.text?.count)! > 0{
                    pIndustry = txtIndustry.text!
                }
                if (txtCompany.text?.count)! > 0{
                    pCompany = txtCompany.text!
                }
                if (txtCLocation.text?.count)! > 0{
                    pLocation = txtCLocation.text!
                }
                let params = "client_id=465&webformId=1236&webform_type=self&name=\(pName)&mobile=\(pMobile)&email=\(pEmail)&age=\(age)&occupation_industry=\(pIndustry)& annual_income=\(annualIncome)&company_name=\(pCompany)&current_location=\(pLocation)&investment_end_use=test&how_find_us=\(findStr)&budget=\(budgetStr)&images=\((pName).trimmingCharacters(in: .whitespaces)).jpeg"
                ServicesClass.sharedInstance.makePostRequest(path: crmIntegration , params: params ) { (type: ServicesClass.ResponseType, response: AnyObject?) in
                    if response == nil
                    {
                        DispatchQueue.main.async {
                            AppHelper.hideActivityIndicator_MBProgressHUD(view: self.view)
                        }
                        if self.userImage.imageAsset != nil{
                            self.methodToUploadImageOnServer()
                        }else{
                            self.showSuccessAlert(message: "Data Uploaded Succesfully")
                        }
                    }else{
                        DispatchQueue.main.async {
                            AppHelper.hideActivityIndicator_MBProgressHUD(view: self.view)
                        }
                        self.showErrorAlert(message: AlertMessages.alertForNoDataFound.description)
                    }
                }
            }
            else
            {
                DispatchQueue.main.async {
                    self.showAlertViewOkButton(message: AlertMessages.alertForNetwork.description)
                }
            }
        }else{
            self.showCustomAlertViewOkButton(titleName:"Some Error Occured", message: missingField)
        }
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
    func showSuccessAlert(message: String){
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: Constants.app_name.rawValue, message: message, preferredStyle: .alert)
            let OkAction = UIAlertAction(title: ButtonTitle.ok.description, style: .default) { (action:
                UIAlertAction) in
                DispatchQueue.main.async {
                    let viewVC = ControllerFetcher().broucherVC
                    viewVC.userName = self.txtName.text!
                    viewVC.dict = self.dictBroucherList
                    self.navigationController?.pushViewController(viewVC, animated: true)
                }
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
        self.pushDetailWebService()
    }
   
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txtEmail{
            if !(isValidEmail(testStr: textField.text!)){
                txtEmail.text = ""
                self.showErrorAlert(message: "Please enter valid E-mail")
            }
        }
        if textField == txtMobile{
            if !(isValidPhone(value: textField.text!)){
                txtMobile.text = ""
                self.showErrorAlert(message: "Please enter valid Mobile Number")
            }
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtMobile{
            guard let text = textField.text else { return true }
            let newLength = text.characters.count + string.characters.count - range.length
            return newLength <= 10
        }
        return true
    }
     func isValidEmail(testStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z_%+-]+@[A-Za-z0-9-]+\\.[A-Za-z]{2,4}"
        let whiteSpace = " "
        if let hasWhiteSpace = testStr.range(of: whiteSpace) {
            println_debug ("has whitespace==\(hasWhiteSpace)")
            return false
        } else {
            println_debug("no whitespace")
            let range = testStr.range(of: emailRegEx, options: .regularExpression, range: nil, locale: nil)
            let result = range != nil ? true : false
            return result
        }
        
        // let range = testStr.rangeOfString(emailRegEx, options:.RegularExpressionSearch)
    }
    func isValidPhone(value: String) -> Bool
    {
        let charcter  = NSCharacterSet(charactersIn: "0123456789").inverted
        var filtered:String!
        let inputString:NSArray = value.components(separatedBy: charcter) as NSArray
        filtered = inputString.componentsJoined(by: "")
        return  value == filtered
    }
//    func isValidPhone(value: String) -> Bool {
//        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
//        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
//        let result =  phoneTest.evaluate(with: value)
//        return result
//    }
    @IBAction func btnWish(_ sender: UIButton) {
        if wishArray.count == 0 || findArray.count == 0 || locationArray.count == 0{
            self.fetchDetailWebService()
        }else{
            var arrPopUp = NSArray()
            var comingPageID = 1
            switch sender.tag {
            case 1:
                arrPopUp = findArray
                comingPageID = 1
                imgArrow1.image = #imageLiteral(resourceName: "arrow-up")
            case 2:
                arrPopUp = budgetArray
                comingPageID = 2
                imgArrow2.image = #imageLiteral(resourceName: "arrow-up")
            case 3:
                arrPopUp = wishArray
                comingPageID = 3
                imgArrow3.image = #imageLiteral(resourceName: "arrow-up")
            case 4:
                arrPopUp = locationArray
                comingPageID = 4
                imgArrow4.image = #imageLiteral(resourceName: "arrow-up")
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
                popOverController.view.backgroundColor = UIColor.black.withAlphaComponent(0.1)
                popOverController.popoverPresentationController?.permittedArrowDirections = .up
                popOverController.popoverPresentationController?.delegate = self
                popOverController.popoverPresentationController?.sourceView = sender as UIView
                popOverController.popoverPresentationController?.sourceRect = CGRect(x:sender.bounds.midX, y:sender.bounds.midY+30 , width:0.0, height: 0.0)
                self.present(popOverController, animated: true, completion: nil)
            }
        }
    }
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
    @IBAction func btnSubscribe(_ sender: UIButton) {
        if boolSubscribe == false{
            boolSubscribe = true
            btnSubscribe.setImage(#imageLiteral(resourceName: "checkbox_red"), for: .normal)
        }else{
            boolSubscribe = false
            btnSubscribe.setImage(#imageLiteral(resourceName: "checkbox_empty"), for: .normal)
        }
    }
    
    func btnDoneClicked(str: String, index: Int){
        imgArrow1.image = #imageLiteral(resourceName: "sort-down")
        imgArrow2.image = #imageLiteral(resourceName: "sort-down")
        imgArrow3.image = #imageLiteral(resourceName: "sort-down")
        imgArrow4.image = #imageLiteral(resourceName: "sort-down")
        
        switch index {
        case 1:
            findStr = str
            txtFind.text = str
        case 2:
            budgetStr = str
            txtBudget.text = str
        case 3:
            wishStr = str
            txtWish.text = str
        case 4:
            locStr = str
            txtInterestedLocation.text = str
        default:
            println_debug("Nothing to print here")
        }
    }

    
//    func methodToUploadImageOnServer(img : UIImage){
//        let imgData = UIImageJPEGRepresentation(img, 0.2)!
//        let parameters = ["images": "imageHere.jpeg"] //Optional for extra parameter
//        DispatchQueue.main.async {
//            AppHelper.showActivityUsingMBProgressHUD(uiView: self.view, message: "Uploading Image...")
//        }
//        Alamofire.upload(multipartFormData: { multipartFormData in
//            multipartFormData.append(imgData, withName: "images",fileName: "Mohit.jpeg", mimeType: "image/jpeg")
//            for (key, value) in parameters {
//                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
//            } //Optional for extra parameters
//        },
//           to:ServiceUrls.baseURL.description+kUpload)
//        { (result) in
//            switch result {
//            case .success(let upload, _, _):
//                upload.uploadProgress(closure: { (progress) in
//                    print("Upload Progress: \(progress.fractionCompleted)")
//                    if progress.fractionCompleted == 1.0{
//                        DispatchQueue.main.async {
//                            AppHelper.hideActivityIndicator_MBProgressHUD(view: self.view)
//                        }
//                        self.showSuccessAlert(message: "Data Uploaded Succesfully")
//                    }
//                })
//                upload.responseJSON { response in
//                    println_debug("response")
//                }
//            case .failure(let encodingError):
//                print(encodingError)
//                DispatchQueue.main.async {
//                    AppHelper.hideActivityIndicator_MBProgressHUD(view: self.view)
//                }
//                self.showErrorAlert(message: "Data Uploaded Succesfully")
//            }
//        }
//    }
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
            print("Not Selected")
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
            print("Not Selected")
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
            print("Not Selected")
        }
    }
    func methodToUploadImageOnServer(){
        
        guard let data = UIImageJPEGRepresentation(userImage, 0.9) else {
            return
        }
        DispatchQueue.main.async {
            AppHelper.showActivityUsingMBProgressHUD(uiView: self.view, message: "Uploading Selfie")
        }
        Alamofire.upload(multipartFormData: { (form) in
            form.append(data, withName: "leadcapture", fileName: self.userImageName, mimeType: "image/jpg")
        }, to: "https://www.mypropertyboutique.com/assets/uploads/leadcapture/", encodingCompletion: { result in
            switch result {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                    if progress.fractionCompleted == 1.0{
                        DispatchQueue.main.async {
                            AppHelper.hideActivityIndicator_MBProgressHUD(view: self.view)
                        }
                        self.showSuccessAlert(message: "Data Uploaded Succesfully")
                    }
                })

                upload.responseString { response in
//                    DispatchQueue.main.async {
//                        AppHelper.hideActivityIndicator_MBProgressHUD(view: self.view)
//                    }
//                    self.showSuccessAlert(message: "Data Uploaded Succesfully")
                }
            case .failure(let encodingError):
                DispatchQueue.main.async {
                    AppHelper.hideActivityIndicator_MBProgressHUD(view: self.view)
                }
                self.showSuccessAlert(message: "Data Uploaded Succesfully")
                print(encodingError)
            }
        })
        
        
        
//        let imgData = UIImageJPEGRepresentation(userImage, 0.2)!
////        let imgData = UIImageJPEGRepresentation(#imageLiteral(resourceName: "camera"), 0.5)!
//        let parameters = ["name": self.userImageName] //Optional for extra parameter
//        DispatchQueue.main.async {
//            AppHelper.showActivityUsingMBProgressHUD(uiView: self.view, message: "Uploading Image...")
//        }
//        Alamofire.upload(multipartFormData: { multipartFormData in
//            multipartFormData.append(imgData, withName: "fileExit",fileName: "file.jpeg", mimeType: "image/jpeg")
//            for (key, value) in parameters {
//                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
//            } //Optional for extra parameters
//        },
//                         to:ServiceUrls.baseURL.description+kUpload)
//        { (result) in
//            switch result {
//            case .success(let upload, _, _):
//                upload.uploadProgress(closure: { (progress) in
//                    print("Upload Progress: \(progress.fractionCompleted)")
//                    if progress.fractionCompleted == 1.0{
//                        DispatchQueue.main.async {
//                            AppHelper.hideActivityIndicator_MBProgressHUD(view: self.view)
//                        }
//                        self.showSuccessAlert(message: "Data Uploaded Succesfully")
//                    }
//                })
//                upload.responseJSON { response in
//                    println_debug("response")
//                    DispatchQueue.main.async {
//                        AppHelper.hideActivityIndicator_MBProgressHUD(view: self.view)
//                    }
//                    self.showSuccessAlert(message: "Data Uploaded Succesfully")
//                    //                    print(response.result.value!)
//                }
//            case .failure(let encodingError):
//                print(encodingError)
//                DispatchQueue.main.async {
//                    AppHelper.hideActivityIndicator_MBProgressHUD(view: self.view)
//                }
//                self.showErrorAlert(message: "Data Uploaded Succesfully")
//            }
//        }
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
