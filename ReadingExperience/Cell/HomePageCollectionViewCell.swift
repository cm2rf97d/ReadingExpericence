//
//  HomePageCollectionViewCell.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/5/19.
//

import UIKit

class HomePageCollectionViewCell: UICollectionViewCell
{
    static let identifier = "HomePageCollectionViewCell"
    
    var bookImage: MyImageView =
    {
        let image = MyImageView()
        return image
    }()
    
    var bookTitle: UITextView =
    {
        let textView = UITextView()
        textView.isUserInteractionEnabled = false
        textView.font = UIFont.systemFont(ofSize: 10)
        textView.textAlignment = .left
        textView.textColor = .white
        textView.backgroundColor = .gray
        return textView
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        addSubview(bookImage)
        addSubview(bookTitle)
        layouts()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layouts()
    {
        bookImage.snp.makeConstraints
        { (make) in
            make.width.equalTo(90)
            make.height.equalTo(90)
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(10)
        }
        
        bookTitle.snp.makeConstraints
        { (make) in
            make.width.equalTo(90)
            make.height.equalTo(100)
            make.centerX.equalTo(self)
            make.top.equalTo(bookImage.snp.bottom)
        }
    }
}
