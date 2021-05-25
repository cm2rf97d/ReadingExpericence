//
//  EnterNameViewController.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/5/12.
//

import UIKit

class RegisterNameViewController: UIViewController
{
    let registerNameView = RegisterView()
    var registerInfos: [String] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setTitleLabel()
        registerNameView.accountInfoTextField.delegate = self
        registerNameView.nextButtonAction = gotoEmailViewController
    }
    
    override func loadView()
    {
        self.view = registerNameView
    }
    
    func setTitleLabel()
    {
        registerNameView.titleLabel.text = "Enter Your Name"
        registerNameView.accountInfoTextField.placeholder = " Name"
    }
    
    func gotoEmailViewController()
    {
        let vc = RegisterEmailViewController()
        if let Name = registerNameView.accountInfoTextField.text
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
