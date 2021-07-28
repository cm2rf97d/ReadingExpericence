//
//  SignInView.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/5/26.
//

import UIKit

class SignInView: UIView
{
    var singInButtonAction: (() -> Void)?
    
    let titleLabel: UILabel =
    {
        let label = UILabel()
        label.text = "登入"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 40)
        return label
    }()
    
    let emailLabel: UILabel =
    {
        let label = UILabel()
        label.text = "信箱:"
        label.textAlignment = .center
        return label
    }()
    
    let passwordLabel: UILabel =
    {
        let label = UILabel()
        label.text = "密碼:"
        label.textAlignment = .center
        return label
    }()
    
    let emailTextField: UITextField =
    {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        textField.keyboardType = .emailAddress
        textField.placeholder = " Enter Your Email"
        textField.textColor = .black
        return textField
    }()
    
    let passwordTextField: UITextField =
    {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        textField.keyboardType = .emailAddress
        textField.isSecureTextEntry = true
        textField.placeholder = " Enter Your Password"
        return textField
    }()
    
    let signInButton: UIButton =
    {
        let button = UIButton()
        button.setTitle("登入", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        button.layer.cornerRadius = 10.0
        button.clipsToBounds = true
        button.setBackgroundColor(color: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), forState: UIControl.State.highlighted)
        button.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.backgroundColor = registerColor
        addSubview(titleLabel)
        addSubview(emailLabel)
        addSubview(passwordLabel)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(signInButton)
        layouts()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func signIn()
    {
        singInButtonAction?()
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
        
        emailLabel.snp.makeConstraints
        { (make) in
            make.height.equalTo(40)
            make.width.equalTo(50)
            make.left.equalTo(40)
            make.top.equalTo(430)
        }
        
        passwordLabel.snp.makeConstraints
        { (make) in
            make.height.equalTo(40)
            make.width.equalTo(50)
            make.left.equalTo(40)
            make.top.equalTo(500)
        }
        
        emailTextField.snp.makeConstraints
        { (make) in
            make.height.equalTo(40)
            make.width.equalTo(UIScreen.main.bounds.width * 0.6)
            make.centerX.equalTo(self).offset(15)
            make.top.equalTo(430)
        }
        
        passwordTextField.snp.makeConstraints
        { (make) in
            make.height.equalTo(40)
            make.width.equalTo(UIScreen.main.bounds.width * 0.6)
            make.centerX.equalTo(self).offset(15)
            make.top.equalTo(500)
        }
        
        signInButton.snp.makeConstraints
        { (make) in
            make.height.equalTo(40)
            make.width.equalTo(100)
            make.centerX.equalTo(self)
            make.top.equalTo(600)
        }
    }
}
