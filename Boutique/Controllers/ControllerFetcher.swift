//
//  ControllerFetcher.swift
//  Boutique
//
//  Created by Shobhit Saxena on 04/07/18.
//  Copyright © 2018 Shobhit Saxena. All rights reserved.
//
import Foundation
import UIKit

class ControllerFetcher : NSObject{
    
//  SplashVC
    lazy var splashVC: SplashVC = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "SplashVC", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "SplashVC_ID") as! SplashVC
        return viewController
    }()
    
// LoginVC
    lazy var viewVC: ViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "ViewController_ID") as! ViewController
        return viewController
    }()
    
//  RegisterVC
    lazy var registrationVC: RegistrationVC = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "RegistrationVC_ID") as! RegistrationVC
        return viewController
    }()
    //  BroucherVC
    lazy var broucherVC: BroucherVC = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "BroucherVC_ID") as! BroucherVC
        return viewController
    }()
    //  PopVC
    lazy var popVC: PopUpVC = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "PopUpVC_ID") as! PopUpVC
        return viewController
    }()
}
