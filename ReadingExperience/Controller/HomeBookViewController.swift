//
//  HomeBookViewController.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/5/30.
//

import UIKit
import Alamofire

class HomeBookViewController: UIViewController
{
    var categoryId: Category?
    let homeBookView = HomeBookView()
    var bookListDatas: [BookListData] = []
    {
        didSet
        {
            homeBookView.homeBookTableView.reloadData()
        }
    }
    
    init(categoryId: Category)
    {
        super.init(nibName: nil, bundle: nil)
        self.categoryId = categoryId
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        homeBookView.homeBookTableView.delegate = self
        homeBookView.homeBookTableView.dataSource = self
        getBookData()
    }
    
    override func loadView()
    {
        self.view = homeBookView
    }
    
    func getBookData() -> Void
    {
        let url = setUrl()
        APICaller.shared.getAllBook(url: url)
        { result in
            switch result
            {
                case .success(let bookData):
                    self.bookListDatas = bookData
                case .failure(_):
                    self.presentAlert(alertText: "請確認您的網路連線", mode: .cancelAlert)
            }
        }
    }
    
    func setUrl() -> String
    {
        var url:String = ""
        if let categoryId = categoryId
        {
            if categoryId.bookId == 0
            {
                url = "books"
            }
            else
            {
                url = "books/category/\(categoryId.bookId)"
            }
        }
        return url
    }
    
}

extension HomeBookViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookListTableViewCell.identifier, for: indexPath) as? BookListTableViewCell else {return UITableViewCell()}
        cell.bookDatas = self.bookListDatas
        cell.gotoBookDetailDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 180
    }
}

enum Category: Int,CaseIterable
{
    case all = 0
    case business
    case fiction
    case art
    case history
    case society
    case natural
    case psychology
    
    var bookId: Int
    {
        switch self
        {
            case .all:
                return 0
            case .business:
                return 1
            case .fiction:
                return 2
            case .art:
                return 3
            case .history:
                return 4
            case .society:
                return 5
            case .natural:
                return 6
            case .psychology:
                return 7
        }
    }
}
