//
//  BookDetailViewController.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/5/30.
//

import UIKit

class BookDetailViewController: UIViewController
{
    let bookDetailView = BookDetailView()
    var bookId: Int = 0
    var bookCommentIndex: Int = 0
    var isAlreadyComment: Bool = false
    var bookDetailData: BookDetailData?
    {
        didSet
        {
            bookDetailView.bookDetailTableView.reloadData()
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setNavigationTintColor()
        setTableViewDelegate()
    }
    
    override func loadView()
    {
        self.view = bookDetailView
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        getBookDetailData()
    }

    func setNavigationTintColor()
    {
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    func setTableViewDelegate()
    {
        bookDetailView.bookDetailTableView.delegate = self
        bookDetailView.bookDetailTableView.dataSource = self
    }
    
    func getBookDetailData()
    {
        let url: String = "books/\(self.bookId)"
        
        APICaller.shared.getBookDetailData(url: url)
        { result in
            switch result
            {
                case .success(let bookDetailData):
                    self.bookDetailData = bookDetailData
                    self.checkAlreadyComment()
                case .failure(_):
                    self.presentAlert(alertText: "請檢查你的網路連線", mode: .cancelAlert)
            }
        }
    }
    
    func writeComment()
    {
        let vc = WriteCommentViewController()
        vc.bookID = self.bookId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func checkAlreadyComment()
    {
        if let bookDetailData = self.bookDetailData
        {
            for index in 0..<bookDetailData.book.comments.count
            {
                if userInformation?.user.id == bookDetailData.book.comments[index].userID
                {
                    self.bookCommentIndex = index
                    self.isAlreadyComment = true
                }
            }
        }
    }
}

extension BookDetailViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 6
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        switch indexPath.section
        {
            case 0:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.identifier, for: indexPath)
                                    as? ImageTableViewCell else { return UITableViewCell()}
                
                if let bookDetail = bookDetailData
                {
                    if let url = URL(string: bookDetail.book.image)
                    {
                        cell.bookImage.loadImage(url: url)
                    }
                }
                return cell
        
            case 1:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: NameTableViewCell.identifier, for: indexPath)
                                    as? NameTableViewCell else { return UITableViewCell()}
                
                if let bookDetail = bookDetailData
                {
                    cell.nameLabel.text = bookDetail.book.bookname
                }
                return cell
                
            case 2:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: EvaluationTableViewCell.identifier, for: indexPath)as?    EvaluationTableViewCell else {return UITableViewCell()}

                cell.evaluationView.delegate = self
                cell.evaluationButtonAction = writeComment
                if let bookDetail = bookDetailData
                {
                    if let rate = bookDetail.avgRate
                    {
                        cell.evaluationLabel.text = "\(rate.rounding(toDecimal: 1))分，共\(bookDetail.book.comments.count)位評分  |"
                        cell.evaluationView.currentStarCount = rate
                    }
                }
            
                return cell
            
            case 3:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: AuthorTableViewCell.identifier, for: indexPath) as?     AuthorTableViewCell else {return UITableViewCell()}
                
                if let bookDetail = bookDetailData
                {
                    cell.authorLabel.text = "作者：\(bookDetail.book.author)"
                    cell.publisherLabel.text = "出版社：\(bookDetail.book.publisher)"
                    cell.publishDateLabel.text = "出版日期：\(bookDetail.book.publishDate)"
                }
                return cell
                
            case 4:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionTableViewCell.identifier, for:indexPath) as? DescriptionTableViewCell else {return UITableViewCell()}
                if let bookDetail = bookDetailData
                {
                    cell.bookDescriptionLabel.text = bookDetail.book.bookDescription
                }
                
                return cell
            case 5:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: UserEvaluationTableViewCell.identifier, for:indexPath) as? UserEvaluationTableViewCell else {return UITableViewCell()}
                
                if let bookDetail = bookDetailData
                {
                    if bookDetail.book.comments.isEmpty == false
                    {
                        cell.userLabel.text = " \(bookDetail.book.comments[indexPath.row].user.name)"
                        cell.evaluationLabel.text = " \(bookDetail.book.comments[indexPath.row].comment ?? "")"
                        cell.seeMoreEvaluationButtonAction =
                        {
                            let vc = AllCommentsViewController()
                            vc.reloadUserCommentDelegate = self
                            vc.isAlreadyComment = self.isAlreadyComment
                            vc.bookCommentIndex = self.bookCommentIndex
                            vc.bookId = self.bookId
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                    else
                    {
                        cell.evaluationLabel.text = "尚未有任何評論"
                        cell.seeMoreEvaluationButton.isHidden = true
                    }
                }
                cell.separatorInset = UIEdgeInsets(top: 0, left: 450, bottom: 0, right: 0)
                return cell
            default:
                return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        switch indexPath.section
        {
            case 0:
                return 230
            default:
                return UITableView.automaticDimension
        }
    }
}


extension BookDetailViewController: reloadUserCommentDelegate
{
    func reloadUserComment()
    {
        self.isAlreadyComment = false
        getBookDetailData()
    }
}

extension BookDetailViewController: JNStarReteViewDelegate
{
    func starRate(view starRateView: JNStarRateView, count: Float)
    {
        print(count)
    }
}
