//
//  HomeView.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/5/12.
//

import UIKit
import SnapKit

class RegisterMainView: UIView
{
    var registerButtonAction: (() -> Void)?
    var signInButtonAction: (() -> Void)?

    let titleLabel: UILabel =
    {
        let label = UILabel()
        label.text = "Owl Reading Experience"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = .lightGray
        return label
    }()
    
    let registerButton: UIButton =
    {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        button.layer.cornerRadius = 10.0
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(registerAccount), for: .touchUpInside)
        return button
    }()
    
    let signInButton: UIButton =
    {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        button.layer.cornerRadius = 10.0
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(signInAccount), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        addSubview(titleLabel)
        addSubview(registerButton)
        addSubview(signInButton)
        layouts()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func registerAccount()
    {
        registerButtonAction?()
    }
    
    @objc private func signInAccount()
    {
        signInButtonAction?()
    }
    
    func layouts()
    {
        titleLabel.snp.makeConstraints
        { (make) in
            make.width.equalTo(300)
            make.height.equalTo(30)
            make.centerX.equalTo(self)
            make.top.equalTo(300)
        }
        
        registerButton.snp.makeConstraints
        { (make) in
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.centerX.equalTo(self)
            make.bottom.equalTo(-250)
        }
        
        signInButton.snp.makeConstraints
        { (make) in
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.centerX.equalTo(self)
            make.bottom.equalTo(-200)
        }
    }
}
