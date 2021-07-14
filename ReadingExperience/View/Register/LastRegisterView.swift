//
//  LastRegisterView.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/6/13.
//

import UIKit

class LastRegisterView: UIView
{
    var nextButtonAction: (() -> Void)?
    var selectButtonAction: (() -> Void)?
    
    var titleLabel: UILabel =
    {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .gray
        return label
    }()
    
    let nextButton: UIButton =
    {
        let button = UIButton()
        button.setTitle("Next →", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        button.layer.cornerRadius = 10.0
        button.clipsToBounds = true
        button.setBackgroundColor(color: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), forState: UIControl.State.highlighted)
        button.addTarget(self, action: #selector(nextAccount), for: .touchUpInside)
        return button
    }()
    
    let selectButton: UIButton =
    {
        let button = UIButton()
        button.setTitle("Select Area", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.4117647059, green: 0.5, blue: 0.7617624503, alpha: 1)
        button.clipsToBounds = true
        button.setBackgroundColor(color: #colorLiteral(red: 0.4117647059, green: 0.5, blue: 0.7617624503, alpha: 1), forState: UIControl.State.highlighted)
        button.addTarget(self, action: #selector(showButton), for: .touchUpInside)
        return button
    }()
    
    let northButton: UIButton =
    {
        let button = UIButton()
        button.tag = 0
        button.isHidden = true
        button.setTitle("北部", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        button.setBackgroundColor(color: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), forState: UIControl.State.highlighted)
        button.addTarget(self, action: #selector(RegionViewController.test(sender:)), for: .touchUpInside)
        return button
    }()
    
    let eastButton: UIButton =
    {
        let button = UIButton()
        button.tag = 1
        button.isHidden = true
        button.setTitle("東部", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        button.setBackgroundColor(color: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), forState: UIControl.State.highlighted)
        button.addTarget(self, action: #selector(RegionViewController.test(sender:)), for: .touchUpInside)
        return button
    }()
    
    let southButton: UIButton =
    {
        let button = UIButton()
        button.tag = 2
        button.isHidden = true
        button.setTitle("南部", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        button.setBackgroundColor(color: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), forState: UIControl.State.highlighted)
        button.addTarget(self, action: #selector(RegionViewController.test(sender:)), for: .touchUpInside)
        return button
    }()
    
    let westButton: UIButton =
    {
        let button = UIButton()
        button.tag = 3
        button.isHidden = true
        button.setTitle("西部", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        button.setBackgroundColor(color: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), forState: UIControl.State.highlighted)
        button.addTarget(self, action: #selector(RegionViewController.test(sender:)), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.backgroundColor = registerColor
        addSubview(titleLabel)
        addSubview(nextButton)
        addSubview(selectButton)
        addSubview(northButton)
        addSubview(eastButton)
        addSubview(southButton)
        addSubview(westButton)
        layouts()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func nextAccount()
    {
        nextButtonAction?()
    }
    
    @objc private func showButton()
    {
        selectButtonAction?()
    }
    
    func layouts()
    {
        titleLabel.snp.makeConstraints
        { (make) in
            make.height.equalTo(35)
            make.width.equalTo(UIScreen.main.bounds.width)
            make.centerX.equalTo(self)
            make.top.equalTo(200)
        }
        
        selectButton.snp.makeConstraints
        { (make) in
            make.height.equalTo(40)
            make.width.equalTo(UIScreen.main.bounds.width * 0.3)
            make.centerX.equalTo(self)
            make.top.equalTo(400)
        }
        
        northButton.snp.makeConstraints
        { (make) in
            make.height.equalTo(40)
            make.width.equalTo(UIScreen.main.bounds.width * 0.3)
            make.centerX.equalTo(self)
            make.top.equalTo(selectButton.snp_bottomMargin).offset(8)
        }
        
        eastButton.snp.makeConstraints
        { (make) in
            make.height.equalTo(40)
            make.width.equalTo(UIScreen.main.bounds.width * 0.3)
            make.centerX.equalTo(self)
            make.top.equalTo(northButton.snp_bottomMargin).offset(8)
        }
        
        southButton.snp.makeConstraints
        { (make) in
            make.height.equalTo(40)
            make.width.equalTo(UIScreen.main.bounds.width * 0.3)
            make.centerX.equalTo(self)
            make.top.equalTo(eastButton.snp_bottomMargin).offset(8)
        }
        
        westButton.snp.makeConstraints
        { (make) in
            make.height.equalTo(40)
            make.width.equalTo(UIScreen.main.bounds.width * 0.3)
            make.centerX.equalTo(self)
            make.top.equalTo(southButton.snp_bottomMargin).offset(8)
        }
        
        nextButton.snp.makeConstraints
        { (make) in
            make.height.equalTo(40)
            make.width.equalTo(UIScreen.main.bounds.width * 0.7)
            make.centerX.equalTo(self)
            make.bottom.equalTo(-200)
        }
    }
}
