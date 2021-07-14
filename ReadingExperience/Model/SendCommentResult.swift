//
//  SendCommentResult.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/7/7.
//

import Foundation

// MARK: - Welcome
struct SendCommentResult: Codable
{
    let sendComment: SendComment?
}

// MARK: - Comment
struct SendComment: Codable
{
    let userID: Int
    let bookID, rate: String
    let comment: String?
    let updatedAt, createdAt: String
    let id: Int

    enum CodingKeys: String, CodingKey
    {
        case userID, bookID, rate, comment
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
    }
}
