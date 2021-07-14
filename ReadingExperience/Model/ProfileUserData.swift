//
//  ProfileUserData.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/6/8.
//

import Foundation

// MARK: - Welcome
struct ProfileUserData: Codable
{
    var user: ProfileUser
    let countOfComments: Int
}

// MARK: - User
struct ProfileUser: Codable
{
    let id: Int
    let name: String
    let image: String?
    let region: String
    let point: Int
    let email: String
    let emailVerifiedAt: String?
    let createdAt, updatedAt: String
    var comments: [UserComment]

    enum CodingKeys: String, CodingKey
    {
        case id, name, image, region, point, email
        case emailVerifiedAt = "email_verified_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case comments
    }
}

// MARK: - Comment
struct UserComment: Codable
{
    let id, userID, bookID: Int
    let rate: Float
    let comment, createdAt, updatedAt: String
    let book: Book

    enum CodingKeys: String, CodingKey
    {
        case id, userID, bookID, rate, comment
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case book
    }
}

// MARK: - Book
struct Book: Codable
{
    let id: Int
    let isbn, bookname, author, bookDescription: String
    let category, publisher, publishDate: String
    let image: String
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey
    {
        case id, isbn, bookname, author
        case bookDescription = "description"
        case category, publisher
        case publishDate = "publish_date"
        case image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

