//
//  RegisterError.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/6/16.
//

import Foundation

// MARK: - Welcome
struct CommonError: Codable
{
    let message: String
    var errors: Errors
}

// MARK: - Errors
struct Errors: Codable
{
    let email: [String]?
    var rate: [String]?
}
