//
//  AuthorTableViewCell.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/6/9.
//

import UIKit

class AuthorTableViewCell: UITableViewCell
{
    static let identifier =  "AuthorTableViewCell"
    
    let authorLabel: UILabel =
    {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    let publisherLabel: UILabel =
    {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    let publishDateLabel: UILabel =
    {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(authorLabel)
        contentView.addSubview(publisherLabel)
        contentView.addSubview(publishDateLabel)
        layouts()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layouts()
    {
        authorLabel.snp.makeConstraints
        { (make) in
            make.top.equalTo(self.contentView).offset(5)
            make.left.equalTo(self.contentView).offset(20)
            make.right.equalTo(self.contentView).offset(-20)
        }
        
        publisherLabel.snp.makeConstraints
        { (make) in
            make.top.equalTo(authorLabel.snp_bottomMargin).offset(10)
            make.left.equalTo(self.contentView).offset(20)
            make.right.equalTo(self.contentView).offset(-20)
        }
        
        publishDateLabel.snp.makeConstraints
        { (make) in
            make.top.equalTo(publisherLabel.snp_bottomMargin).offset(10)
            make.bottom.equalTo(self.contentView).offset(-10)
            make.left.equalTo(self.contentView).offset(20)
            make.right.equalTo(self.contentView).offset(-20)
        }
    }
}
