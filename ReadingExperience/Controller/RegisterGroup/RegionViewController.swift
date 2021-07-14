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
        setRegisterParameter()
        print(self.registerParameter)
        userRegister(urlString: registerUrl, parameters: registerParameter, completion:
        { (data) in
            self.setLoginParameter()
            self.uploadLoginInfo(urlString: self.loginUrl, parameters: self.loginParameter)
            { (data) in
                
            }
        })
    }
    
    // MARK: Function Area
    func setRegisterParameter()
    {
        self.registerParameter = "name=\(registerInfos[0])&email=\(registerInfos[1])&password=\(registerInfos[2])&password_confirmation=\(registerInfos[3])&region=\(registerInfos[4])"
    }
    
    func userRegister(urlString: String, parameters: String, completion: @escaping (Data) -> Void) -> Void
    {
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        
        request.httpBody = parameters.data(using: String.Encoding.utf8)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        uploadRegisterInfo(from: request, completion: completion)
    }
    
    private func uploadRegisterInfo(from request: URLRequest, completion: @escaping (Data) -> Void)
    {
        let task = URLSession.shared.dataTask(with: request)
        { (data, response, error) in
            
            if error != nil
            {
                print(error as Any)
            }
            else if let response = response as? HTTPURLResponse, let data = data
            {
                print("dodo")
                let decoder = JSONDecoder()
                
                print("status Codeee = \(response.statusCode)")
                if response.statusCode == 201
                {
                    print("201")
                    do
                    {
                        if let cdata = try decoder.decode(UserData?.self, from: data)
                        {
                            DispatchQueue.main.async
                            {
                                self.presentAlert(alertText: "註冊成功", mode: .cancelAlertAndPopToRootView)
                                userInformation = cdata
                                completion(data)
                            }
                        }
                        else
                        {
                            print("1231237")
                        }
                    }
                    catch
                    {
                        print(error)
                    }
                }
                else if response.statusCode == 422
                {
                    print("42211")
                    do
                    {
                        print("cdata")
                        if let cdata = try decoder.decode(CommonError?.self, from: data)
                        {
                            print("no cdata")
                            DispatchQueue.main.async
                            { [weak self] in
                                print(cdata)
                                self?.presentAlert(alertText: cdata.errors.email?.first ?? "b", mode: .cancelAlert)
                            }
                        }
                        else
                        {
                            print("Register Decoder Error")
                        }
                    }
                    catch
                    {
                        print(error)
                    }
                }
                else
                {
                    print(response.statusCode)
                }
            }
        }
        task.resume()
    }
    
    func setLoginParameter()
    {
        self.loginParameter = "email=\(registerInfos[1])&password=\(registerInfos[2])"
    }
    
    func uploadLoginInfo(urlString: String, parameters: String, completion: @escaping (Data) -> Void) -> Void
    {
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpBody = parameters.data(using: String.Encoding.utf8)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        userLogin(from: request, completion: completion)
    }
    
    private func userLogin(from request: URLRequest, completion: @escaping (Data) -> Void)
    {
        let task = URLSession.shared.dataTask(with: request)
        { (data, response, error) in
            
            if error != nil
            {
                print(error as Any)
            }
            else if let response = response as? HTTPURLResponse, let data = data
            {
                if response.statusCode == 201
                {
                    completion(data)
                }
            }
        }
        task.resume()
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
