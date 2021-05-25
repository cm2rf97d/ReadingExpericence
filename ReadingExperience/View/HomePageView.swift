//
//  HomePageView.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/5/17.
//

import UIKit

class HomePageView: UIView
{
    let collectionViewHeight: Double = 180
    
//    var searchControl: UISearchController =
//    {
//        let search = UISearchController(searchResultsController: nil)
//        return search
//    }()
    
    let homePageCollectionView: UICollectionView =
    {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: 100.0, height: 180)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.register(HomePageCollectionViewCell.self, forCellWithReuseIdentifier: HomePageCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.backgroundColor = registerColor
        addSubview(homePageCollectionView)
        layouts()
    }   
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layouts()
    {
        homePageCollectionView.snp.makeConstraints
        { (make) in
            make.top.equalTo(snp_topMargin)
            make.centerX.equalTo(self)
            make.width.equalTo(self)
            make.height.equalTo(collectionViewHeight)
        }
    }
}
