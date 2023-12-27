//
//  DatabaseManager.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 22/12/2023.
//

import Foundation
import FirebaseDatabase

class DatabaseManager {
    
    static let databaseManager = DatabaseManager()
    
    private let database = Database.database().reference()
    
    
    public func addUser(with user: ChatUser, completion: @escaping (Bool) -> Void) {
        database.child(user.safeEmail).setValue([
            "name" : user.name,
            "phone": user.phone,
            "profileUrl" : user.profileUrl
        ], withCompletionBlock: { error, _ in
            guard error == nil else {
                print("failed to write to the database")
                completion(false)
                return
            }
            
            completion(true)
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
