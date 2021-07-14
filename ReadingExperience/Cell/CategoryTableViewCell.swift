//
//  HomeBookTableViewCell.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/5/30.
//

import UIKit

class CategoryTableViewCell: UITableViewCell
{
    static let identifier = "CategoryTableViewCell"
    let homeBookCollectionViewHeight: Double = 50
    let categorys = ["全部","財經","2","3","4","5","6","7"]
    
    lazy var categoryCollectionView: UICollectionView =
    {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: 100.0, height: homeBookCollectionViewHeight)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(categoryCollectionView)
        layouts()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layouts()
    {
        categoryCollectionView.snp.makeConstraints
        { (make) in
            make.centerX.centerY.equalTo(self)
            make.width.height.equalTo(self).offset(10)
        }
    }
}

extension CategoryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return categorys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else {return UICollectionViewCell()}
        cell.categoryLabel.text = categorys[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        print(indexPath.row)
    }
}
