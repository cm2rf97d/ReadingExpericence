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
    var currentTextField: UITextField?
    var rect: CGRect?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        notificationCenterSet()
        signInView.singInButtonAction = userLogin
        signInView.emailTextField.delegate = self
        signInView.passwordTextField.delegate = self
    }
    
    override func loadView()
    {
        self.view = signInView
    }
    
    func notificationCenterSet()
    {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc func keyboardWillShow(note: NSNotification)
    {
        self.rect = view.bounds
        if currentTextField == nil
        {
            return
        }
        
        let userInfo = note.userInfo!
        let keyboard = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size
        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
//        let origin = (currentTextField?.frame.origin)!
//        let height = (currentTextField?.frame.size.height)!
        let origin = (signInView.passwordTextField.frame.origin)
        let height = (signInView.passwordTextField.frame.size.height)
        let targetY = origin.y + height
        let visibleRectWithoutKeyboard = self.view.bounds.size.height - keyboard.height - 5
        
        if targetY >= visibleRectWithoutKeyboard
        {
            var rect = self.rect!
            rect.origin.y -= (targetY - visibleRectWithoutKeyboard)
            UIView.animate(withDuration: duration)
            { () -> Void in
                self.view.frame = rect
            }
        }
    }
    
    @objc func keyboardWillHide(note: NSNotification)
    {
        /* 鍵盤隱藏時將畫面下移回原樣 */
        let keyboardAnimationDetail = note.userInfo as! [String: AnyObject]
        let duration = TimeInterval(truncating: keyboardAnimationDetail[UIResponder.keyboardAnimationDurationUserInfoKey]! as!NSNumber)
        
        UIView.animate(withDuration: duration,animations: { () -> Void in
                self.view.frame = self.view.frame.offsetBy(dx: 0, dy: -self.view.frame.origin.y)
            }
        )
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        currentTextField = textField
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
