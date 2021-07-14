//
//  HomePageCollectionViewCell.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/5/19.
//

import UIKit

class BookListCollectionViewCell: UICollectionViewCell
{
    static let identifier = "HomePageCollectionViewCell"
    
    var bookImage: MyImageView =
    {
        let image = MyImageView()
        image.layer.shadowOffset = CGSize(width: 2, height: 2)
        image.layer.shadowOpacity = 0.3
        image.layer.shadowRadius = 3
        image.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return image
    }()
    
    var bookTitle: UILabel =
    {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .left
        label.textColor = .black
        label.backgroundColor = #colorLiteral(red: 0.8266435266, green: 0.8522949219, blue: 0.8210268617, alpha: 1)
        label.numberOfLines = 2
        return label
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
            make.width.equalTo(110)
            make.height.equalTo(115)
            make.left.equalTo(self).offset(5)
            make.top.equalTo(self).offset(10)
//            make.bottom.equalTo(bookTitle.snp.top)
        }
        
        bookTitle.snp.makeConstraints
        { (make) in
            make.width.equalTo(110)
            make.left.equalTo(self).offset(5)
            make.top.equalTo(bookImage.snp.bottom).offset(5)
            make.bottom.equalTo(self.snp.bottom).offset(-5)
        }
    }
}
