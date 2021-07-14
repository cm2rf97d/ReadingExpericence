//
//  ProfileView.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/5/25.
//

import UIKit

class ProfileView: UIView
{
    var logOutButtonAction: (() -> Void)?
    var testButtonAction: (() -> Void)?
    var profileImageAction: (() -> Void)?
    
    let profileImage: MyImageView =
    {
        let imageView = MyImageView()
        imageView.backgroundColor = .systemBlue
        imageView.layer.cornerRadius = 150
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let testButton: UIButton =
    {
        let button = UIButton()
        button.addTarget(self, action: #selector(test), for: .touchUpInside)
        button.backgroundColor = .green
        return button
    }()
    
    let profileNameLabel: UILabel =
    {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30)
        label.text = ""
        return label
    }()
    
    let logOutButton: UIButton =
    {
        let button = UIButton()
        button.setTitle("Log Out", for: .normal)
        button.backgroundColor = .lightGray
        button.isHidden = true
        button.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        return button
    }()
    
    let profileBookCollectionView: UICollectionView =
    {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: 110.0, height: 180)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.register(BookListCollectionViewCell.self, forCellWithReuseIdentifier: BookListCollectionViewCell.identifier)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    let profileCommentCountLabel: UILabel =
    {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.textAlignment = .center
        return label
    }()
    
    let profileCommentedBookLabel: UILabel =
    {
        let label = UILabel()
        label.text = "已評論書籍:"
        label.font = UIFont.systemFont(ofSize: 25)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.backgroundColor = registerColor
        addSubview(profileImage)
        addSubview(profileNameLabel)
        addSubview(logOutButton)
        addSubview(profileBookCollectionView)
        addSubview(profileCommentedBookLabel)
        addSubview(profileCommentCountLabel)
        layouts()
        
        let tapProfile = UITapGestureRecognizer(target: self, action: #selector(profileImageDidTap))
        profileImage.addGestureRecognizer(tapProfile)
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func profileImageDidTap()
    {
        profileImageAction?()
    }
    
    @objc func logOut()
    {
        logOutButtonAction?()
    }
    
    @objc func test()
    {
        testButtonAction?()
    }
    
    func layouts()
    {
        profileImage.snp.makeConstraints
        { (make) in
            make.centerX.equalTo(self)
            make.topMargin.equalTo(30)
            make.width.height.equalTo(300)
        }
        
        profileNameLabel.snp.makeConstraints
        { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(profileImage.snp_bottomMargin).offset(20)
            make.width.equalTo(self)
            make.height.equalTo(50)
        }
        
        profileCommentCountLabel.snp.makeConstraints
        { (make) in
            make.width.equalTo(self)
            make.height.equalTo(50)
            make.top.equalTo(profileNameLabel.snp.bottom).offset(40)
            make.centerX.equalTo(self)
        }
        
        profileCommentedBookLabel.snp.makeConstraints
        { (make) in
            make.width.equalTo(self)
            make.centerX.equalTo(self)
            make.top.equalTo(profileCommentCountLabel.snp.bottom).offset(30)
        }
        
        profileBookCollectionView.snp.makeConstraints
        { (make) in
            make.width.equalTo(self)
            make.height.equalTo(180)
            make.centerX.equalTo(self)
            make.top.equalTo(profileCommentedBookLabel.snp.bottom).offset(10)
        }
        
        logOutButton.snp.makeConstraints
        { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(profileBookCollectionView.snp.bottom).offset(25)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
    }
}
