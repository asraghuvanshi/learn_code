//
//  ConversationModel.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 08/01/2024.
//

import Foundation

struct ConversationModel: Codable {
    let content, receiverID, senderID: String?
    let timeStamp: Int?

    enum CodingKeys: String, CodingKey {
        case content
        case receiverID = "receiverId"
        case senderID = "senderId"
        case timeStamp
    }
}
