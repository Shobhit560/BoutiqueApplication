//
//  UIView.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 11/5/15.
//  Copyright © 2015 Yuji Hato. All rights reserved.
//

import UIKit



extension UITextField {
    func setLeftPaddingPoints(_ left:CGFloat){
        let paddingView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: left, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ right:CGFloat) {
        let paddingView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: right, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

public enum ImageFormat {
    case png
    case jpeg(CGFloat)
}

extension UIImage {
    
    public func base64(format: ImageFormat) -> String? {
        var imageData: Data?
        switch format {
        case .png: imageData = UIImagePNGRepresentation(self)
        case .jpeg(let compression): imageData = UIImageJPEGRepresentation(self, compression)
        }
        return imageData?.base64EncodedString()
    }
}


