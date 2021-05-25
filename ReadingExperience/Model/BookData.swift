//
//  BookData.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/5/20.
//

import Foundation
import UIKit

// MARK: - WelcomeElement
struct BookData: Codable
{
    let id: Int
    let isbn, bookname, author: String
    let welcomeDescription: String?
    let category, publisher, publishDate, image: String
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey
    {
        case id, isbn, bookname, author
        case welcomeDescription = "description"
        case category, publisher
        case publishDate = "publish_date"
        case image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

typealias Welcome = [BookData]

class MyImageView: UIImageView
{
    var url: URL?
    static var cache = NSCache<AnyObject, AnyObject>()
    
    func loadImage(url: URL)
    {
        self.url = url

        if let imaged = MyImageView.cache.object(forKey: self.url as AnyObject) as? UIImage
        {
            print("Cached Image")
            self.image = imaged
        }
        else
        {
            print("Send API")
            URLSession.shared.dataTask(with: url)
            {(data, responds, error) in
                if let error = error
                {
                    print(error)
                }
                else if let data = data
                {
                    if url == self.url, let image = UIImage(data: data)
                    {
                        MyImageView.cache.setObject(image, forKey: url as AnyObject)
                        DispatchQueue.main.async
                        {
                            self.image = image
                        }
                    }
                    else
                    {
                        print("123213")
                    }
                }
            }.resume()
        }
    }
}

