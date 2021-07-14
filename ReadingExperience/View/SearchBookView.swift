//
//  SearchBookView.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/6/3.
//

import UIKit

class SearchBookView: UIView
{
    var searchButtonAction: (() -> Void)?
    
    let searchTextField: UITextField =
    {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "  想找什麼書？",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.borderStyle = .none
        textField.backgroundColor = registerColor
        textField.layer.cornerRadius = 10
//        textField.layer.masksToBounds = false
//        textField.layer.backgroundColor = #colorLiteral(red: 0.2609430552, green: 0.2443105876, blue: 0.05599819124, alpha: 1).cgColor
//        textField.layer.shadowColor =
//        textField.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
//        textField.layer.shadowOpacity = 1.0
//        textField.layer.shadowRadius = 0.0
        return textField
    }()
    
    var searchBookTableView: UITableView =
    {
        let tableView = UITableView()
        tableView.register(SearchBookTableViewCell.self, forCellReuseIdentifier: SearchBookTableViewCell.identifier)
        tableView.register(SearchCountTableViewCell.self, forCellReuseIdentifier: SearchCountTableViewCell.identifier)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.backgroundColor = .white
        addSubview(searchBookTableView)
        layouts()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func searchBook()
    {
        searchButtonAction?()
    }
    
    func layouts()
    {
        searchBookTableView.snp.makeConstraints
        { (make) in
            make.top.height.equalTo(self)
            make.left.equalTo(self)
            make.width.equalTo(UIScreen.main.bounds.width * 0.95)
        }
        
        searchTextField.snp.makeConstraints
        { (make) in
            make.width.equalTo(UIScreen.main.bounds.width * 0.7)
            make.height.equalTo(30)
        }
    }
}
