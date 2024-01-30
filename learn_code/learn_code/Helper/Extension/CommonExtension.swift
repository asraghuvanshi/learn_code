//
//  CommonExtension.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 30/11/2023.
//

import UIKit


extension UIApplication {
    static func setRootViewController(_ viewController: UIViewController) {
        UIApplication.shared.windows.first?.rootViewController = viewController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}

extension UILabel {
    func configureLabel(text:String , color: UIColor, fontStyle: FontStyle, fontSize: CGFloat) {
        self.text = text
        self.textColor = color
        self.font = UIFont.init(name: fontStyle.rawValue, size: fontSize)
        self.clipsToBounds = true
    }
    
    func configureLabelAndAlignment(text:String , color: UIColor, fontStyle: FontStyle, fontSize: CGFloat, align: NSTextAlignment = .natural) {
        self.text = text
        self.textColor = color
        self.textAlignment = align
        self.numberOfLines = .zero
        self.lineBreakMode = .byWordWrapping
        self.font = UIFont.init(name: fontStyle.rawValue, size: fontSize)
        self.clipsToBounds = true
    }
}

extension UILabel {
    func setAttributedColor(primaryText: String, secondaryText: String, primaryColor: UIColor = .whiteColor, secondaryColor: UIColor = .whiteColor) {
        let attributedString = NSMutableAttributedString(string: primaryText + secondaryText)

        // Set color for the main text
        attributedString.addAttribute(.foregroundColor, value: primaryColor, range: NSRange(location: 0, length: primaryText.count))

        // Set color for the secondary text
        attributedString.addAttribute(.foregroundColor, value: secondaryColor, range: NSRange(location: primaryText.count, length: secondaryText.count))

        // Apply the attributed string to the label
        self.attributedText = attributedString
    }
}

extension UIButton {
    func configureButton(title: String, fontStyle: FontStyle, fontSize: CGFloat, color: UIColor, backgroundColor: UIColor? = nil, imageName: String? = nil, imageTextSpacing: CGFloat = 8.0) {
           // Set up font
           guard let font = UIFont(name: fontStyle.rawValue, size: fontSize) else {
               fatalError("Failed to load font")
           }

           // Set up title attributes
           let titleAttributes: [NSAttributedString.Key: Any] = [
               .font: font,
               .foregroundColor: color,
           ]

           let attributedText = NSAttributedString(string: title, attributes: titleAttributes)
           self.setAttributedTitle(attributedText, for: .normal)

           // Set up background color
           self.layer.backgroundColor = backgroundColor?.cgColor

           // Set up image
           if let imageName = imageName {
               let image = UIImage(named: imageName)
               self.setImage(image, for: .normal)
               self.imageView?.contentMode = .scaleAspectFit

               // Adjust spacing between image and text
               let spacing = imageTextSpacing
               let imageSize = image?.size ?? CGSize.zero
               self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing/2, bottom: 0, right: spacing/2)
               self.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing/2, bottom: 0, right: -spacing/2)
           }
       }
}

extension UIView{
    func setBorder(radius:CGFloat, color:UIColor = UIColor.lightGray,width:CGFloat = 0.3){
        self.layer.cornerRadius = CGFloat(radius)
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.clipsToBounds = true
    }
    
    func setNavigationBackground() {
        let gradient: CAGradientLayer = CAGradientLayer()

        gradient.colors = [UIColor.darkGreen.cgColor, UIColor.deepSky.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 5.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)
        self.layer.insertSublayer(gradient, at: 0)
    }
}

func convertTimestampToTime(timestamp: TimeInterval) -> String {
    let date = Date(timeIntervalSince1970: timestamp)

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "h:mm a"
    dateFormatter.timeZone = TimeZone.current
    dateFormatter.locale = Locale.current
    
    let formattedTime = dateFormatter.string(from: date)
    
    return formattedTime
}

