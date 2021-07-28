//
//  DiscriptionTableViewCell.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/5/30.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell
{
    static let identifier = "DiscriptionTableViewCell"
    
    let descriptionLabel: UILabel =
    {
        let label = UILabel()
        label.text = "內容簡介"
        label.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        label.textAlignment = .left
        return label
    }()
    
    var bookDescriptionLabel: UILabel =
    {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(bookDescriptionLabel)
        layouts()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layouts()
    {
        descriptionLabel.snp.makeConstraints
        { (make) in
            make.top.equalTo(self.contentView).offset(10)
            make.left.equalTo(self.contentView).offset(20)
            make.right.equalTo(self.contentView).offset(-20)
        }
        
        bookDescriptionLabel.snp.makeConstraints
        { (make) in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            make.bottom.equalTo(self.contentView).offset(-10)
            make.left.equalTo(self.contentView).offset(20)
            make.right.equalTo(self.contentView).offset(-20)
        }
    }
}
