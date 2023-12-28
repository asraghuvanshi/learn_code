//
//  DatabaseManager.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 22/12/2023.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase


class DatabaseManager {
    
    static let databaseManager = DatabaseManager()
    
    static let reference = Database.database().reference(fromURL: "https://learncodeproject-58c90-default-rtdb.firebaseio.com/")
    
    ///   Create new User Method
    static func addUser(userName:String ,userEmail: String, mobileNo: String, password: String) {
        FirebaseAuth.Auth.auth().createUser(withEmail: userEmail, password: password, completion: { authUser, error in
            if error != nil {
                print(error)
                return
            }
            
            guard let authResult = authUser?.user.uid else { return }
            
            let userReference = reference.child("users").child(authResult)
            let values = ["fullName": userName, "userEmail": userEmail, "userMobile": mobileNo]
            userReference.updateChildValues(values, withCompletionBlock: { error, ref in
                if error != nil {
                    print(ref)
                    return
                }
                print(ref)
            })
            
        })
    }
    
    
    ///   Fetch all user from database
    static func fetchUser() {
        Database.database().reference().child("users").observeSingleEvent(of: .childAdded, with: { snapshot in
            print(snapshot , snapshot.key)
            let user = snapshot.value as? [String : AnyObject]
        })
    }
}



struct ChatUser {
    let name: String
    let email: String
    let phone: String
    var profileUrl: String {
        return "\(safeEmail)_profile_picture.png"
    }
    var safeEmail : String {
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
}
