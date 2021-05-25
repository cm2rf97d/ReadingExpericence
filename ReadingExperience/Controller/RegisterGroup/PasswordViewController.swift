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
    {
        didSet
        {
            print("asdf = \(self.registerInfos)")
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setTitleLabel()
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
        if let Name = passwordView.accountInfoTextField.text
        {
            if Name != ""
            {
                registerInfos.append(Name)
                vc.registerInfos = registerInfos
                vc.confirmPassword = Name
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else
            {
                print("GG")
            }
        }
    }
}
