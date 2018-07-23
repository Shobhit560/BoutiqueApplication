
import UIKit

@IBDesignable
extension UIView {
    
    
    //MARK:- Border related
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            self.clipsToBounds = true
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            self.clipsToBounds = true
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }

    
    //MARK:- Shadow related
    
    @IBInspectable var shadow: Bool {
        get {
            return self.shadow
        }
        set {
            if(newValue)
            {
                layer.shadowRadius = 3
                layer.shadowOpacity = 0.3
            }
        }
    }

    /* The shadow offset. Defaults to (0, -3). Animatable. */
    @IBInspectable var shadowOffset: CGPoint {
        set {
            layer.shadowOffset = CGSize(width: newValue.x, height: newValue.y)
        }
        get {
            return CGPoint(x: layer.shadowOffset.width, y:layer.shadowOffset.height)
        }
    }
    func addDashedBorder() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.darkGray.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.lineDashPattern = [2,3]
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 0, y: 0),
                                CGPoint(x: self.frame.width, y: 0)])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
//    func addDashedBorder() {
//        let color = UIColor.black.cgColor
//
//        let shapeLayer:CAShapeLayer = CAShapeLayer()
//        let frameSize = self.frame.size
//        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
//
//        shapeLayer.bounds = shapeRect
//        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
//        shapeLayer.fillColor = UIColor.clear.cgColor
//        shapeLayer.strokeColor = color
//        shapeLayer.lineWidth = 1
//        shapeLayer.lineJoin = kCALineJoinRound
//        shapeLayer.lineDashPattern = [6,3]
//        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath
//
//        self.layer.addSublayer(shapeLayer)
//    }
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    
    func addRightBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func addBottomBorderWithColor(color: UIColor, width: CGFloat ,vc: UIView) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: vc.frame.size.height - width, width: vc.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    
    func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func addShadowView(_ width:CGFloat=0.0, height:CGFloat=1.0, Opacidade:Float=0.7, maskToBounds:Bool=false, radius:CGFloat=4.0) {
        self.layer.cornerRadius = 5
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 2.0
        self.layer.masksToBounds = false
    }
    func roundCornerNormal(radius: CGFloat){
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.masksToBounds = false
    }
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        self.layer.masksToBounds = true
    }
}

