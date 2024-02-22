//
//  Constant.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 30/11/2023.
//

import UIKit


public enum FontStyle: String {
    case light = "OpenSans-Light"
    case bold = "OpenSans-Bold"
    case boldItalic = "OpenSans-BoldItalic"
    case extraBold = "OpenSans-ExtraBold"
    case extraBoldItalic = "OpenSans-ExtraBoldItalic"
    case italic = "OpenSans-Italic"
    case lightItalic = "OpenSans-LightItalic"
    case regular = "OpenSans-Regular"
    case semibold = "OpenSans-Semibold"
    case semiBoldItalic = "OpenSans-SemiboldItalic"
    
    static func setFont(_ type: FontStyle = .regular, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: type.rawValue, size: size)!
    }
}


//MARK:- StoryBoards
enum AppStoryboard : String {
    case Main           = "Main"
    case Tab            = "Tab"
    case Qticket        = "Qticket"
    
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
}

public struct FontSize{
    static let navigationTitle18 = 18
    static let textfiledTitleFont13 = 13
    static let textfieldFont15 = 15
    static let boldTitle20  = 20
    static let boldTitle22  = 22
    static let boldTitle24  = 24
    static let boldTitle30  = 30
    
    static let heavy40         = 40
    
    static let title16 = 16
    static let title13 = 13
    static let title12 = 12
    static let title18 = 18
    static let title10 = 10
    static let title14 = 14
    
    static let buttonFont14 = 14
    static let buttonFont16 = 16
    static let buttonFont17 = 17
    static let buttonFont18 = 18
    static let buttonFont20 = 20
    static let buttonFont22 = 22
    static let buttonFont24 = 24
    
}


public enum UIName {
    static let welcomeText = "Welcome"
    static let login = "Login"
    static let signup = "Signup"
    static let email = "Email"
    static let password = "Password"
    static let fullName = "Full Name"
    static let mobileNumber = "Mobile Number"
    static let gender = "Gender"
    static let createAccount = "Create an account ?"
    static let otpVerification = "OTP Verification"
    static let otpSentMessage = "OTP has been sent to you register mobile number and email"
    static let activeUser = "Active Users"
    
    static let chatSupportText = "Welcome to Qticket Chat Support"
    static let help = "What are you looking for ?"
}

public enum UINavigationTitle {
    static let chatHistory = "Chat History"
    static let chats = "Chats"
    static let createPost = "Create Posts"
    static let userFeeds = "User Feeds"
    
}

public enum UIPlaceholder {
    static let enterEmail = "Enter your email"
    static let enterPassword = "Enter your password"
    static let enterFullname = "Enter your full name"
    static let enterPhone = "Enter you phone number"
}

public enum UIButtonTitle {
    static let loginText = "Login"
    static let signupText = "Sign Up"
    static let genderMale = "Male"
    static let genderFemale = "Female"
    static let follow = " Follow"
    static let post = "Post"
    static let chatWithAgent = "Chat With Us"
    static let callUs =  "Call Us"
    
}

public enum ImageCollection {
    static let homeTab = "home_tab_ic"
    static let feedTab = "feed_tab_ic"
    static let profileTab = "profile_tab_ic"
    static let postTab = "post_tab_ic"
    static let radioFill = "radioFill"
    static let radioUnfill = "radioUnfill"
    static let backImage = "back_ic"
    static let chatIcon = "chat_ic"
    
}
