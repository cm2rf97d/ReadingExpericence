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
    
    var backView: UIView =
    {
        let uiView = UIView()
        return uiView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setBackView()
        addSubview(titleLabel)
        layouts()
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool)
    {
        super.setHighlighted(highlighted, animated: animated)
        backView.backgroundColor = highlighted ? UIColor(white: 1.0, alpha: 0.6) : UIColor(white: 0.0, alpha: 0.2)
        titleLabel.textColor = highlighted ? .black : .white
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBackView()
    {
        self.backgroundColor = UIColor(white: 0.0, alpha: 0.2)
        self.selectedBackgroundView = backView
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
