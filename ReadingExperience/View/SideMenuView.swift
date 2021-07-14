//
//  SideModeView.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/5/20.
//

import UIKit

class SideMenuView: UIView
{
    let sideMenuProfileImageView: MyImageView =
    {
        let imageView = MyImageView()
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.backgroundColor = .blue
        imageView.image = UIImage(named: "Dola.jpg")
        return imageView
    }()
    
    let sideMenuUserNameLabel: UILabel =
    {
        let label = UILabel()
        label.text = "Mike@gmail.com"
        return label
    }()
    
    let sideMenuTableView: UITableView =
    {
        let tableView = UITableView(frame: CGRect(), style: .insetGrouped)
        tableView.register(SideMenuTableViewCell.self, forCellReuseIdentifier: SideMenuTableViewCell.identifier)
        tableView.backgroundColor = registerColor
        return tableView
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.backgroundColor = testColor
        addSubview(sideMenuTableView)
        addSubview(sideMenuUserNameLabel)
        addSubview(sideMenuProfileImageView)
        layouts()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func tableViewBackgroundColorSet()
//    {
//        let myGradientLayer = CAGradientLayer()
//        myGradientLayer.frame = CGRect(x: 0.0,y: 0.0,width: 250.0,height: 896.0)
//        myGradientLayer.colors = [#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor,
//                                  #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).cgColor,
//                                  #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1).cgColor,
//                                  #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1).cgColor,
//                                  #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1).cgColor]
//        self.layer.insertSublayer(myGradientLayer, at: 0)
//    }
    
    func layouts()
    {
        sideMenuProfileImageView.snp.makeConstraints
        { (make) in
            make.width.height.equalTo(100)
            make.topMargin.equalTo(15)
            make.left.equalTo(10)
        }
        
        sideMenuUserNameLabel.snp.makeConstraints
        { (make) in
            make.right.equalTo(self)
            make.left.equalTo(sideMenuProfileImageView.snp.left)
            make.top.equalTo(sideMenuProfileImageView.snp.bottom).offset(10)
        }
        
        sideMenuTableView.snp.makeConstraints
        { (make) in
            make.top.equalTo(sideMenuUserNameLabel.snp.bottom)
            make.width.bottom.equalTo(self)
        }
    }
}
