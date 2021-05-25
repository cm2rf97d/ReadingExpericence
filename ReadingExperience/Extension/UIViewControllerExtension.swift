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
}
