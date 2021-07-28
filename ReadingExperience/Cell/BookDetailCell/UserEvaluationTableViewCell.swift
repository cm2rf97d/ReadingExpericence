//
//  UserEvaluationTableViewCell.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/6/20.
//

import UIKit

class UserEvaluationTableViewCell: UITableViewCell
{
    static let identifier = "UserEvaluationTableViewCell"
    
    var seeMoreEvaluationButtonAction: (()->Void)?
    
    let descriptionLabel: UILabel =
    {
        let label = UILabel()
        label.text = " 會員評價"
        label.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        label.textAlignment = .left
        return label
    }()
    
    var userLabel: UILabel =
    {
        let label = UILabel()
        label.textColor = .systemBlue
        label.textAlignment = .left
        return label
    }()
    
    var evaluationLabel: UILabel =
    {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    let seeMoreEvaluationButton: UIButton =
    {
        let button = UIButton()
        button.setTitle("看更多", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        contentView.addSubview(userLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(evaluationLabel)
        contentView.addSubview(seeMoreEvaluationButton)
        seeMoreEvaluationButton.addTarget(self, action: #selector(seeMoreEvaluation), for: .touchUpInside)
        layouts()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func seeMoreEvaluation()
    {
        seeMoreEvaluationButtonAction?()
    }
    
    func layouts()
    {
        descriptionLabel.snp.makeConstraints
        { (make) in
            make.top.equalTo(self.contentView).offset(10)
            make.left.equalTo(self.contentView).offset(20)
            make.right.equalTo(self.contentView).offset(-20)
        }
        
        userLabel.snp.makeConstraints
        { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.left.equalTo(self.contentView).offset(20)
            make.right.equalTo(self.contentView).offset(-20)
        }
        
        evaluationLabel.snp.makeConstraints
        { (make) in
            make.top.equalTo(userLabel.snp.bottom).offset(10)
            make.left.equalTo(self.contentView).offset(20)
            make.right.equalTo(self.contentView).offset(-20)
        }
        
        seeMoreEvaluationButton.snp.makeConstraints
        { (make) in
            make.bottom.equalTo(self.contentView)
            make.width.equalTo(UIScreen.main.bounds.width * 0.9)
            make.top.equalTo(evaluationLabel.snp.bottom).offset(20)
            make.centerX.equalTo(self.contentView)
        }
    }
}
