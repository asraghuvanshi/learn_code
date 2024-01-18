//
//  ChatMessageModel.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 10/01/2024.
//

import Foundation


// MARK: - ChatMessageModel
struct ChatMessageModel: Codable {
    let messages: [String: MessageResponse]?
    let users: [String: User]?
}

// MARK: - Message
struct MessageResponse: Codable {
    let receiverID, senderID, text: String?
    let timestamp: Int?

    enum CodingKeys: String, CodingKey {
        case receiverID = "receiverId"
        case senderID = "senderId"
        case text, timestamp
    }
}

// MARK: - User
struct User: Codable {
    let fullName: String?
    let profileImageURL: String?
    let userEmail, userMobile: String?

    enum CodingKeys: String, CodingKey {
        case fullName
        case profileImageURL = "profileImageUrl"
        case userEmail, userMobile
    }
}
