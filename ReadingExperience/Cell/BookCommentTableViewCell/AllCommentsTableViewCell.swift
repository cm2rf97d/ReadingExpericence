//
//  AllCommentsTableViewCell.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/6/21.
//

import UIKit

class AllCommentsTableViewCell: UITableViewCell
{
    static let identifier = "AllCommentsTableViewCell"
    
    let userNameLabel: UILabel =
    {
        let label = UILabel()
        label.textColor = .systemBlue
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let timeLabel: UILabel =
    {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let evaluationView: JNStarRateView =
    {
        let view = JNStarRateView.init(frame: CGRect(x: 0, y: 0, width: 105, height: 20), numberOfStars: 5, currentStarCount: 0)
        view.isUserInteractionEnabled = false
        view.userPanEnabled = false
        view.integerStar = false
        return view
    }()
    
    let commentLabel: UILabel =
    {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(evaluationView)
        contentView.addSubview(commentLabel)
        layouts()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layouts()
    {
        userNameLabel.snp.makeConstraints
        { (make) in
            make.top.equalTo(self.contentView).offset(10)
            make.left.equalTo(self.contentView).offset(7)
        }
        
        timeLabel.snp.makeConstraints
        { (make) in
            make.top.equalTo(userNameLabel.snp.bottom)
            make.width.equalTo(85)
            make.right.equalTo(self.contentView).offset(-10)
        }
        
        evaluationView.snp.makeConstraints
        { (make) in
            make.top.equalTo(userNameLabel.snp.bottom)
            make.width.equalTo(105)
            make.height.equalTo(20)
            make.left.equalTo(userNameLabel.snp.left)
        }
        
        commentLabel.snp.makeConstraints
        { (make) in
            make.top.equalTo(evaluationView.snp.bottom).offset(15)
            make.bottom.equalTo(self.contentView).offset(-10)
            make.left.right.equalTo(self.contentView).offset(8)
        }
    }
}
