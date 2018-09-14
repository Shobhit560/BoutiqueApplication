//
//  Defines.swift
//  Boutique
//
//  Created by Shobhit Saxena on 04/07/18.
//  Copyright © 2018 Shobhit Saxena. All rights reserved.
//

import Foundation
import UIKit

//MARK:- AppDelegate

let appDelegateShared = UIApplication.shared.delegate as? AppDelegate

//MARK:- General Constants
let IS_IOS_7 = UIDevice.current.systemVersion.hasPrefix("7")
let IS_IOS_8 = UIDevice.current.systemVersion.hasPrefix("8")

let IS_IPAD_PRO = UIScreen.main.bounds.size.height == 1366*2.0
let IS_IPAD_AIR = UIScreen.main.bounds.size.height == 1024*2.0


let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height
let screen = UIScreen.main.bounds


let kbaseURLDev =  "https://www.mypropertyboutique.com/"
let kHomeBuyer = "mpbapi/home-buyer"
let kleadCapture = "mpbapi/lead-capture"
let kUpload = "assets/uploads/leadcapture"
let crmIntegration = "http://stagingagldashboard.adv8.co/webforms/save-Data/"

let colorGreen = UIColor(red: 129.0/255.0, green: 183.0/255.0, blue: 34.0/255.0, alpha: 1.0)
let colorRed = UIColor(red: 218.0/255.0, green: 37.0/255.0, blue: 28.0/255.0, alpha: 1.0)
let colorPopUp = UIColor(red: 76.0/255.0, green: 76.0/255.0, blue: 76.0/255.0, alpha: 1.0)
let colorBlue = UIColor(red: 0.0/255.0, green: 68.0/255.0, blue: 142.0/255.0, alpha: 1.0)
let colorLightGrey = UIColor(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: 1.0)
let colorDarkGrey = UIColor(red: 237.0/255.0, green: 237.0/255.0, blue: 237.0/255.0, alpha: 1.0)

//MARK :- different font size

//FOR HEADER(BOLD)
let headerFontBoldForNavigationBar : CGFloat = 24.0

//FOR SUB HEADINGS(BOLD)
let subHeaderFontBoldForAllControllers : CGFloat = 16.0
let fontBoldForCustomerDetails : CGFloat = 20.0

//FOR BUTTONS
let fontRegularForButtons : CGFloat = 20.0

//FOR NORMAL TEXT
let fontRegularForText : CGFloat = 16.0
//FOR NORMAL Pop TEXT
let fontRegularForPopText : CGFloat = 14.0


//FOR DASHBOARD BUTTONS
let fontRegularForDashBoardButtons : CGFloat = 30.0
let fontBoldForTimeEvaluationText : CGFloat = 30.0

let kMobRegNumber = "Mobile_RegNo"
let kUserID = "UserName"
let kPassword = "UserPassword"
let kDR = "DR"

//MARK:- check simulator
class SimulatorUtility
{
    class var isRunningSimulator: Bool
        {
        get
        {
            return TARGET_IPHONE_SIMULATOR != 0
        }
    }
}

//MARK:- service URL'S
enum ServiceUrls : String
{
    case baseURL
    case baseURLLive
    
    var description : String
    {
        switch self {
        case .baseURL:
            return (appDelegateShared?.baseURL)! as String
            
        case .baseURLLive:
            return (appDelegateShared?.baseURL)! as String
        }
    }
}

// MARK : GLOBAL Functions
func println_debug <T> (_ object:T) {
//    print(object)
}

//MARK:- service keys

enum ErrorCodes: String
{
    case error_success_JC = "0"
    case error_success = "200"
    case error_code_failed = "1"
    case error_code_Internet_Probelm = "22"
}

//MARK:- alert msgs

enum AlertMessages : CustomStringConvertible {
    case alertForEmptyPassword
    case alertForEmptyUserId
    case alertForEmptyEmailPassword
    case alertForNetwork
    case alertForNoDataFound
    case signUp
    case Logout
    case underDevelopment
    case alertForRegistrationPassword
    case alertForOneSelection
    case mobileNumber
    case email
    case ValidateMobile
    case ValidateMobile2
    case ValidateEmail
    var description : String
    {
        switch self
        {
        case .alertForEmptyPassword : return NSLocalizedString("alertForEmptyPassword", comment: "");
        case .alertForEmptyUserId : return NSLocalizedString("alertForEmptyUserId", comment: "");
        case .alertForEmptyEmailPassword : return NSLocalizedString("alertForEmptyEmailPassword", comment: "");
        case .alertForNetwork: return NSLocalizedString("alertForNetwork",  comment: "");
        case .alertForNoDataFound: return NSLocalizedString("alertForNoDataFound",  comment: "");
        case .signUp: return NSLocalizedString("signUp",  comment: "");
        case .Logout:return NSLocalizedString("Logout", comment: "")
        case .underDevelopment:return NSLocalizedString("underDevelopment", comment: "")
        case .mobileNumber: return NSLocalizedString("mobileNumber", comment:"")
        case .email: return NSLocalizedString("email", comment:"")
        case .ValidateMobile: return NSLocalizedString("ValidateMobile", comment:"")
        case .ValidateMobile2: return NSLocalizedString("ValidateMobile2", comment:"")
        case .ValidateEmail: return NSLocalizedString("ValidateEmail", comment:"")
        case .alertForRegistrationPassword: return NSLocalizedString("alertForRegistrationPassword", comment:"")
        case .alertForOneSelection: return NSLocalizedString("alertForOneSelection", comment:"")            
        }
    }
}

//MARK:- service keys
enum ServiceKeys: String
{
    case key_code = "code"
    case key_result = "result"
    case key_error_msg = "message"
    case key_error = "error"
}

enum Constants: String
{
    case app_name = "My Property Boutique"
}
//MARK:- button title
enum ButtonTitle: CustomStringConvertible
{
    case ok
    case cancel
    case yes
    case no
    case apply
    case retry
  
    var description: String
    {
        switch self
        {
            case .ok: return NSLocalizedString("Ok", comment: "")
            case .cancel: return NSLocalizedString("Cancel", comment: "")
            case .yes: return NSLocalizedString("Yes", comment: "")
            case .no: return NSLocalizedString("No", comment: "")
            case .apply: return NSLocalizedString("Apply", comment: "")
            case .retry: return NSLocalizedString("Retry", comment: "")
        }
    }
}

