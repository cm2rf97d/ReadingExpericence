//
//  UIButtonExtension.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/5/12.
//

import Foundation
import UIKit

extension UIButton
{
    func setBackgroundColor(color: UIColor, forState: UIControl.State)
    {
        self.clipsToBounds = true  // add this to maintain corner radius
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext()
        {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
    }
}
