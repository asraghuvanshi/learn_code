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

//  MARK:  ChatMessage Struct
public struct Message {
    var sender: String
    var timeStamp: Date
    var messageContent: String
    var messageId: String
}


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
    func fetchUsers(completion: @escaping ([(userId: String, userResponse: UserResponse)], Error?) -> Void) {
        reference.child("users").observeSingleEvent(of: .value, with: { snapshot in
            var users: [(userId: String, userResponse: UserResponse)] = []
            
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                   let userDict = childSnapshot.value as? [String: Any] {
                    do {
                        let userId = childSnapshot.key
                        let userData = try JSONSerialization.data(withJSONObject: userDict, options: [])
                        var userResponse = try JSONDecoder().decode(UserResponse.self, from: userData)
                        if FirebaseAuth.Auth.auth().currentUser?.uid != userId {
                            userResponse.userId = userId
                            let userTuple = (userId: userId, userResponse: userResponse)
                            users.append(userTuple)
                        }
                        
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

//  MARK:  Sending And Fetching Messages/Conversation


struct ChatMessage {
    let senderId: String
    let receiverId: String
    let text: String
    let timestamp: TimeInterval
}


class MessageManager {
    static let shared = MessageManager()
    
    private let database = Database.database().reference()
    
    func sendMessage(message: ChatMessage) {
        let messagesRef = database.child("messages").childByAutoId()
        let messageData: [String: Any] = [
            "senderId": message.senderId,
            "receiverId": message.receiverId,
            "text": message.text,
            "timestamp": ServerValue.timestamp()
        ]
        messagesRef.setValue(messageData)
    }
    
    
    func fetchConversations(completion: @escaping ([(userId: String, userResponse: ChatMessageModel)], Error?) -> Void) {
        Database.database().reference().child("messages").observe(.childAdded, with: { snapshot in
            guard let userDict = snapshot.value as? [String: Any] else { return }
            
            print(userDict, "snap value")
            
        })
    }
}
