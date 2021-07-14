//
//  APICaller.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/7/1.
//

import Foundation
import Alamofire

class APICaller
{
    static let shared = APICaller()
    
    init() {}
    
    struct Constants
    {
        static let baseAPIURL = "http://52.196.162.105/api/"
    }
    
    enum APIError: Error
    {
        case failedToGetData
    }
    
    enum CommonResult
    {
        case success, fail
    }
    
    func userLogin(url: String, headersTitle: String, headersContent: String, parameters: [String: String], completion: @escaping (Result<UserData, Error>)  -> Void)
    {
        let headers: HTTPHeaders = [headersTitle: headersContent]
        let completeUrl = "\(Constants.baseAPIURL)\(url)"
        
        AF.request(completeUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).response
        { response in
            
            switch(response.result)
            {
                case .success:
                    do
                    {
                        if let profileData = response.data
                        {
                            let decoder = JSONDecoder()
                            let profileData = try decoder.decode(UserData.self, from: profileData)
                            completion(.success(profileData))
                        }
                    }
                    catch
                    {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func userLogOut(url: String, headersTitle: String, headersContent: String, completion: @escaping (CommonResult) -> Void)
    {
        let headers: HTTPHeaders = [headersTitle: headersContent]
        let completeUrl = "\(Constants.baseAPIURL)\(url)"
        AF.request(completeUrl, method: .post, encoding: JSONEncoding.default, headers: headers).response
        { response in
            switch(response.result)
            {
                case .success:
                    completion(.success)
                case .failure(_):
                    completion(.fail)
            }
        }
    }
    
    func getProfileData(url: String, headersTitle: String, headersContent: String, completion: @escaping(Result<ProfileUserData, Error>) -> Void )
    {
        let headers: HTTPHeaders = [headersTitle: headersContent]
        let completeUrl = "\(Constants.baseAPIURL)\(url)"
        AF.request(completeUrl, headers: headers).response{ response in
            switch(response.result)
            {
                case .success:
                    do
                    {
                        if let profileData = response.data
                        {
                            let decoder = JSONDecoder()
                            var profileData = try decoder.decode(ProfileUserData.self, from: profileData)
                            profileData.user.comments.sort
                            { data1, data2 in
                                data1.bookID < data2.bookID
                            }
                            completion(.success(profileData))
                        }
                    }
                    catch
                    {
                        print(error)
                    }
                case .failure(_):
                    break
            }
        }
    }
    
    func getAllBook(url: String, completion: @escaping (Result<[BookListData], Error>) -> Void)
    {
        let completeUrl = "\(Constants.baseAPIURL)\(url)"
        AF.request(completeUrl).response{ response in
            switch(response.result)
            {
                case .success:
                    do
                    {
                        if let bookData = response.data
                        {
                            let decoder = JSONDecoder()
                            var bookData = try decoder.decode([BookListData].self, from: bookData)
                            bookData.sort
                            { data1, data2 in
                                data1.id < data2.id
                            }
                            completion(.success(bookData))
                        }
                    }
                    catch
                    {
                        print(error)
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func getBookDetailData(url: String, completion: @escaping(Result<BookDetailData, Error>) -> Void)
    {
        let completeUrl = "\(Constants.baseAPIURL)\(url)"
        AF.request(completeUrl).response { response in
            switch(response.result)
            {
                case .success:
                    do
                    {
                        if let bookDetailData = response.data
                        {
                            let decoder = JSONDecoder()
                            let bookDetailData = try decoder.decode(BookDetailData.self, from: bookDetailData)
                            completion(.success(bookDetailData))
                        }
                    }
                    catch
                    {
                        print(error)
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func searchBook(url: String, completion: @escaping(Result<[BookListData], Error>) -> Void )
    {
        let completeUrl = "\(Constants.baseAPIURL)\(url)"
        AF.request(completeUrl).response{ response in
            switch(response.result)
            {
                case .success:
                    do
                    {
                        if let bookData = response.data
                        {
                            let decoder = JSONDecoder()
                            var bookData = try decoder.decode([BookListData].self, from: bookData)
                            bookData.sort
                            {(data1, data2) -> Bool in
                                return data1.id < data2.id
                            }
                            completion(.success(bookData))
                        }
                    }
                    catch
                    {
                        completion(.failure(error))
                    }
                case .failure(_):
                    break
            }
        }
    }
    
    func sendBookComment(url: String, method: HTTPMethod, headers: HTTPHeaders, parameters: [String: Any], completion: @escaping (Result<SendCommentResult, sendCommentError>) -> Void )
    {
        let completeUrl = "\(Constants.baseAPIURL)\(url)"
        print(completeUrl)
        AF.request(completeUrl, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).response
        { (response) in
            
            let statusCode = response.response?.statusCode

            switch(response.result)
            {
                case .success:
                    if let statusCode = statusCode
                    {
                        print(statusCode)
                        switch statusCode
                        {
                            case 200..<300:
                                do
                                {
                                    if let sendCommentResult = response.data
                                    {
                                        let decoder = JSONDecoder()
                                        let test = try decoder.decode(SendCommentResult.self, from: sendCommentResult)
                                        completion(.success(test))
                                    }
                                }
                                catch
                                {
                                    completion(.failure(.alreadyComment("")))
                                }
                            case 400:
                                completion(.failure(.alreadyComment("已留言過此書籍！")))
                            case 422:
                                do
                                {
                                    if let sendCommentResult = response.data
                                    {
                                        
                                        let decoder = JSONDecoder()
                                        let error = try decoder.decode(CommonError.self, from: sendCommentResult)
                                        if error.errors.rate?[0] == "The rate must be between 1 and 5."
                                        {
                                            completion(.failure(.commentError("評分範圍為 1~5 顆星哦！")))
                                        }
                                        else
                                        {
                                            completion(.failure(.alreadyComment("gggg")))
                                        }
                                        
                                    }
                                }
                                catch
                                {
                                    print(error)
                                    completion(.failure(.alreadyComment("評分範圍為 1~5 顆星哦！")))
                                }
                            default:
                                break
                        }
                    }
                case .failure:
                    break
            }
        }
    }
    
    func deleteBookComment(url: String, method: HTTPMethod, headers: HTTPHeaders, completion: @escaping (CommonResult) -> Void )
    {
        let completeUrl = "\(Constants.baseAPIURL)\(url)"
        print(completeUrl)
        AF.request(completeUrl, method: method, encoding: JSONEncoding.default, headers: headers).response
        { (response) in
            
            let statusCode = response.response?.statusCode

            switch(response.result)
            {
                case .success:
                    if let statusCode = statusCode
                    {
                        print(statusCode)
                        switch statusCode
                        {
                            case 200..<300:
                            if let sendCommentResult = response.data
                            {
//                                let test = String(data: sendCommentResult, encoding: .utf8)
                                completion(.success)
                            }
                            default:
                                break
                        }
                    }
                case .failure:
                    break
            }
        }
    }
}

enum sendCommentError: Error
{
    case alreadyComment(String)
    case commentError(String)
//    case missingParam(String)
//    case responseFailure(code: Int, message: Data)
}
