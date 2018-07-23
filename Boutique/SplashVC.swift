//
//  SplashVC.swift
//  Boutique
//
//  Created by Shobhit Saxena on 04/07/18.
//  Copyright © 2018 Shobhit Saxena. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.perform(#selector(SplashVC.updateSplash), with: nil, afterDelay: 3.0)
    }
    @objc func updateSplash() {
        let viewVC = ControllerFetcher().viewVC
        self.navigationController?.pushViewController(viewVC, animated: false)
    } 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
}
