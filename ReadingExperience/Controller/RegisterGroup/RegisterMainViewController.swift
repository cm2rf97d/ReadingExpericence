//
//  HomePageViewController.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/5/12.
//

import UIKit
import LGSideMenuController

class RegisterMainViewController: UIViewController
{
    let homeView = RegisterMainView()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .white
        setButtonAction()
    }
    
    override func loadView()
    {
        self.view = homeView
    }
    
    func setButtonAction()
    {
        homeView.registerButtonAction = registerButtonAction
        homeView.registerButton.setBackgroundColor(color: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), forState: UIControl.State.highlighted)
        homeView.signInButtonAction = signInButtonAction
        homeView.signInButton.setBackgroundColor(color: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), forState: UIControl.State.highlighted)
    }
    
    @objc func registerButtonAction()
    {
        self.navigationController?.pushViewController(RegisterNameViewController(), animated: true)
    }
    
    @objc func signInButtonAction()
    {
        self.navigationController?.pushViewController(SignInViewController(), animated: true)
    }

}

