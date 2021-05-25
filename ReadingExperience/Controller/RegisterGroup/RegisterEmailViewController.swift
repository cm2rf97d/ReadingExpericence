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
            if Name != ""
            {
                registerInfos.append(Name)
                vc.registerInfos = registerInfos
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else
            {
                print("GG")
            }
        }
    }
}


