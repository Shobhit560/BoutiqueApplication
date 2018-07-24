//
//  BroucherVC.swift
//  Boutique
//
//  Created by Shobhit Saxena on 05/07/18.
//  Copyright © 2018 Shobhit Saxena. All rights reserved.
//

import UIKit
import SDWebImage
class BroucherVC: UIViewController {

    @IBOutlet weak var imgCamera: UIImageView!
    @IBOutlet weak var lblUserId: UILabel!
    @IBOutlet weak var btnUserName: UIButton!
    @IBOutlet weak var txtData: UILabel!
    var userName = ""
    var dict = NSDictionary()
    
    
    @IBOutlet weak var cityOne: UILabel!
    @IBOutlet weak var cityTwo: UILabel!
    @IBOutlet weak var cityThree: UILabel!
    @IBOutlet weak var addressOne: UILabel!
    @IBOutlet weak var addressTwo: UILabel!
    @IBOutlet weak var addressThree: UILabel!
    @IBOutlet weak var phoneOne: UIButton!
    @IBOutlet weak var phoneTwo: UIButton!
    @IBOutlet weak var phoneThree: UIButton!
    @IBOutlet weak var lblProperties: UILabel!
    @IBOutlet weak var lblAddedProperty: UILabel!
    @IBOutlet weak var lblBuilder: UILabel!
    @IBOutlet weak var lblURL: UILabel!
    
    @IBOutlet weak var viewBoutiqueTop: UIView!
    @IBOutlet weak var viewBoutiqueBottom: UIView!
    
    
    var imgName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        
        btnUserName.setTitle(userName, for: .normal)
        
        if imgName != ""{
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
            let getImagePath = NSString.path(withComponents: [paths, imgName])
            imgCamera.image = UIImage.init(contentsOfFile: getImagePath)
            imgCamera.layer.cornerRadius = imgCamera.frame.size.height/2
//            imgCamera.cornerRadius = imgCamera.frame.size.height/2
//            imgCamera.clipsToBounds = true
//            imgCamera.layer.masksToBounds = false
        }else{
            imgCamera.image = #imageLiteral(resourceName: "camera")
        }
        lblUserId.text = "USER ID : \(String(describing: dict.value(forKey: "UserId")!))"
        btnUserName.setTitle(String(describing: dict.value(forKey: "UserName")!), for: .normal)
        
        txtData.text = String(describing: dict.value(forKey: "WelcomeText")!)
        
        addressOne.text = ((dict.value(forKey: "PropertyLocation") as! NSArray).object(at: 0) as! String)
        addressTwo.text = ((dict.value(forKey: "PropertyLocation") as! NSArray).object(at: 1) as! String)
        addressThree.text = ((dict.value(forKey: "PropertyLocation") as! NSArray).object(at: 2) as! String)

        cityOne.text = ((dict.value(forKey: "PropertyCity") as! NSArray).object(at: 0) as! String)
        cityTwo.text = ((dict.value(forKey: "PropertyCity") as! NSArray).object(at: 1) as! String)
        cityThree.text = ((dict.value(forKey: "PropertyCity") as! NSArray).object(at: 2) as! String)
        
        phoneOne.setTitle(((dict.value(forKey: "PropertyContact") as! NSArray).object(at: 0) as! String), for: .normal)
        phoneTwo.setTitle(((dict.value(forKey: "PropertyContact") as! NSArray).object(at: 1) as! String), for: .normal)
        phoneThree.setTitle(((dict.value(forKey: "PropertyContact") as! NSArray).object(at: 2) as! String), for: .normal)
        
        lblProperties.text = String(describing: (dict.value(forKey: "PropertyInformation") as! NSArray).object(at: 0)) + "+"
        lblAddedProperty.text = String(describing: (dict.value(forKey: "PropertyInformation") as! NSArray).object(at: 1)) + " Properties"
        lblBuilder.text = String(describing: (dict.value(forKey: "PropertyInformation") as! NSArray).object(at: 2)) + "+"
        
        self.viewBoutiqueTop.addDashedBorder()
        self.viewBoutiqueBottom.addDashedBorder()
    }
    @objc func contactDealerPressed(mStr: String) {
        
    }
    @IBAction func btnOpenURL(_ sender: Any) {
        if let url = URL(string: "https://www.mypropertyboutique.com") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:])
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    @IBAction func btnPhoneCall(_ sender: UIButton) {
        var phoneNumber = ""
        switch sender.tag {
        case 0:
            phoneNumber = ((dict.value(forKey: "PropertyContact") as! NSArray).object(at: 0) as! String)
        case 1:
            phoneNumber = ((dict.value(forKey: "PropertyContact") as! NSArray).object(at: 1) as! String)
        case 2:
            phoneNumber = ((dict.value(forKey: "PropertyContact") as! NSArray).object(at: 2) as! String)
        default:
            phoneNumber = ""
        }
        if let url = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.openURL(url)
        }else{
            self.showAlertViewOkButton(message: "This Device not applicable to make phone call")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnHome(_ sender: Any) {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        for aViewController in viewControllers {
            if aViewController is ViewController {
                self.navigationController!.popToViewController(aViewController, animated: true)
            }
        }
    }
}
