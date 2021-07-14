//
//  AllCommentsView.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/6/21.
//

import UIKit

class AllCommentsView: UIView
{
    let allCommentsTableView: UITableView =
    {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.register(AllCommentsTableViewCell.self, forCellReuseIdentifier: AllCommentsTableViewCell.identifier)
        tableView.register(CurrentUserCommentTableViewCell.self, forCellReuseIdentifier: CurrentUserCommentTableViewCell.identifier)
        tableView.allowsSelection = false
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .gray
        tableView.separatorInset = .zero
        return tableView
    }()
    
    let myCommentHeaderView: UIView =
    {
        let label = UILabel()
        label.frame = CGRect.init(x: 0, y: 0, width: 414.0, height: 30)
        label.text = "  您的評論"
        label.font = .systemFont(ofSize: 17)
        label.textColor = .black
        label.backgroundColor = #colorLiteral(red: 0.6305685639, green: 0.7515563369, blue: 0.5175241828, alpha: 1)
        
        let headerView = UIView()
        headerView.addSubview(label)
        
        return headerView
    }()
    
    let anotherCommentHeaderView: UIView =
    {
        let label = UILabel()
        label.frame = CGRect.init(x: 0, y: 0, width: 414.0, height: 30)
        label.text = "  所有使用者的評論"
        label.font = .systemFont(ofSize: 17)
        label.textColor = .black
        label.backgroundColor = #colorLiteral(red: 0.6305685639, green: 0.7515563369, blue: 0.5175241828, alpha: 1)
        
        let headerView = UIView()
        headerView.addSubview(label)
        
        return headerView
    }()
    
    let testHeaderView: UIView =
    {
        let label = UILabel()
        label.frame = CGRect.init(x: 0, y: 0, width: 414.0, height: 30)
        label.text = "  評論"
        label.font = .systemFont(ofSize: 17)
        label.textColor = .black
        label.backgroundColor = #colorLiteral(red: 0.6305685639, green: 0.7515563369, blue: 0.5175241828, alpha: 1)
        
        let headerView = UIView()
        headerView.addSubview(label)
        
        return headerView
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        addSubview(allCommentsTableView)
        layouts()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layouts()
    {
        allCommentsTableView.snp.makeConstraints
        { (make) in
            make.edges.equalTo(self)
        }
    }
}
