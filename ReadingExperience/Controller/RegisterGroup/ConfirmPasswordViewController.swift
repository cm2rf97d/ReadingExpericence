//
//  ConfirmPasswordViewController.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/5/17.
//

import UIKit

class ConfirmPasswordViewController: UIViewController
{
    let confirmPasswordView = RegisterView()
    var registerInfos: [String] = []
    var confirmPassword: String = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setTitleLabel()
        confirmPasswordView.accountInfoTextField.isSecureTextEntry = true
        confirmPasswordView.accountInfoTextField.delegate = self
        confirmPasswordView.nextButtonAction = gotoRegionViewController
    }

    override func loadView()
    {
        self.view = confirmPasswordView
    }
    
    func setTitleLabel()
    {
        confirmPasswordView.titleLabel.text = "Confirm Your Password"
        confirmPasswordView.accountInfoTextField.placeholder = " Confirm Your Password"
    }
    
    func gotoRegionViewController()
    {
        let vc = RegionViewController()
        
        if let Name = confirmPasswordView.accountInfoTextField.text
        {
            if Name != ""
            {
                if confirmPassword == Name
                {
                    if registerInfos.count < 4
                    {
                        registerInfos.append(Name)
                    }
                    else
                    {
                        registerInfos[3] = Name
                    }
                    vc.registerInfos = registerInfos
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                else
                {
                    presentAlert(alertText: "與第一次密碼不符", mode: .cancelAlert)
                }
            }
            else
            {
                presentAlert(alertText: "欄位不可為空白", mode: .cancelAlert)
            }
        }
    }
}
