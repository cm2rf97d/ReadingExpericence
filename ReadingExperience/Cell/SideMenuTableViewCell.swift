//
//  SideMenuTableViewCell.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/5/20.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell
{
    
    static let identifier = "SideMenuTableViewCell"
    
    let titleLabel: UILabel =
    {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(titleLabel)
        layouts()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layouts()
    {
        titleLabel.snp.makeConstraints
        { (make) in
            make.centerX.centerY.equalTo(self)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }
}
