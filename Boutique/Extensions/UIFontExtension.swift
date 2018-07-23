//
//  UIFontExtension.swift
//  Boutique
//
//  Created by Shobhit Saxena on 04/07/18.
//  Copyright © 2018 Shobhit Saxena. All rights reserved.
//

import UIKit


extension UIFont {
   
    class func regularFontOfSmallSize16() -> UIFont {
        return UIFont(name: "HelveticaNeue", size: fontRegularForText)!
    }
    
    class func regularFontOfSmallSize14() -> UIFont {
        return UIFont(name: "HelveticaNeue", size: fontRegularForPopText)!
    }
    class func boldFontOfBigSize24() -> UIFont {
        return UIFont(name: "HelveticaNeue-Bold", size: headerFontBoldForNavigationBar)!
    }
    
    class func boldFontOfSmallSize16() -> UIFont {
        return UIFont(name: "HelveticaNeue-Bold", size: subHeaderFontBoldForAllControllers)!
    }
    
    class func boldFontOfSmallSize20() -> UIFont {
        return UIFont(name: "HelveticaNeue-Bold", size: fontBoldForCustomerDetails)!
    }

    class func regularfontOfButtonSize20() -> UIFont {
        return UIFont(name: "HelveticaNeue", size: fontRegularForButtons)!
    }
    
    class func regularfontOfButtonSize30() -> UIFont {
        return UIFont(name: "HelveticaNeue", size: fontRegularForDashBoardButtons)!
    }
    
    class func boldfontOfTextSize30() -> UIFont {
        return UIFont(name: "HelveticaNeue-Bold", size:fontBoldForTimeEvaluationText)!
    }
    
}
