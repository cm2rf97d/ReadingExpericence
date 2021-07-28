//
//  SearchBookViewController.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/6/3.
//

import UIKit

class SearchBookViewController: UIViewController
{
    var searchBookName: String?
    let searchBookView = SearchBookView()
    var bookListDatas: [BookListData] = []
    {
        didSet
        {
            searchBookView.searchBookTableView.reloadData()
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setDelegate()
        setNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        navigationController?.navigationBar.barTintColor = registerColor
        guard let bookName = self.searchBookName else { return }
        searchBook(bookName: bookName)
    }
    
    override func loadView()
    {
        self.view = searchBookView
    }
    
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if let bookName = textField.text
        {
            searchBook(bookName: bookName)
        }
        return true
    }
    
    func setNavigationBar()
    {
        //Right Button
//        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchBook))
//        searchButton.tintColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
//        self.navigationItem.rightBarButtonItem = searchButton
        
        //Navigation Title View
        self.navigationItem.titleView = searchBookView.searchTextField
    }
    
    func setDelegate()
    {
        searchBookView.searchTextField.delegate = self
        searchBookView.searchBookTableView.delegate = self
        searchBookView.searchBookTableView.dataSource = self
    }
    
    @objc func callSideMenu()
    {
        sideMenuController?.toggleLeftView()
    }
    
    @objc func searchBook(bookName: String)
    {
        searchBookView.searchBookTableView.separatorStyle = .singleLine
        
        //MARK: UrlSet
//        guard let bookName = searchBookView.searchTextField.text else { return }
        let bookUrl = "books/search/\(bookName)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) // 有中文，必須重組
        guard let bookUrl = bookUrl else { return }
        
        //MARK: Send API
        APICaller.shared.searchBook(url: bookUrl)
        { result in
            switch result
            {
                case .success(let bookdata):
                    self.bookListDatas = bookdata
                case .failure(_):
                    self.presentAlert(alertText: "查無此書", mode: .cancelAlert)
            }
        }
    }
    
    func gotoSpecifyBook(bookId: Int)
    {
        let vc = BookDetailViewController()
        vc.bookId = bookId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setSearchResultCountLabel(labelTitle: String) -> NSMutableAttributedString
    {
        var titleMutableString = NSMutableAttributedString()
        
        titleMutableString =
            NSMutableAttributedString(string: labelTitle,
                                      attributes: [NSAttributedString.Key.font:UIFont(name: "Georgia", size: 18.0) as Any])
        
        titleMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemOrange, range: NSRange(location: 5,length: String(bookListDatas.count).count ))
        return titleMutableString
    }
}

extension SearchBookViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        switch section
        {
            case 0:
                return 1
            default:
                return bookListDatas.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        switch indexPath.section
        {
            case 0 :
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchCountTableViewCell.identifier, for: indexPath) as? SearchCountTableViewCell else { return UITableViewCell() }
                
                if bookListDatas.count != 0
                {
                    cell.searchResultCountLabel.isHidden = false
                }
                cell.searchResultCountLabel.text = "搜尋結果共\(bookListDatas.count)筆"
                cell.searchResultCountLabel.attributedText = setSearchResultCountLabel(labelTitle: cell.searchResultCountLabel.text ?? "")
                return cell
                
            case 1:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchBookTableViewCell.identifier, for: indexPath) as? SearchBookTableViewCell else { return UITableViewCell() }
                
                let bookDatasCell = bookListDatas[indexPath.row]
                if let url = URL(string: bookDatasCell.image ?? "")
                {
                    cell.bookImage.loadImage(url: url)
                }
                cell.bookNameLabel.text = bookDatasCell.bookname
                cell.bookAuthorLabel.text = "作者:\(bookDatasCell.author)"
                cell.bookDescriptionLabel.text = bookDatasCell.welcomeDescription
                return cell
                
            default:
                return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        gotoSpecifyBook(bookId: bookListDatas[indexPath.row].id)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        switch indexPath.section
        {
            case 0:
                return UITableView.automaticDimension
            case 1:
                return 150
            default:
                return 0
        }
    }
}
