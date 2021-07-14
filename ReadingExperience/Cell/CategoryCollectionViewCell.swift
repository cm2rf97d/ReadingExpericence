//
//  HomeBookCollectionViewCell.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/5/30.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell
{
    static let identifier = "CategoryCollectionViewCell"
    
    let categoryLabel: UILabel =
    {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        addSubview(categoryLabel)
        layouts()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layouts()
    {
        categoryLabel.snp.makeConstraints
        { (make) in
            make.centerX.centerY.width.height.equalTo(self)
        }
    }
}
