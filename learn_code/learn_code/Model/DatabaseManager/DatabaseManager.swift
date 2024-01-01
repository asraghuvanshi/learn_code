//
//  DatabaseManager.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 22/12/2023.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage


class DatabaseManager {
    
    static let shared = DatabaseManager()
    private let reference = Database.database().reference()
    
    // MARK: - Create new User Method
    func addUser(userName: String, userEmail: String, mobileNo: String, password: String, profileImg: UIImage, completion: @escaping (Error?) -> Void) {
        FirebaseAuth.Auth.auth().createUser(withEmail: userEmail, password: password) { authResult, error in
            if let error = error {
                print("Error creating user: \(error.localizedDescription)")
                completion(error)
                return
            }
            
            guard let authUser = authResult?.user else {
                print("Auth user is nil")
                completion(nil)
                return
            }
            
            // Upload profile image and update user data in database
            self.uploadProfileImage(profileImg) { imageUrl, uploadError in
                guard uploadError == nil else {
                    print("Error uploading profile image: \(uploadError?.localizedDescription ?? "Unknown error")")
                    completion(uploadError)
                    return
                }
                
                // Update user data in database
                self.updateUserInDatabase(authUser.uid, userName: userName, userEmail: userEmail, mobileNo: mobileNo, imageUrl: imageUrl) { updateError in
                    completion(updateError)
                }
            }
        }
    }
    
    // MARK: - Fetch all users from database
    func fetchUsers(completion: @escaping ([UserResponse], Error?) -> Void) {
        reference.child("users").observeSingleEvent(of: .value, with: { snapshot in
            var users: [UserResponse] = []
            
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                   let userDict = childSnapshot.value as? [String: Any] {
                    do {
                        let userData = try JSONSerialization.data(withJSONObject: userDict, options: [])
                        let userResponse = try JSONDecoder().decode(UserResponse.self, from: userData)
                        users.append(userResponse)
                    } catch {
                        print("Error decoding user data: \(error)")
                        completion([], error)
                        return
                    }
                }
            }
            
            completion(users, nil)
        })
    }
    
    // MARK: - Helper functions
    
    private func uploadProfileImage(_ image: UIImage, completion: @escaping (String?, Error?) -> Void) {
        let storageRef = Storage.storage().reference()
        let imageRef = storageRef.child("profile_images").child(UUID().uuidString + ".jpg")
        
        if let uploadData = image.jpegData(compressionQuality: 0.5) {
            imageRef.putData(uploadData, metadata: nil) { metadata, error in
                if let error = error {
                    print("Error uploading image: \(error.localizedDescription)")
                    completion(nil, error)
                    return
                }
                
                imageRef.downloadURL { url, urlError in
                    guard let imageUrl = url?.absoluteString else {
                        print("Error getting image download URL: \(urlError?.localizedDescription ?? "Unknown error")")
                        completion(nil, urlError)
                        return
                    }
                    
                    completion(imageUrl, nil)
                }
            }
        } else {
            print("Failed to convert UIImage to data.")
        }
    }
    
    private func updateUserInDatabase(_ userId: String, userName: String, userEmail: String, mobileNo: String, imageUrl: String?, completion: @escaping (Error?) -> Void) {
        let userReference = reference.child("users").child(userId)
        var values: [String: Any] = [
            "fullName": userName,
            "userEmail": userEmail,
            "userMobile": mobileNo
        ]
        
        if let imageUrl = imageUrl {
            values["profileImageUrl"] = imageUrl
        }
        
        userReference.updateChildValues(values) { error, _ in
            if let error = error {
                print("Error updating user data: \(error.localizedDescription)")
                completion(error)
                return
            }
            
            print("User data updated successfully.")
            completion(nil)
        }
    }
    
    func fetchCurrentUser(userId: String, completion: @escaping (String, Error?) -> Void) {
        let userReference = reference.child("users").child(userId)
        
        userReference.observeSingleEvent(of: .value) { snapshot, error  in
            guard snapshot.exists() else {
                return
            }
            if let dictionary = snapshot.value as? [String : AnyObject]  {
                let username = dictionary["fullName"] as? String
                completion(username ?? "", nil)
            }
        }
    }
}

//  MARK:  Sending Messages / Conversation

extension DatabaseManager {
    
    public func createNewConversation(with userEmail: String , firstMessage: ChatMessage, completion: @escaping (Bool) -> Void) {
        
    }
    
    public func getAllConversation(with email: String ,completion: @escaping (Result<String, Error>) -> Void ) {
        
    }
    
    public func getAllMessagesFromConversation(with id: String, completion: @escaping (Result<String, Error>) -> Void) {
        
    }
    
    public func sendMessage(to conversation: String, messages: ChatMessage, completion: @escaping (Bool) -> Void) {
        
    }
}


//  MARK:  ChatMessage Struct
public struct ChatMessage {
    var sender: String
    var timeStamp: Date
    var messageContent: String
    var messageId: String
}
