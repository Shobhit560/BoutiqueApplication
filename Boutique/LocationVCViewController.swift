//
//  LocationVCViewController.swift
//  Boutique
//
//  Created by Shobhit Saxena on 01/08/18.
//  Copyright © 2018 Shobhit Saxena. All rights reserved.
//

import UIKit
import Alamofire

class LocationCell: UICollectionViewCell{
    @IBOutlet var imgCheckBox: UIImageView!
    @IBOutlet var lblData: UILabel!
}

class LocationVCViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var imgSort: UIImageView!
    var intLocation = ""
    var arr = NSArray()
    var boolSubscribe = true
    var selectedItemArray = NSMutableArray()
    
    @IBOutlet var btnSubs: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        arr = ((dictApplicationArray.value(forKey: "arrLoc") as? NSArray)!)[selectedExpoID] as! NSArray
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LocationCell
        cell.lblData.text = arr[indexPath.item] as? String
        if (selectedItemArray.count > 0) && (selectedItemArray.contains(arr[indexPath.item] as! String)){
            cell.imgCheckBox.image = #imageLiteral(resourceName: "checkbox_grey")
        }else{
            cell.imgCheckBox.image = #imageLiteral(resourceName: "checkbox_empty")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedItemArray.contains(arr[indexPath.item] as! String){
           selectedItemArray.remove(arr[indexPath.item] as! String)
        }else{
            selectedItemArray.add(arr[indexPath.item] as! String)
        }
        collectionView.reloadData()
    }
    @IBAction func btnSubscribe(_ sender: Any) {
        if boolSubscribe == false{
            boolSubscribe = true
            btnSubs.setImage(#imageLiteral(resourceName: "checkbox_red"), for: .normal)
        }else{
            boolSubscribe = false
            btnSubs.setImage(#imageLiteral(resourceName: "checkbox_empty"), for: .normal)
        }
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnSubmit(_ sender: Any) {
        if selectedItemArray.count > 0{
            dictDataFlow.setValue(selectedItemArray.componentsJoined(by: "::"), forKey: "key_Location")
            pushDetailWebService()
        }else{
            self.showCustomAlertViewOkButton(titleName:"MyPropertyBoutique", message: "Please Select Your Interested Location")
        }
    }
    func pushDetailWebService(){
        println_debug("Post data")
        if AppHelper.isConnectedToNetwork() {
            DispatchQueue.main.async {
                AppHelper.showActivityUsingMBProgressHUD(uiView: self.view, message: "Updating Record...")
            }
            let pName = dictDataFlow.value(forKey: "key_Name") as! String
            let pMobile = dictDataFlow.value(forKey: "key_Mobile") as! String
            let pEmail = dictDataFlow.value(forKey: "key_Mail") as! String
            let pIndustry = dictDataFlow.value(forKey: "key_Industry") as! String
            let pCompany = dictDataFlow.value(forKey: "key_Company") as! String
            let age = dictDataFlow.value(forKey: "key_Age") as! String
            let annualIncome = dictDataFlow.value(forKey: "key_AnIncome") as! String
            let findStr = dictDataFlow.value(forKey: "key_Find") as! String
            let budgetStr = dictDataFlow.value(forKey: "key_Budget") as! String
            let pLocation = dictDataFlow.value(forKey: "key_Location") as! String
            let imgName = dictDataFlow.value(forKey: "key_ImageName") as! String
            let pExecutive = ((dictDataFlow.value(forKey: "key_Executive") as! String).components(separatedBy: "$#$"))[0]
            let pExpoCenter = dictDataFlow.value(forKey: "key_Expo") as! String
            
            let params = "name=\(pName)&mobile=\(pMobile)&email=\(pEmail)&age=\(age)&occupation_industry=\(pIndustry)&annual_income=\(annualIncome)&company_name=\(pCompany)&current_location=\(pLocation)&investment_end_use=test&how_find_us=\(findStr)&budget=\(budgetStr)&images=\(imgName)&executive=\(pExecutive)&expo_center=\(pExpoCenter)"
           ServicesClass.sharedInstance.makePostRequest(path: ServiceUrls.baseURL.description+kleadCapture , params: params ) { (type: ServicesClass.ResponseType, response: AnyObject?) in
                if response != nil
                {
                    DispatchQueue.main.async {
                        AppHelper.hideActivityIndicator_MBProgressHUD(view: self.view)
                    }
                    if ((response as! NSDictionary).value(forKey: "Status")) as! Int == 1{
                        DispatchQueue.main.async {
                            self.pushDetailWebServiceLeadGenerate()
                        }
                    }else{
                        self.showErrorAlert(message: "Some Error Occured")
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
    }
    func pushDetailWebServiceLeadGenerate(){
        if AppHelper.isConnectedToNetwork() {
            DispatchQueue.main.async {
                AppHelper.showActivityUsingMBProgressHUD(uiView: self.view, message: "Updating Leads...")
            }
            let pName = dictDataFlow.value(forKey: "key_Name") as! String
            let pMobile = dictDataFlow.value(forKey: "key_Mobile") as! String
            let pEmail = dictDataFlow.value(forKey: "key_Mail") as! String
            let pIndustry = dictDataFlow.value(forKey: "key_Industry") as! String
            let pCompany = dictDataFlow.value(forKey: "key_Company") as! String
            let age = dictDataFlow.value(forKey: "key_Age") as! String
            let annualIncome = dictDataFlow.value(forKey: "key_AnIncome") as! String
            let findStr = dictDataFlow.value(forKey: "key_Find") as! String
            let budgetStr = dictDataFlow.value(forKey: "key_Budget") as! String
            let pLocation = dictDataFlow.value(forKey: "key_Location") as! String
            let imgName = dictDataFlow.value(forKey: "key_ImageName") as! String
            let pExecutive = ((dictDataFlow.value(forKey: "key_Executive") as! String).components(separatedBy: "$#$"))[0]
            let pOwnerID = ((dictDataFlow.value(forKey: "key_Executive") as! String).components(separatedBy: "$#$"))[2]
            let pExpoCenter = dictDataFlow.value(forKey: "key_Expo") as! String
            
            let params = "client_id=465&webformId=1236&webform_type=self&name=\(pName)&mobile=\(pMobile)&email=\(pEmail)&age=\(age)&occupation_industry=\(pIndustry)&annual_income=\(annualIncome)&company_name=\(pCompany)&current_location=\(pLocation)&investment_end_use=test&how_find_us=\(findStr)&budget=\(budgetStr)&images=\(imgName)&executive=\(pExecutive)&expo_center=\(pExpoCenter)&owner_id=\(pOwnerID)"
            ServicesClass.sharedInstance.makePostRequest(path: crmIntegration , params: params ) { (type: ServicesClass.ResponseType, response: AnyObject?) in
                if response == nil
                {
                    DispatchQueue.main.async {
                        AppHelper.hideActivityIndicator_MBProgressHUD(view: self.view)
                    }
                    self.methodToUploadImageOnServer()
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
    }
    func refreshDocumentDirectory() {
        let fileManager = FileManager.default
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        do {
            let filePaths = try fileManager.contentsOfDirectory(atPath: paths)
            for _ in filePaths {
                try fileManager.removeItem(atPath: paths)
            }
        } catch {
            print("Could not clear temp folder: \(error)")
        }
    }
    func methodToUploadImageOnServer(){
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let getImagePath = NSString.path(withComponents: [paths, (dictDataFlow.value(forKey: "key_ImageName") as! String)])
        let image = UIImage.init(contentsOfFile: getImagePath)
        let data = UIImagePNGRepresentation((image?.compressImage())!)!
        
        DispatchQueue.main.async {
            AppHelper.showActivityUsingMBProgressHUD(uiView: self.view, message: "Uploading Selfie")
        }
        let apiHeaders = [
            "Content-Type": "multipart/form-data",
            "Accept" : "application/json"
        ]
        
        Alamofire.upload(multipartFormData:{ multipartFormData in
            multipartFormData.append(data, withName: "LeadImg", fileName: (dictDataFlow.value(forKey: "key_ImageName") as! String), mimeType: "image/*")},
                         usingThreshold:UInt64.init(),
                         to:"https://www.mypropertyboutique.com/mpbapi/lead-image",
                         method:.post,
                         headers:apiHeaders,
                         encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                upload.responseJSON { response in
                                    debugPrint(response)
                                    DispatchQueue.main.async {
                                        AppHelper.hideActivityIndicator_MBProgressHUD(view: self.view)
                                    }
                                    self.showSuccessAlert(message: "Data Uploaded Succesfully")
                                }
                            case .failure(let encodingError):
                                print(encodingError)
                                DispatchQueue.main.async {
                                    AppHelper.hideActivityIndicator_MBProgressHUD(view: self.view)
                                }
                                self.showSuccessAlert(message: "Data Uploaded Succesfully")
                            }
        })
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
                dictDataFlow.removeAllObjects()
                self.refreshDocumentDirectory()
                let viewControllers: [UIViewController] = self.navigationController!.viewControllers
                for aViewController in viewControllers {
                    if #available(iOS 10.0, *) {
                        if aViewController is ViewController {
                            self.navigationController!.popToViewController(aViewController, animated: true)
                        }
                    } else {
                        // Fallback on earlier versions
                    }
                }
            }
            alertController.addAction(OkAction)
            self.present(alertController, animated: true, completion:nil)
        }
    }
}
extension UIImage {
    
    func compressImage() -> UIImage? {
        // Reducing file size to a 10th
        var actualHeight: CGFloat = self.size.height
        var actualWidth: CGFloat = self.size.width
        let maxHeight: CGFloat = 1136.0
        let maxWidth: CGFloat = 640.0
        var imgRatio: CGFloat = actualWidth/actualHeight
        let maxRatio: CGFloat = maxWidth/maxHeight
        var compressionQuality: CGFloat = 0.5
        
        if actualHeight > maxHeight || actualWidth > maxWidth {
            if imgRatio < maxRatio {
                //adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            } else if imgRatio > maxRatio {
                //adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            } else {
                actualHeight = maxHeight
                actualWidth = maxWidth
                compressionQuality = 1
            }
        }
        let rect = CGRect(x: 0.0, y: 0.0, width: actualWidth, height: actualHeight)
        UIGraphicsBeginImageContext(rect.size)
        self.draw(in: rect)
        guard let img = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        UIGraphicsEndImageContext()
        guard let imageData = UIImageJPEGRepresentation(img, compressionQuality) else {
            return nil
        }
        return UIImage(data: imageData)
    }
    
}
