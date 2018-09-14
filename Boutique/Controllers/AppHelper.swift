//
//  AppHelper.swift
//  Boutique
//
//  Created by Shobhit Saxena on 04/07/18.
//  Copyright © 2018 Shobhit Saxena. All rights reserved.
//
import UIKit
import Foundation
import MBProgressHUD
import CryptoSwift

class AppHelper: NSObject {
    // save to user default
    class func saveToUserDefault (value: AnyObject? , key: String!) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key as String)
        defaults.synchronize()
    }
    
    class func saveStringToUserDefault (value: String , key: String!) {
        let defaults = UserDefaults.standard
        defaults.setValue(value, forKey: key as String)
        defaults.synchronize()
    }

    class func userDefaultForKey ( key: String?) -> String?{
        let defaults = UserDefaults.standard
        let value = defaults.string(forKey: key! as String)
        if (value != nil) {
            return value!
        }
        return nil
    }
   
    class func objectUserDefaultForKey ( key: String?) -> AnyObject?{
        let defaults = UserDefaults.standard
        let value = defaults.object(forKey: key! as String)
        if (value != nil) {
            return value! as AnyObject?
        }
        return nil
    }
    class func isValidEmail(testStr:String) -> Bool {
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
    }
    class func isValidPhone(value: String) -> Bool
    {
        let charcter  = NSCharacterSet(charactersIn: "0123456789").inverted
        var filtered:String!
        let inputString:NSArray = value.components(separatedBy: charcter) as NSArray
        filtered = inputString.componentsJoined(by: "")
        return  value == filtered
    }
    struct UserInfo {
        var MobileNumber = ""
        var UserName = ""
        var Detail = ""
    }
    class func userDefaultForKeys(key: String) -> AnyObject? {
        let defaults = UserDefaults.standard
        if let decoded  = defaults.object(forKey: key) {
            let decodedvalue = NSKeyedUnarchiver.unarchiveObject(with: decoded as! Data)
            if (decodedvalue != nil) {
                return decodedvalue as AnyObject?
                
            }
        }
        return nil
    }
    class func isValidNumber(value: String) -> Bool
    {
        let charcter  = NSCharacterSet(charactersIn: "0123456789").inverted
        var filtered:String!
        let inputString:NSArray = value.components(separatedBy: charcter) as NSArray
        filtered = inputString.componentsJoined(by: "")
        return  value == filtered
    }
    // remove from user defaultes
    
    class  func removeFromUserDefaultForKey(key: String!) {
        let defaults = UserDefaults.standard
        let value = defaults.string(forKey: key! as String)
        if (value != nil) {
            defaults.removeObject(forKey: key as String)
        }
        defaults.synchronize()
        
    }
    class  func removeObjectFromUserDefaultForKey(key: String!) {
        let defaults = UserDefaults.standard
        let value = defaults.object(forKey: key as String)
        if (value != nil) {
            defaults.removeObject(forKey: key as String)
        }
        defaults.synchronize()
        
    }
    class func isConnectedToNetwork() -> Bool {
        let reachability = Reachability()!
        if reachability.isReachable {
            return true
        } else{
            return false
        }
    }
    
    class func checkForInternetConnection()
    {
        let reachability = Reachability()!
        reachability.whenReachable = { reachability in
            DispatchQueue.main.async {
                if reachability.isReachableViaWiFi {
                    println_debug("Reachable via WiFi")
                } else {
                    println_debug("Reachable via Cellular")
                }
            }
        }
        reachability.whenUnreachable = { reachability in
            DispatchQueue.main.async {
                println_debug("Not reachable")
            }
        }
    }
    class func hideActivityIndicator_MBProgressHUD(view: UIView) {
        MBProgressHUD.hide(for: view, animated: true)
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    class func showActivityUsingMBProgressHUD(uiView: UIView ,message : String) {
        let spinnerActivity = MBProgressHUD.showAdded(to: uiView, animated: true);
        spinnerActivity.label.text = message;
        UIApplication.shared.beginIgnoringInteractionEvents()
    }    
}
