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
    let reference = Database.database().reference()
    
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
    //  MARK:  Upload Profile Image
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
    
    //  MARK:  Update User in Database
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
    
    //  MARK:  Fetch Current User
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


//  MARK:  Struct For Chat Message Structure


class MessageManager {
    
    static let shared = MessageManager()
    let databaseRef = Database.database().reference().child("conversations")
    //  MARK:  Send Messages To Users
    func sendMessagesToUser(message: MessageModel, completion: @escaping (Error?) -> Void) {
        let databaseRef = Database.database().reference()
        
        let conversationId = [message.senderId, message.receiverId].sorted().joined(separator: "_")
        
        // Generate a unique message ID
        let messageId = databaseRef.child("conversations").child(conversationId).child("messages").childByAutoId().key!
        
        // Create a dictionary with message data
        let messageData: [String: Any] = [
            "senderId": message.senderId,
            "receiverId": message.receiverId,
            "content": message.content,
            "timestamp": message.timestamp,
        ]
        
        // Update the message in the conversation
        let messagePath = "conversations/\(conversationId)/messages/\(messageId)"
        let messageUpdate: [String: Any] = [
            "/\(messagePath)": messageData
        ]
        
        // Update the conversation node
        databaseRef.updateChildValues(messageUpdate) { error, _ in
            completion(error)
        }
    }
    
    //  MARK: Fetch all Conversations
    func getAllConversations(receiverId: String, completion: @escaping
                             ([MessageModel]) -> Void) {
        var messages: [MessageModel] = []
        
        if let currentUserId = Auth.auth().currentUser?.uid {
            let conversationPath = [currentUserId, receiverId].sorted().joined(separator: "_")
            
            
            // Use observeSingleEvent instead of observe
            databaseRef.observeSingleEvent(of: .value, with: { snapshot in
                guard snapshot.exists() else {
                    // Call completion with an empty array if there are no conversations
                    messages.removeAll()
                    completion([])
                    return
                }
                
                if let conversations = snapshot.value as? [String: Any] {
                    for (conversationId, conversationData) in conversations {
                        if let messagesData = (conversationData as? [String: Any])?["messages"] as? [String: Any] {
                            for (_, messageData) in messagesData {
                                if let message = messageData as? [String: Any] {
                                    let content = message["content"] as? String ?? ""
                                    let receiverId = message["receiverId"] as? String ?? ""
                                    let senderId = message["senderId"] as? String ?? ""
                                    let timestamp = message["timestamp"] as? TimeInterval ?? 0.0
                                    
                                    let messageData = MessageModel(senderId: senderId, receiverId: receiverId, content: content, timestamp: timestamp)
                                    if conversationId.contains(conversationPath) {
                                        messages.append(messageData)
                                        
                                        print("fetched message \(messages)")
                                    }
                                }
                            }
                        }
                    }
                    messages.sort { $0.timestamp < $1.timestamp }
                    
                    completion(messages)
                }
            })
        }
    }
    
    
    //  MARK:  Observe Conversations
    func observeConversations(receiverId: String, completion: @escaping ([MessageModel]) -> Void) {
        var messages: [MessageModel] = []
        
        if let currentUserId = Auth.auth().currentUser?.uid {
            let conversationPath = [currentUserId, receiverId].sorted().joined(separator: "_")
            
            
            // Use observeSingleEvent instead of observe
            databaseRef.observe(.value, with: { snapshot in
                guard snapshot.exists() else {
                    // Call completion with an empty array if there are no conversations
                    messages.removeAll()
                    completion([])
                    return
                }
                
                if let conversations = snapshot.value as? [String: Any] {
                    for (conversationId, conversationData) in conversations {
                        if let messagesData = (conversationData as? [String: Any])?["messages"] as? [String: Any] {
                            for (_, messageData) in messagesData {
                                if let message = messageData as? [String: Any] {
                                    let content = message["content"] as? String ?? ""
                                    let receiverId = message["receiverId"] as? String ?? ""
                                    let senderId = message["senderId"] as? String ?? ""
                                    let timestamp = message["timestamp"] as? TimeInterval ?? 0.0
                                    let senderTyping = message["isSenderTyping"] as? Bool ?? false
                                    let receiverTyping = message["isSenderTyping"] as? Bool ?? false
                                    
                                    
                                    let messageData = MessageModel(senderId: senderId, receiverId: receiverId, content: content, timestamp: timestamp)
                                    if conversationId.contains(conversationPath) {
                                        messages.append(messageData)
                                    }
                                }
                            }
                        }
                    }
                    messages.sort { $0.timestamp < $1.timestamp }
                    
                    completion(messages)
                }
            })
        }
    }
    
    //  MARK:  Fetch Last Conversations
    func fetchLastConversation(completion: @escaping (LastMessageModel) -> Void) {
        var messages: [LastMessageModel] = []
        
        if let currentUserId = Auth.auth().currentUser?.uid {
            
            // Use observeSingleEvent instead of observe
            databaseRef.observe(.value, with: { snapshot in
                guard snapshot.exists() else {
                    messages.removeAll()
                    completion(LastMessageModel(id: "", senderId: "", receiverId: "", content: "", timestamp: 0.0))
                    return
                }
                
                if let conversations = snapshot.value as? [String: Any] {
                    for (conversationId, conversationData) in conversations {
                        if let messagesData = (conversationData as? [String: Any])?["messages"] as? [String: Any] {
                            for (_, messageData) in messagesData {
                                if let message = messageData as? [String: Any] {
                                    let content = message["content"] as? String ?? ""
                                    let receiverId = message["receiverId"] as? String ?? ""
                                    let senderId = message["senderId"] as? String ?? ""
                                    let timestamp = message["timestamp"] as? TimeInterval ?? 0.0
                                    let senderTyping = message["isSenderTyping"] as? Bool ?? false
                                    let receiverTyping = message["isSenderTyping"] as? Bool ?? false
                                    
                                    let messageData = LastMessageModel(id: conversationId, senderId: senderId, receiverId: receiverId, content: content, timestamp: timestamp)
                                    messages.append(messageData)
                                    
                                }
                            }
                        }
                        messages.sort { $0.timestamp ?? 0.0 < $1.timestamp ?? 0.0 }
                        completion(messages.last!)
                        
                    }
                }
            })
        }
    }
    
    
    func typingGestureRecognize() {
        let databaseRef = Database.database().reference()
        
    }
}

//  MARK:  Structure For Message Sending
struct MessageModel {
    let senderId: String
    let receiverId: String
    let content: String
    let timestamp: TimeInterval
}

