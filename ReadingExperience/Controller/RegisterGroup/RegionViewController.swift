//
//  PhoneNumberViewController.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/5/12.
//

import UIKit

class RegionViewController: UIViewController
{
    let regionView = LastRegisterView()
    var areaButtons: [UIButton]?
    var registerInfos: [String] = []
    var registerParameter = ""
    var loginParameter = ""
    let registerUrl = "http://52.196.162.105/api/register"
    let loginUrl = "http://52.196.162.105/api/login"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setTitleLabel()
        regionView.selectButtonAction = showAreaButton
        regionView.nextButtonAction = uploadUserInfomation
        setAreaButtons()
    }
    
    override func loadView()
    {
        self.view = regionView
    }
    
    func setTitleLabel()
    {
        regionView.titleLabel.text = "Enter Your Region"
        regionView.nextButton.setTitle("Register", for: .normal)
    }
    
    func setAreaButtons()
    {
        self.areaButtons = [regionView.northButton,
                            regionView.eastButton,
                            regionView.southButton,
                            regionView.westButton]
    }
    
    func uploadUserInfomation()
    {
        userRegister()
    }
    
    // MARK: Function Area
    func setRegisterParameter() -> [String: String]
    {
        let registerParameters =
        [
            "name": registerInfos[0],
            "email": registerInfos[1],
            "password": registerInfos[2],
            "password_confirmation": registerInfos[3],
            "region": registerInfos[4]
        ]
        return registerParameters
    }
    
    func userRegister()
    {
        let registerParameters = setRegisterParameter()
        APICaller.shared.userRegister(url: "register", headersTitle: "Accept", headersContent: "application/json", parameters: registerParameters)
        { result in
            switch result
            {
            case .success(let data):
                self.presentAlert(alertText: "註冊成功", mode: .cancelAlertAndPopToRootView)
                userInformation = data
                self.userLogin()
            case .failure(.emailAlreadyRegister(_)): break
            case .failure(.emailInvaild(_)): break
            }
        }
    }
    
    func setLoginParameter() -> [String: String]
    {
        let parameters =
        [
            "email": registerInfos[1],
            "password": registerInfos[2]
        ]
        return parameters
    }
    
    private func userLogin()
    {
        let loginParameters = setLoginParameter()
        APICaller.shared.userLogin(url: "login", headersTitle: "Accpet", headersContent: "application/json", parameters: loginParameters)
        { result in
            switch result
            {
            case .success(let data): userInformation = data
            case .failure(_): break
            }
        }
    }
    
    func showAreaButton()
    {
        if let areaButtons = self.areaButtons
        {
            for button in areaButtons
            {
                self.view.layoutIfNeeded()
                UIView.animate(withDuration: 10.0, delay: 10.0, options: [.repeat, .autoreverse], animations:{
                    button.isHidden = !button.isHidden
                    self.view.layoutIfNeeded()
                })
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func test(sender: UIButton)
    {
        if let button = self.areaButtons
        {
            switch sender
            {
                case regionView.northButton:
                    fallthrough
                case regionView.eastButton:
                    fallthrough
                case regionView.southButton:
                    fallthrough
                case regionView.westButton:
                    regionView.selectButton.setTitle(button[sender.tag].currentTitle, for: .normal)
                    if let area = button[sender.tag].currentTitle
                    {
                        setRegisterArea(area: area)
                    }
                default:
                    print("123")
            }
            showAreaButton()
        }
    }
    
    func setRegisterArea(area: String)
    {
        if self.registerInfos.count < 5
        {
            self.registerInfos.append(area)
        }
        else
        {
            self.registerInfos[4] = area
        }
    }
}
