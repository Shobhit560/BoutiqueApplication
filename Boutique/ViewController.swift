//
//  ViewController.swift
//  Boutique
//
//  Created by Shobhit Saxena on 04/07/18.
//  Copyright © 2018 Shobhit Saxena. All rights reserved.
//

import UIKit

var dictDataFlow = NSMutableDictionary()
var dictApplicationArray = NSMutableDictionary()
var selectedExpoID = 0

@available(iOS 10.0, *)
@available(iOS 10.0, *)
class ViewController: UIViewController,ClassPopUpVCDelegate,UIPopoverPresentationControllerDelegate {
    
    @IBOutlet var imgArrow1: UIImageView!
    @IBOutlet var imgArrow2: UIImageView!
    @IBOutlet var lblExpo: UILabel!
    @IBOutlet var lblExecutive: UILabel!
    
    var isImageCaptured = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchDetailWebService()
    }

    override func viewWillAppear(_ animated: Bool) {
        if dictDataFlow.count == 0{
            lblExpo.text = "Select Expo Center"
            lblExecutive.text = "Executive Name"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func validateForm() -> (String,Bool){
        var msg = ""
        var boolDataAvailable = true
        if (dictDataFlow.value(forKey: "key_Expo") == nil){
            msg =  msg + "\n" + "Expo Center"
            boolDataAvailable = false
        }
        if (dictDataFlow.value(forKey: "key_Executive") == nil){
            msg = msg + "\n" + "Executive Name"
            boolDataAvailable = false
        }
        return (msg,boolDataAvailable)
    }
    @IBAction func btnRegistration(_ sender: UIButton) {
        let (missingField, isValidated) = validateForm()
        if isValidated { DispatchQueue.main.async {
//            let viewVC = ControllerFetcher().cameraVC
            let viewVC = ControllerFetcher().registrationVC
            self.navigationController?.pushViewController(viewVC, animated: true)
            }
        }else{
            self.showCustomAlertViewOkButton(titleName:"Please add the following details", message: missingField)
        }
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
                    
                    if let arr = (((response as! NSDictionary).object(forKey: "wishTo") != nil) ? ((response as! NSDictionary).value(forKey: "wishTo")! as? NSArray) : [])
                    {
                        dictApplicationArray.setValue(arr, forKey: "arrWish")

                    }
                    if let arr = (((response as! NSDictionary).object(forKey: "howDid") != nil) ? ((response as! NSDictionary).value(forKey: "howDid")! as? NSArray) : [])
                    {
                        dictApplicationArray.setValue(arr, forKey: "arrFind")
                        
                    }
                    if let arr = (((response as! NSDictionary).object(forKey: "locations") != nil) ? ((response as! NSDictionary).value(forKey: "locations")! as? NSArray) : [])
                    {
                        dictApplicationArray.setValue(arr, forKey: "arrLoc")
                        
                    }
                    if let arr = (((response as! NSDictionary).object(forKey: "ExecutiveName") != nil) ? ((response as! NSDictionary).value(forKey: "ExecutiveName")! as? NSArray) : [])
                    {
                        dictApplicationArray.setValue(arr, forKey: "arrExecutive")
                        
                    }
                    if let arr = (((response as! NSDictionary).object(forKey: "ExpoCenter") != nil) ? ((response as! NSDictionary).value(forKey: "ExpoCenter")! as? NSArray) : [])
                    {
                        dictApplicationArray.setValue(arr, forKey: "arrExpo")
                        
                    }
                    if let arr = (((response as! NSDictionary).object(forKey: "budget") != nil) ? ((response as! NSDictionary).value(forKey: "budget")! as? NSArray) : [])
                    {
                        dictApplicationArray.setValue(arr, forKey: "arrBudget")
                        
                    }
                    if let arr = (((response as! NSDictionary).object(forKey: "Industry") != nil) ? ((response as! NSDictionary).value(forKey: "Industry")! as? NSArray) : [])
                    {
                        dictApplicationArray.setValue(arr, forKey: "arrIndus")
                    }
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
    @IBAction func btnPop(_ sender: UIButton) {
        if (dictApplicationArray.count == 0) || (dictApplicationArray.value(forKey: "arrExpo") as! NSArray).count == 0 || (dictApplicationArray.value(forKey: "arrExecutive") as! NSArray).count == 0{
            self.fetchDetailWebService()
        }else{
            var arrPopUp = NSArray()
            var comingPageID = 1
            var str = ""
            switch sender.tag {
            case 1:
                arrPopUp = dictApplicationArray.value(forKey: "arrExpo") as! NSArray
                comingPageID = 1
                if (dictDataFlow.value(forKey: "key_Expo") != nil){
                    str = dictDataFlow.value(forKey: "key_Expo")  as! String
                }
                imgArrow1.image = #imageLiteral(resourceName: "white-Up")
            case 2:
                if dictDataFlow.value(forKey: "key_Expo") == nil{
                    return
                }
                arrPopUp = (dictApplicationArray.value(forKey: "arrExecutive") as! NSArray)[selectedExpoID] as! NSArray
                comingPageID = 2
                if (dictDataFlow.value(forKey: "key_Executive") != nil){
                    str = dictDataFlow.value(forKey: "key_Executive")  as! String
                }
                imgArrow2.image = #imageLiteral(resourceName: "white-Up")
            default:
                print("Nothing to do")
            }
            
            DispatchQueue.main.async {
                let popOverController = ControllerFetcher().popVC
                popOverController.modalPresentationStyle = UIModalPresentationStyle.popover
                popOverController.preferredContentSize = CGSize(width:(sender as UIView).frame.width, height: 300)
                popOverController.isModalInPopover = true
                popOverController.delegatePop = self
                popOverController.pageArray = arrPopUp
                popOverController.pageId = comingPageID
                popOverController.selectedItem = comingPageID == 1 ? str : (str.components(separatedBy: "$#$"))[0]  //str
                popOverController.view.backgroundColor = UIColor.black.withAlphaComponent(0.1)
                popOverController.popoverPresentationController?.permittedArrowDirections = .up
                popOverController.popoverPresentationController?.delegate = self
                popOverController.popoverPresentationController?.sourceView = sender as UIView
                popOverController.popoverPresentationController?.sourceRect = CGRect(x:sender.bounds.midX, y:sender.bounds.midY+30 , width:0.0, height: 0.0)
                self.present(popOverController, animated: true, completion: nil)
            }
        }
    }
    
    func btnDoneClicked(str: String, index: Int, selectedRow:Int){
        imgArrow1.image = #imageLiteral(resourceName: "white_Drop")
        imgArrow2.image = #imageLiteral(resourceName: "white_Drop")
        if index != 100{
            switch index {
            case 1:
                lblExpo.text = str
                dictDataFlow.removeObject(forKey: "key_Executive")
                lblExecutive.text = "Executive Name"
                selectedExpoID = selectedRow
                dictDataFlow.removeObject(forKey: "key_Expo")
                dictDataFlow.setValue(str, forKey: "key_Expo")
            case 2:
                lblExecutive.text = (str.components(separatedBy: "$#$"))[0]
                dictDataFlow.removeObject(forKey: "key_Executive")
                dictDataFlow.setValue(str, forKey: "key_Executive")
            default:
                println_debug("Nothing to print here")
            }
        }
    }
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}

