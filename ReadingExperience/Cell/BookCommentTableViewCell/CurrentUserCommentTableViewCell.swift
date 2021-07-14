//
//  CurrentUserCommentTableViewCell.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/7/13.
//

import UIKit

class CurrentUserCommentTableViewCell: UITableViewCell
{
    static let identifier = "CurrentUserCommentTableViewCell"
    
    var editCommentButtonAction: (()->Void)?
    
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
    
    let editCommentButton: UIButton =
    {
        let button = UIButton()
        button.setTitle("編輯您的留言", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(evaluationView)
        contentView.addSubview(commentLabel)
        contentView.addSubview(editCommentButton)
        editCommentButton.addTarget(self, action: #selector(editComment), for: .touchUpInside)
        layouts()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func editComment()
    {
        editCommentButtonAction?()
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
            make.left.right.equalTo(self.contentView).offset(8)
        }
        
        editCommentButton.snp.makeConstraints
        { (make) in
            make.top.equalTo(commentLabel.snp.bottom).offset(10)
            make.width.equalTo(UIScreen.main.bounds.width * 0.5)
            make.centerX.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView).offset(-10)
        }
    }
}
