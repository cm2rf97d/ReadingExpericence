//
//  HomePageView.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/6/10.
//

import UIKit

class HomePageView: UIView
{
    let homeCollectionView: UICollectionView =
    {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
//        layout.minimumInteritemSpacing = 10
//        layout.itemSize = CGSize(width: 300.0, height: 30)
        layout.scrollDirection = .horizontal
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = registerColor
        collectionView.register(HomePageCollectionViewCell.self, forCellWithReuseIdentifier: HomePageCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    let searchTextField: UITextField =
    {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "想找什麼書？",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .none
        textField.backgroundColor = registerColor
        textField.layer.cornerRadius = 10
//        textField.layer.masksToBounds = false
//        textField.layer.shadowColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
//        textField.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
//        textField.layer.shadowOpacity = 1.0
//        textField.layer.shadowRadius = 0.0
//        textField.leftViewMode = .unlessEditing
//        textField.contentMode = .scaleAspectFit
//        let image = UIImageView(image: UIImage(systemName: "magnifyingglass"))
//        image.bounds = CGRect(x: -30, y: 0, width: UIScreen.main.bounds.width * 0.7, height: 34)
//        textField.leftView = image
        return textField
    }()
    
    let testView: UIView =
    {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = registerColor
        return view
    }()

    let bottomView: UIView =
    {
        let view = UIView()
        return view
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.backgroundColor = registerColor
        addSubview(homeCollectionView)
        addSubview(bottomView)
        testView.addSubview(searchTextField)
        layouts()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layouts()
    {
        homeCollectionView.snp.makeConstraints
        { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(5)
            make.width.equalTo(self)
            make.height.equalTo(60)
        }
        
        bottomView.snp.makeConstraints
        { (make) in
            make.top.equalTo(homeCollectionView.snp.bottom).offset(-5)
            make.right.left.bottom.equalTo(self)
        }
        
        
        testView.snp.makeConstraints
        { (make) in
            make.width.equalTo(UIScreen.main.bounds.width * 0.7)
            make.height.equalTo(30)
        }
        
        searchTextField.snp.makeConstraints
        { (make) in
            make.centerX.equalTo(testView.snp.centerX)
            make.width.equalTo(UIScreen.main.bounds.width * 0.65)
            make.height.equalTo(30)
        }
    }
}
