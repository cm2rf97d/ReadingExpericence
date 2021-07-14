//
//  HomeBookView.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/5/30.
//

import UIKit

class HomeBookView: UIView
{
    lazy var homeBookTableView: UITableView =
    {
        let tableView = UITableView()
        tableView.register(BookListTableViewCell.self, forCellReuseIdentifier: BookListTableViewCell.identifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = .zero
        return tableView
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        addSubview(homeBookTableView)
        layouts()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layouts()
    {
        homeBookTableView.snp.makeConstraints
        { (make) in
            make.centerX.centerY.width.height.equalTo(self)
        }
    }
}
