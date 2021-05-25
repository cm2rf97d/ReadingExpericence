//
//  UserData.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/5/19.
//

import Foundation

// MARK: - Welcome
struct UserData: Codable {
    let user: User
    let token: String
}

// MARK: - User
struct User: Codable {
    let id: Int
    let name, region: String
    let image: String?
    let point: Int?
    let email: String
    let emailVerifiedAt: String?
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, name, image, region, point, email
        case emailVerifiedAt = "email_verified_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

var userInfomation: UserData?
