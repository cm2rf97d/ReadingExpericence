//
//  PhoneNumberViewController.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/5/12.
//

import UIKit

class RegionViewController: UIViewController
{
    let regionView = RegisterView()
    var registerInfos: [String] = []
    var registerParameter = ""
    var loginParameter = ""
    let registerUrl = "http://52.196.162.105/api/register"
    let loginUrl = "http://52.196.162.105/api/login"
    var test: UserData?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setTitleLabel()
        regionView.accountInfoTextField.delegate = self
        regionView.nextButtonAction = uploadUserInfomation
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
    
    func uploadUserInfomation()
    {
        setRegisterParameter()
        userRegister(urlString: registerUrl, parameters: registerParameter, completion:
        { (data) in
            self.setLoginParameter()
            self.uploadLoginInfo(urlString: self.loginUrl, parameters: self.loginParameter)
            { (data) in
                DispatchQueue.main.async
                {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        })
    }
    
    // MARK: Function Area
    func setRegisterParameter()
    {
        if let Name = regionView.accountInfoTextField.text
        {
            self.registerParameter = "name=\(registerInfos[0])&email=\(registerInfos[1])&password=\(registerInfos[2])&password_confirmation=\(registerInfos[3])&region=\(Name)"
        }
    }
    
    func userRegister(urlString: String, parameters: String, completion: @escaping (Data) -> Void) -> Void
    {
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpBody = parameters.data(using: String.Encoding.utf8)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
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
                if response.statusCode == 201
                {
                    let decoder = JSONDecoder()
                    do
                    {
                        if let cdata = try decoder.decode(UserData?.self, from: data)
                        {
                            DispatchQueue.main.async
                            {
                                userInfomation = cdata
                            }
                        }
                    }
                    catch
                    {
                        print(error)
                    }
                    completion(data)
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
}
