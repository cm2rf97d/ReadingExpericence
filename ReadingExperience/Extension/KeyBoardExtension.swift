//
//  KeyBoardExtension.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/5/12.
//

import Foundation
import UIKit

extension UIViewController: UITextFieldDelegate
{
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }

    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }
}
