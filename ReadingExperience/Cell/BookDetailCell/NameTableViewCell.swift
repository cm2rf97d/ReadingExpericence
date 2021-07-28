//
//  NameTableViewCell.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/5/30.
//

import UIKit

class NameTableViewCell: UITableViewCell
{
    static let identifier = "NameTableViewCell"
    
    let nameLabel: UILabel =
    {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 19)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        contentView.addSubview(nameLabel)
        layouts()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layouts()
    {
        nameLabel.snp.makeConstraints
        { (make) in
            make.top.equalTo(self.contentView).offset(5)
            make.left.equalTo(self.contentView).offset(20)
            make.right.equalTo(self.contentView).offset(-20)
            make.bottom.equalTo(self.contentView).offset(-20)
        }
    }
}
