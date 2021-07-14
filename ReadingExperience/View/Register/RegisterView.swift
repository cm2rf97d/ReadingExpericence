//
//  RegisterView.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/5/12.
//

import UIKit

class RegisterView: UIView
{
    var nextButtonAction: (() -> Void)?
    
    var titleLabel: UILabel =
    {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .gray
        return label
    }()
    
    let accountInfoTextField: UITextField =
    {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        textField.keyboardType = .emailAddress
        textField.placeholder = ""
        return textField
    }()
    
    let nextButton: UIButton =
    {
        let button = UIButton()
        button.setTitle("Next →", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        button.layer.cornerRadius = 10.0
        button.clipsToBounds = true
        button.setBackgroundColor(color: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), forState: UIControl.State.highlighted)
        button.addTarget(self, action: #selector(nextAccount), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.backgroundColor = registerColor
        addSubview(titleLabel)
        addSubview(accountInfoTextField)
        addSubview(nextButton)
        layouts()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func nextAccount()
    {
        nextButtonAction?()
    }

    func layouts()
    {
        titleLabel.snp.makeConstraints
        { (make) in
            make.height.equalTo(35)
            make.width.equalTo(UIScreen.main.bounds.width)
            make.centerX.equalTo(self)
            make.top.equalTo(200)
        }
        
        accountInfoTextField.snp.makeConstraints
        { (make) in
            make.height.equalTo(40)
            make.width.equalTo(UIScreen.main.bounds.width * 0.7)
            make.centerX.equalTo(self)
            make.top.equalTo(350)
        }
        
        nextButton.snp.makeConstraints
        { (make) in
            make.height.equalTo(40)
            make.width.equalTo(UIScreen.main.bounds.width * 0.7)
            make.centerX.equalTo(self)
            make.bottom.equalTo(-200)
        }
    }
}
