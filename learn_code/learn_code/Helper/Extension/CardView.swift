//
//  CardView.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 08/02/2024.
//


import UIKit

@IBDesignable
class CardView: UIView {

    @IBInspectable var cornerRadiuss: CGFloat = 10
    @IBInspectable var shadowOffsetWidth: Int = 1
    @IBInspectable var shadowOffsetHeight: Int = 1
    @IBInspectable var shadowColors: UIColor? = UIColor.gray
    @IBInspectable var shadowOpacitys: Float = 0.4

    override func layoutSubviews() {
        layer.cornerRadius = cornerRadiuss
        
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadiuss)
       layer.masksToBounds = false
        layer.shadowColor = shadowColors?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacitys
        layer.shadowPath = shadowPath.cgPath
    }

}
@IBDesignable
class ButtonView: UIButton {

    @IBInspectable var cornerRadiuss: CGFloat = 2
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 0
    @IBInspectable var shadowColors: UIColor? = UIColor.clear
    @IBInspectable var shadowOpacitys: Float = 0.0

    override func layoutSubviews() {
        layer.cornerRadius = cornerRadiuss
        
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadiuss)
       layer.masksToBounds = false
        layer.shadowColor = shadowColors?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacitys
        layer.shadowPath = shadowPath.cgPath
    }
}

class CardViewBorder: UIView {

    @IBInspectable var cornerRadiuss: CGFloat = 2
    @IBInspectable var borderColors: UIColor? = UIColor.black
    
    @IBInspectable var borderWidths: CGFloat = 2

    override func layoutSubviews() {
        layer.cornerRadius = cornerRadiuss
        layer.borderColor = borderColors?.cgColor
        layer.borderWidth = borderWidths
    }
}
