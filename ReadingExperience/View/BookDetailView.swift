//
//  BookDetailView.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/5/30.
//

import UIKit

class BookDetailView: UIView
{
    var bookDetailTableView: UITableView =
    {
        let tableView = UITableView()
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: ImageTableViewCell.identifier)
        tableView.register(NameTableViewCell.self, forCellReuseIdentifier: NameTableViewCell.identifier)
        tableView.register(AuthorTableViewCell.self, forCellReuseIdentifier: AuthorTableViewCell.identifier)
        tableView.register(DescriptionTableViewCell.self, forCellReuseIdentifier: DescriptionTableViewCell.identifier)
        tableView.register(EvaluationTableViewCell.self, forCellReuseIdentifier: EvaluationTableViewCell.identifier)
        tableView.register(UserEvaluationTableViewCell.self, forCellReuseIdentifier: UserEvaluationTableViewCell.identifier)
        tableView.allowsSelection = false
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .gray
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tableView.backgroundColor = .white
        return tableView
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.backgroundColor = .white
        addSubview(bookDetailTableView)
        layouts()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layouts()
    {
        bookDetailTableView.snp.makeConstraints
        { (make) in
            make.edges.equalTo(self)
        }
    }
}
