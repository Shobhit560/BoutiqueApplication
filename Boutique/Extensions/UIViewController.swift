//
//  UIViewController.swift
//  Boutique
//
//  Created by Shobhit Saxena on 04/07/18.
//  Copyright © 2018 Shobhit Saxena. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    enum ActionType: Int{
        
        case  kActionTypeCancel = 0
        case  kActionTypeOK
    }
    typealias AlertAction = (ActionType) ->Void
    
    func showAlertViewOkButton(message: String){
        
        let alertController = UIAlertController(title: Constants.app_name.rawValue, message: message, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: ButtonTitle.ok.description, style: .default) { (action:
         UIAlertAction) in
            print("You've pressed OK button",ButtonTitle.ok.description);
        }
        
        alertController.addAction(OKAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion:nil)
        }
        
    }
    func showCustomAlertViewOkButton(titleName:String, message: String){
        
        let alertController = UIAlertController(title: titleName, message: message, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: ButtonTitle.ok.description, style: .default) { (action:
            UIAlertAction) in
            print("You've pressed OK button",ButtonTitle.ok.description);
        }
        
        alertController.addAction(OKAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion:nil)
        }
        
    }
    
    func showAlertView(message: String, onCompletion:@escaping AlertAction){
        
        let alertController = UIAlertController(title: Constants.app_name.rawValue, message: message, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: ButtonTitle.ok.description, style: .default) { (action:
            UIAlertAction) in
            print("You've pressed OK button",ButtonTitle.ok.description);
            onCompletion(ActionType.kActionTypeOK)
        }
        alertController.addAction(OKAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion:nil)
        }
    }
    
    func showAlertViewWithCustomButtons(message: String, okButtonTitle: String, CancelButtonTitle: String ,onCompletion:@escaping AlertAction){
        
        let alertController = UIAlertController(title: Constants.app_name.rawValue, message: message, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: okButtonTitle, style: .default) { (action:
            UIAlertAction) in
            print("You've pressed OK button",okButtonTitle);
            onCompletion(ActionType.kActionTypeOK)
        }
        let CancleAction = UIAlertAction(title: CancelButtonTitle, style: .default) { (action:
            UIAlertAction) in
            print("You've pressed OK button",CancelButtonTitle);
            onCompletion(ActionType.kActionTypeCancel)
        }
        
        alertController.addAction(CancleAction)
        alertController.addAction(OKAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion:nil)
        }
    }
    
    
}

