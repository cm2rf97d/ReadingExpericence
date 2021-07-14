//
//  PasswordViewController.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/5/17.
//

import UIKit

class PasswordViewController: UIViewController
{
    let passwordView = RegisterView()
    var registerInfos: [String] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setTitleLabel()
        passwordView.accountInfoTextField.isSecureTextEntry = true
        passwordView.accountInfoTextField.delegate = self
        passwordView.nextButtonAction = gotoConfirmPasswordViewController
    }
    
    override func loadView()
    {
        self.view = passwordView
    }
    
    func setTitleLabel()
    {
        passwordView.titleLabel.text = "Enter Your Password"
        passwordView.accountInfoTextField.placeholder = " Password"
    }
    
    func gotoConfirmPasswordViewController()
    {
        let vc = ConfirmPasswordViewController()
        
        if let name = passwordView.accountInfoTextField.text
        {
            if name != "" && name.count >= 8
            {
                if registerInfos.count < 3
                {
                    registerInfos.append(name)
                }
                else
                {
                    registerInfos[2] = name
                }
                vc.registerInfos = registerInfos
                vc.confirmPassword = name
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else
            {
                if name == ""
                {
                    presentAlert(alertText: "欄位不可為空白", mode: .cancelAlert)
                }
                else if name.count < 8
                {
                    presentAlert(alertText: "密碼長度最少需為8碼", mode: .cancelAlert)
                }
            }
        }        
    }
}
