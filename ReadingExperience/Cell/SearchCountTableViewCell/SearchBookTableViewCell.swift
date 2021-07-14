//
//  SearchBookTableViewCell.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/6/3.
//

import UIKit

class SearchBookTableViewCell: UITableViewCell
{
    static let identifier = "SearchBookTableViewCell"
    
    var bookImage: MyImageView =
    {
        let image = MyImageView()
        return image
    }()
    
    var bookNameLabel: UILabel =
    {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 2
        return label
    }()
    
    var bookAuthorLabel: UILabel =
    {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    
    var bookDescriptionLabel: UILabel =
    {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.numberOfLines = 2
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(bookImage)
        addSubview(bookNameLabel)
        addSubview(bookAuthorLabel)
        addSubview(bookDescriptionLabel)
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
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(10)
            make.width.equalTo(130)
            make.height.equalTo(130)
        }

        bookNameLabel.snp.makeConstraints
        { (make) in
            make.left.equalTo(bookImage.snp.right)
            make.right.equalTo(self)
            make.top.equalTo(bookImage.snp.top).offset(5)
        }

        bookAuthorLabel.snp.makeConstraints
        { (make) in
            make.left.equalTo(bookNameLabel.snp.left)
            make.right.equalTo(self)
            make.top.equalTo(bookNameLabel.snp.bottom).offset(10)
            make.bottom.equalTo(bookDescriptionLabel.snp.top)
        }

        bookDescriptionLabel.snp.makeConstraints
        { (make) in
            make.top.equalTo(bookAuthorLabel.snp.bottom)
            make.left.equalTo(bookAuthorLabel.snp.left)
            make.right.bottom.equalTo(self)
        }
    }
}
