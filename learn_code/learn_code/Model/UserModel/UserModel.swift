//
//  UserModel.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 29/12/2023.
//

import Foundation

// MARK: - UserModel
struct UserModel: Codable {
    let users: [String: UserResponse]?
}

// MARK: - UserResponse
struct UserResponse: Codable {
    var userId: String?
    let fullName, userEmail, userMobile: String?
    let profileImageURL: String?
   
    enum CodingKeys: String, CodingKey {
        case fullName
        case profileImageURL = "profileImageUrl"
        case userEmail, userMobile
    }
}
