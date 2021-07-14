//
//  EvaluationTableViewCell.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/6/1.
//

import UIKit

class EvaluationTableViewCell: UITableViewCell
{
    static let identifier = "EvaluationTableViewCell"
    var evaluationButtonAction: (() -> Void)?
    
    let evaluationView: JNStarRateView =
    {
        let view = JNStarRateView.init(frame: CGRect(x: 0, y: 0, width: 105, height: 20), numberOfStars: 5, currentStarCount: 0)
        view.isUserInteractionEnabled = false
        view.userPanEnabled = true
        view.integerStar = false
        return view
    }()
    
    let evaluationLabel: UILabel =
    {
        let label = UILabel()
        label.text = "0分，共0位評分  |"
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    let evaluationButton: UIButton =
    {
        let button = UIButton()
        button.setTitle(" 我要評分", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }()
    
    lazy var evaluationStackView: UIStackView =
    {
        let stackView = UIStackView(arrangedSubviews: [evaluationLabel, evaluationButton])
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        evaluationButton.addTarget(self, action: #selector(writeComments), for: .touchUpInside)
        contentView.addSubview(evaluationView)
        contentView.addSubview(evaluationStackView)
        layouts()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func writeComments()
    {
        evaluationButtonAction?()
    }
    
    func layouts()
    {
        evaluationView.snp.makeConstraints
        { (make) in
            make.left.equalTo(self.contentView).offset(20)
            make.top.equalTo(self.contentView).offset(5)
            make.width.equalTo(105)
            make.bottom.equalTo(self.contentView)
        }
        
        evaluationStackView.snp.makeConstraints
        { (make) in
            make.left.equalTo(evaluationView.snp.right).offset(15)
            make.top.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView).offset(-5)
        }
    }
}
