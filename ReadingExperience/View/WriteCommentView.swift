//
//  WriteCommentView.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/6/2.
//

import UIKit

class WriteCommentView: UIView
{
    var sendCommentButtonAction: (() -> Void)?
    
    let commentLabel: UILabel =
    {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "評分等級"
        return label
    }()
    
    let commentEvaluationView: JNStarRateView =
    {
        let view = JNStarRateView.init(frame: CGRect(x: 0, y: 0, width: 200, height: 38), numberOfStars: 5, currentStarCount: 0)
        view.userPanEnabled = true
        view.integerStar = false
        return view
    }()
    
    let commentTextView: UITextView =
    {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 15)
        return textView
    }()
    
    let sendCommentButton: UIButton =
    {
        let button = UIButton()
        button.setTitle("送出", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.6624272145, green: 0.8989033602, blue: 0.3216509138, alpha: 1)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(sendComment), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.backgroundColor = registerColor
        addSubview(commentLabel)
        addSubview(commentTextView)
        addSubview(sendCommentButton)
        addSubview(commentEvaluationView)
        layouts()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func sendComment()
    {
        sendCommentButtonAction?()
    }
    
    func layouts()
    {
        commentLabel.snp.makeConstraints
        { (make) in
            make.centerX.equalTo(self)
            make.topMargin.equalTo(self).offset(50)
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
        
        commentEvaluationView.snp.makeConstraints
        { (make) in
            make.centerX.equalTo(self)
            make.topMargin.equalTo(commentLabel.snp.bottom).offset(100)
            make.width.equalTo(200)
            make.height.equalTo(38)
        }
        
        commentTextView.snp.makeConstraints
        { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(commentEvaluationView.snp.bottom).offset(50)
            make.width.equalTo(UIScreen.main.bounds.width * 0.7)
            make.height.equalTo(100)
        }
        
        sendCommentButton.snp.makeConstraints
        { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(commentTextView.snp.bottom).offset(50)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
    }
}
