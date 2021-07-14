//
//  RegisterViewController.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/5/12.
//

import UIKit

class RegisterEmailViewController: UIViewController
{
    let registerEmailView = RegisterView()
    var registerInfos: [String] = []
    let emailPattern = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setTitleLabel()
        registerEmailView.accountInfoTextField.delegate = self
        registerEmailView.nextButtonAction = gotoNameViewController
    }
    
    override func loadView()
    {
        self.view = registerEmailView
    }
    
    func setTitleLabel()
    {
        registerEmailView.titleLabel.text = "Enter Your Email"
        registerEmailView.accountInfoTextField.placeholder = " Email"
    }
    
    func gotoNameViewController()
    {
        let vc = PasswordViewController()
        if let Name = registerEmailView.accountInfoTextField.text
        {
            let matcher = emailRegex(self.emailPattern)
            if Name != "" && matcher.match(input: Name)
            {
                if registerInfos.count < 2
                {
                    registerInfos.append(Name)
                }
                else
                {
                    registerInfos[1] = Name
                }
                vc.registerInfos = registerInfos
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else
            {
                presentAlert(alertText: "Email格式錯誤", mode: .cancelAlert)
            }
        }
    }
}


