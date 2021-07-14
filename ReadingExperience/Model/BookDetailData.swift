//
//  BookDetailData.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/5/31.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - BookDetailData
struct BookDetailData: Codable
{
    let book: BookDetail
    let avgRate: Float?

    enum CodingKeys: String, CodingKey
    {
        case book
        case avgRate = "avg_rate"
    }
}

// MARK: - Book
struct BookDetail: Codable
{
    let id: Int
    let isbn, bookname, author, bookDescription: String
    let category, publisher, publishDate: String
    let image: String
    let createdAt, updatedAt: String
    let comments: [Comment]

    enum CodingKeys: String, CodingKey
    {
        case id, isbn, bookname, author
        case bookDescription = "description"
        case category, publisher
        case publishDate = "publish_date"
        case image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case comments
    }
}

// MARK: - Comment
struct Comment: Codable
{
    let id, userID, bookID: Int
    let rate: Double
    let comment, createdAt, updatedAt: String?
    let user: User1

    enum CodingKeys: String, CodingKey
    {
        case id, userID, bookID, rate, comment
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case user
    }
}

// MARK: - User
struct User1: Codable
{
    let id: Int
    let name: String
    let image: String?
    let region: String
    let point: Int
    let email: String
    let emailVerifiedAt: String?
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey
    {
        case id, name, image, region, point, email
        case emailVerifiedAt = "email_verified_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}



struct CommentFail: Codable
{
    let message: String
    let errors: CommentErrors
}

// MARK: - Errors
struct CommentErrors: Codable
{
    let rate: [String]
}

struct test123: Codable
{
    var rate: [String: String]
}

