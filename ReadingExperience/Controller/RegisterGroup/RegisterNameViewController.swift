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
                if registerInfos.count < 1
                {
                    registerInfos.append(Name)
                }
                else
                {
                    registerInfos[0] = Name
                }
                vc.registerInfos = registerInfos
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else
            {
                presentAlert(alertText: "名稱欄位不可為空白", mode: .cancelAlert)
            }
        }
    }
}
