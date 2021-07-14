//
//  UIViewControllerExtension.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/5/17.
//

import Foundation
import UIKit

extension UIViewController
{
    enum RegisterStatus
    {
        case cancelAlert,
             cancelAlertAndPopView,
             cancelAlertAndDismissView,
             cancelAlertAndPopToRootView
    }
    
    func getTextField(registerInfo: String?, registerInfos: [String]) -> [String]
    {
        var registerInfoss: [String] = []
        
        if let Name = registerInfo
        {
            registerInfoss = registerInfos
            if Name != ""
            {
                registerInfoss.append(Name)
            }
            else
            {
                print("GG")
            }
        }
        return registerInfoss
    }
    
    func gotoNextViewController(vc: UIViewController, index: Int?, registerInfoCount: Int)
    {
        if let index = index
        {
            if index - 1 == registerInfoCount
            {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func presentAlert(alertText: String, mode: RegisterStatus)
    {
        let nameErrorAlert = UIAlertController(title: alertText, message: "", preferredStyle: .alert)
        
        if mode == .cancelAlert
        {
            let okAlert = UIAlertAction(title: "OK", style: .default)
            nameErrorAlert.addAction(okAlert)
        }
        else if mode == .cancelAlertAndDismissView
        {
            let okAlert = UIAlertAction(title: "OK", style: .default)
            { (action: UIAlertAction) in
                
                let loadingVC = LoadingViewController()
                loadingVC.modalPresentationStyle = .overCurrentContext
                loadingVC.modalTransitionStyle = .crossDissolve
                self.present(loadingVC, animated: true, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1)
                {
                    self.dismiss(animated: true)
                    {
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
            nameErrorAlert.addAction(okAlert)
        }
        else if mode == .cancelAlertAndPopToRootView
        {
            let okAlert = UIAlertAction(title: "OK", style: .default)
            { (action: UIAlertAction) in
                self.navigationController?.popToRootViewController(animated: true)
            }
            nameErrorAlert.addAction(okAlert)
        }
        else if mode == .cancelAlertAndPopView
        {
            let okAlert = UIAlertAction(title: "OK", style: .default)
            { (action: UIAlertAction) in
                self.navigationController?.popViewController(animated: true)
            }
            nameErrorAlert.addAction(okAlert)
        }
        present(nameErrorAlert, animated: true, completion: nil)
    }
}
