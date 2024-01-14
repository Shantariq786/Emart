//
//
//
//
//import Foundation
//import UIKit
//
//@IBDesignable
//class CardView: UIView {
//
//    @IBInspectable var mycornerRadius: CGFloat = 5
//
//    @IBInspectable var myshadowOffsetWidth: Int = 0
//    @IBInspectable var myshadowOffsetHeight: Int = 1
//    @IBInspectable var myshadowColor: UIColor? = UIColor.lightGray
//    @IBInspectable var myshadowOpacity: Float = 0.1
//
//    override func layoutSubviews() {
//        layer.cornerRadius = mycornerRadius
//
//        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
//
//        layer.masksToBounds = false
//        layer.shadowColor = myshadowColor?.cgColor
//        layer.shadowOffset = CGSize(width: myshadowOffsetWidth, height: myshadowOffsetHeight);
//        layer.shadowOpacity = shadowOpacity
//        layer.shadowPath = shadowPath.cgPath
//    }
//
//}
//
//@IBDesignable
//class RoundUIView: UIView {
//
//    @IBInspectable var myborderColor: UIColor = UIColor.white {
//        didSet {
//            self.layer.borderColor = borderColor.cgColor
//        }
//    }
//
//    @IBInspectable var myborderWidth: CGFloat = 2.0 {
//        didSet {
//            self.layer.borderWidth = borderWidth
//        }
//    }
//
//    @IBInspectable var mycornerRadius: CGFloat = 0.0 {
//        didSet {
//            self.layer.cornerRadius = cornerRadius
//        }
//    }
//
//}
//
//@IBDesignable
//class RoundUITextView: UITextView {
//
//    @IBInspectable var myborderColor: UIColor = UIColor.white {
//        didSet {
//            self.layer.borderColor = borderColor.cgColor
//        }
//    }
//
//    @IBInspectable var myborderWidth: CGFloat = 2.0 {
//        didSet {
//            self.layer.borderWidth = borderWidth
//        }
//    }
//
//    @IBInspectable var mycornerRadius: CGFloat = 0.0 {
//        didSet {
//            self.layer.cornerRadius = cornerRadius
//        }
//    }
//
//}
//@IBDesignable
//class RoundImage: UIImageView {
//
//
//    @IBInspectable var mycornerRadius: CGFloat = 0 {
//        didSet{
//            self.layer.cornerRadius = cornerRadius
//        }
//    }
//
//    // set border width
//    @IBInspectable var myborderWidth: CGFloat = 0 {
//        didSet{
//            self.layer.borderWidth = borderWidth
//        }
//    }
//
//    // set border width
//    @IBInspectable var myshadowColor: CGColor = UIColor.white.cgColor {
//        didSet{
//            self.layer.shadowColor = myshadowColor
//        }
//    }
//    // set border width
//    @IBInspectable var myshadowOpacity: Float = 0 {
//        didSet{
//            self.layer.shadowOpacity = myshadowOpacity
//        }
//    }
//
//    override func layoutSubviews() {
//        layer.masksToBounds = false
//        layer.shadowOffset = CGSize(width: 0, height: 1);
//    }
//}
//
//
//
//
//







import Foundation
import UIKit


@IBDesignable
class CustomButton: UIButton {
    
    @IBInspectable var corner_Radius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var border_Color: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var border_Width: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.masksToBounds = true
    }
    
}
@IBDesignable
class CardView: UIView {
    
    @IBInspectable var mycornerRadius: CGFloat = 5
    
    @IBInspectable var myshadowOffsetWidth: Int = 0
    @IBInspectable var myshadowOffsetHeight: Int = 1
    @IBInspectable var myshadowColor: UIColor? = UIColor.lightGray
    @IBInspectable var myshadowOpacity: Float = 0.1
    
    override func layoutSubviews() {
        layer.cornerRadius = mycornerRadius
        
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        layer.masksToBounds = false
        layer.shadowColor = myshadowColor?.cgColor
        layer.shadowOffset = CGSize(width: myshadowOffsetWidth, height: myshadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }
    
}

@IBDesignable
class RoundUIView: UIView {
    
    @IBInspectable var myborderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var myborderWidth: CGFloat = 2.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var mycornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
}

@IBDesignable
class RoundUITextView: UITextView {
    
    @IBInspectable var myborderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var myborderWidth: CGFloat = 2.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var mycornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
}
@IBDesignable
class RoundImage: UIImageView {
    
    
    @IBInspectable var mycornerRadius: CGFloat = 0 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    // set border width
    @IBInspectable var myborderWidth: CGFloat = 0 {
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    // set border width
    @IBInspectable var myshadowColor: CGColor = UIColor.white.cgColor {
        didSet{
            self.layer.shadowColor = myshadowColor
        }
    }
    // set border width
    @IBInspectable var myshadowOpacity: Float = 0 {
        didSet{
            self.layer.shadowOpacity = myshadowOpacity
        }
    }
    
    override func layoutSubviews() {
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0, height: 1);
    }
}





