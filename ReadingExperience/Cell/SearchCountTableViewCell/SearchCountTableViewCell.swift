//
//  SearchCountTableViewCell.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/6/30.
//

import UIKit

class SearchCountTableViewCell: UITableViewCell
{
    static let identifier = "SearchCountTableViewCell"
    
    var searchResultCountLabel: UILabel =
    {
        let label = UILabel()
        label.isHidden = true
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(searchResultCountLabel)
        layouts()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layouts()
    {
        searchResultCountLabel.snp.makeConstraints
        { (make) in
            make.topMargin.right.bottom.equalTo(self.contentView)
            make.left.equalTo(self.contentView).offset(20)
        }
    }
}
