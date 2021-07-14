//
//  SignInViewController.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/5/26.
//

import UIKit
import Alamofire

protocol transferDataToSideMenuDelegate
{
    func transferDataToSideMenu(data: UserData)
}

class SignInViewController: UIViewController
{
    let signInView = SignInView()
    var transferDataToSideMenuDelegate: transferDataToSideMenuDelegate?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        signInView.singInButtonAction = userLogin
    }
    
    override func loadView()
    {
        self.view = signInView
    }
    
    func userLogin()
    {
        let signInParameter = setParameter()
        APICaller.shared.userLogin(url: "login",headersTitle: "Accept",headersContent: "application/json",parameters: signInParameter)
        { result in
            switch result
            {
                case .success(let data):
                    userInformation = data
                    self.presentAlert(alertText: "登入成功", mode: .cancelAlertAndPopToRootView)
                case .failure(_):
                    self.presentAlert(alertText: "帳號或密碼錯誤", mode: .cancelAlert)
            }
        }
    }
    
    func setParameter() -> [String: String]
    {
        var signInParameter: [String: String] = [:]
        
        if signInView.emailTextField.text != "",
           signInView.passwordTextField.text != ""
        {
            if let userEmail = signInView.emailTextField.text,
               let userPassword = signInView.passwordTextField.text
            {
                signInParameter =
                [
                    "email": userEmail,
                    "password": userPassword
                ]
            }
        }
        return signInParameter
    }
}
