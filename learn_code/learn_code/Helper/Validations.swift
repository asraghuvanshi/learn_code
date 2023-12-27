//
//  Validations.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 30/11/2023.
//

import UIKit

class Validation {
    public func validateName(name: String) ->Bool {
        // Length be 18 characters max and 3 characters minimum, you can always modify.
        let nameRegex = "^\\w{3,18}$"
        let trimmedString = name.trimmingCharacters(in: .whitespaces)
        let validateName = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        let isValidateName = validateName.evaluate(with: trimmedString)
        return isValidateName
    }
    
    public func validaPhoneNumber(phoneNumber: String) -> Bool {
        let phoneNumberRegex =  "^[0-9]{9,12}$" //"^[6-9]\\d{9}$"
        let trimmedString = phoneNumber.trimmingCharacters(in: .whitespaces)
        let validatePhone = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        let isValidPhone = validatePhone.evaluate(with: trimmedString)
        return isValidPhone
    }
    
    public func validateEmailId(emailID: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let trimmedString = emailID.trimmingCharacters(in: .whitespaces)
        let validateEmail = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let isValidateEmail = validateEmail.evaluate(with: trimmedString)
        return isValidateEmail
    }
    
    public func validatePassword(password: String) -> Bool {
        //Minimum 8 characters at least 1 Alphabet and 1 Number:
        let passRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        let trimmedString = password.trimmingCharacters(in: .whitespaces)
        let validatePassord = NSPredicate(format:"SELF MATCHES %@", passRegEx)
        let isvalidatePass = validatePassord.evaluate(with: trimmedString)
        return isvalidatePass
    }
}

extension Int{
    func generateFontSize() -> CGFloat {
        switch UIDevice.current.userInterfaceIdiom {
           case .phone:
              return CGFloat(self)
        case .pad:
            let value = CGFloat(self) * 1.5
            return value
        case .unspecified:
         debugPrint("unspecified")
        case .tv:
            debugPrint("tv")
        case .carPlay:
            debugPrint("carPlay")
        case .mac:
            let value = CGFloat(self) * 1.5
            return value
        @unknown default:
            print("unknown")
        }
        return Double(self)
    }
}
