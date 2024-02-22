//
//  Color.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 02/12/2023.
//

import UIKit

extension UIColor {
    
    /// color with hex string
    ///
    /// - Parameter hexString: hexString description
    convenience init(hexString:String) {
        var hexString:String = hexString.trimmingCharacters(in: CharacterSet.whitespaces)
        
        if (hexString.hasPrefix("#")) { hexString.remove(at: hexString.startIndex) }
        
        var color:UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(displayP3Red: red, green: green, blue: blue, alpha: 1)
    }
    

//    #43cea2
//    #185a9d
    static let appColor = UIColor(hexString:"#6F00FF")
    
    static let whiteColor = UIColor(hexString: "#FFFFFF")
    static let blackColor = UIColor(hexString: "#00000")
    static let deepSky = UIColor(hexString: "#6e67ff")
    static let darkGreen = UIColor(hexString: "#95fbff")
    static let lightLevendarBlue = UIColor(hexString: "#E6E6FA")
    static let lightPurpleColor = UIColor(hexString: "#CCCCFF")
    static let charcoalColor = UIColor(hexString: "#36454F")
    static let slateGrayColor = UIColor(hexString: "#657383")
    static let platinumColor = UIColor(hexString: "#E5E4E2")
    static let creamColor = UIColor(hexString: "#fffdd0")
}
