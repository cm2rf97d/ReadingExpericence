//
//  SideModeView.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/5/20.
//

import UIKit

class SideMenuView: UIView
{
    let sideMenuTableView: UITableView =
    {
        let tableView = UITableView(frame: CGRect(), style: .insetGrouped)
        tableView.register(SideMenuTableViewCell.self, forCellReuseIdentifier: SideMenuTableViewCell.identifier)
        tableView.backgroundColor = .systemBlue
        return tableView
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        addSubview(sideMenuTableView)
        layouts()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layouts()
    {
        sideMenuTableView.snp.makeConstraints
        { (make) in
            make.edges.equalTo(self)
        }
    }
}
