//
//  ImageTableViewCell.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/5/30.
//

import UIKit

class ImageTableViewCell: UITableViewCell
{
    static let identifier = "ImageTableViewCell"
    
    var bookImage: MyImageView =
    {
        let image = MyImageView()
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        addSubview(bookImage)
        layouts()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layouts()
    {
        bookImage.snp.makeConstraints
        { (make) in
            make.centerX.centerY.equalTo(self)
            make.height.width.equalTo(200)
        }
    }
}
