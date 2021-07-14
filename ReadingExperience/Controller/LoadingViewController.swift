//
//  LoadingViewViewController.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/7/13.
//

import UIKit

class LoadingViewController: UIViewController
{
    let loadingView = LoadingView()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        loadingView.loadingAnimationView.loopMode = .autoReverse
        loadingView.loadingAnimationView.play()
    }
    
    override func loadView()
    {
        self.view = loadingView
    }

}
