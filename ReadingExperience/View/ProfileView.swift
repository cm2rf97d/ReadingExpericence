//
//  ProfileView.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/5/25.
//

import UIKit

class ProfileView: UIView
{
    let profileImage: UIImageView =
    {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemBlue
        return imageView
    }()
    
    let profileNameLabel: UILabel =
    {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Mike"
        return label
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        addSubview(profileImage)
        addSubview(profileNameLabel)
        layouts()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layouts()
    {
        profileImage.snp.makeConstraints
        { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(100)
            make.width.height.equalTo(100)
        }
        
        profileNameLabel.snp.makeConstraints
        { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(200)
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
    }
}
