//
//  AllCommentsViewController.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/6/21.
//

import UIKit


protocol reloadUserCommentDelegate
{
    func reloadUserComment()
}

class AllCommentsViewController: UIViewController
{
    let allCommentsView = AllCommentsView()
    var bookId: Int = 0
    var currentUserComment: Comment?
    var isAlreadyComment: Bool?
    var bookCommentIndex: Int?
    var reloadUserCommentDelegate: reloadUserCommentDelegate?
    var bookDetailData: BookDetailData?
    {
        didSet
        {
            allCommentsView.allCommentsTableView.reloadData()
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        allCommentsView.allCommentsTableView.delegate = self
        allCommentsView.allCommentsTableView.dataSource = self
        getBookCommentData()
    }
    
    override func loadView()
    {
        self.view = allCommentsView
    }

    override func viewWillDisappear(_ animated: Bool)
    {
        reloadUserCommentDelegate?.reloadUserComment()
    }
    
    func setNavigationTitle()
    {
        self.title = "評論"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    func getBookCommentData()
    {
        let url: String = "books/\(self.bookId)"
        
        APICaller.shared.getBookDetailData(url: url)
        { result in
            switch result
            {
                case .success(let bookDetailData):
                    self.bookDetailData = bookDetailData
                    if self.isAlreadyComment == true
                    {
                        self.currentUserComment = self.bookDetailData!.book.comments[self.bookCommentIndex!]
                    }
                case .failure(_):
                    self.presentAlert(alertText: "請檢查你的網路連線", mode: .cancelAlert)
            }
        }
    }
    
    func getTimeLabel(time: String) -> String
    {
        String(time[..<time.index(time.startIndex, offsetBy: 10)])
    }
    
    func editComment()
    {
        let vc = WriteCommentViewController()
        vc.currentUserComment = self.currentUserComment
        vc.allCommentReloadDataDelegate = self
        let nvc = UINavigationController(rootViewController: vc)
        self.present(nvc, animated: true, completion: nil)
    }
}

extension AllCommentsViewController: allCommentReloadDataDelegate
{
    func allCommentReloadData(type: CommentType)
    {
        if type == .delete
        {
            self.isAlreadyComment = false
        }
        getBookCommentData()
    }
}

extension AllCommentsViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        self.isAlreadyComment == true ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        switch section
        {
            case 0:
                let headerView = self.isAlreadyComment == true ? allCommentsView.myCommentHeaderView : allCommentsView.anotherCommentHeaderView
                return headerView
            case 1:
                return allCommentsView.anotherCommentHeaderView
            default:
                return allCommentsView.anotherCommentHeaderView
        }
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if let bookDetail = bookDetailData
        {
            switch section
            {
                case 0:
                    return self.isAlreadyComment == true ? 1 : bookDetail.book.comments.count
                default:
                    return bookDetail.book.comments.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let allCommentCell = tableView.dequeueReusableCell(withIdentifier: AllCommentsTableViewCell.identifier, for:indexPath) as? AllCommentsTableViewCell else {return UITableViewCell()}
        
        guard let currentUserCommentCell = tableView.dequeueReusableCell(withIdentifier: CurrentUserCommentTableViewCell.identifier, for:indexPath) as? CurrentUserCommentTableViewCell else {return UITableViewCell()}
        
        if let bookDetail = bookDetailData
        {
            switch indexPath.section
            {
                case 0:
                    if self.isAlreadyComment == true
                    {
                        if let currentUsrComment = self.currentUserComment
                        {
                            currentUserCommentCell.userNameLabel.text = currentUsrComment.user.name
                            currentUserCommentCell.timeLabel.text = getTimeLabel(time: currentUsrComment.user.createdAt)
                            currentUserCommentCell.commentLabel.text = currentUsrComment.comment
                            currentUserCommentCell.evaluationView.currentStarCount = Float(currentUsrComment.rate)
                            currentUserCommentCell.editCommentButtonAction = editComment
                            return currentUserCommentCell
                        }
                    }
                    else
                    {
                        let bookDetailCell = bookDetail.book.comments[indexPath.row]
                        allCommentCell.userNameLabel.text = bookDetailCell.user.name
                        allCommentCell.timeLabel.text = getTimeLabel(time: bookDetailCell.user.createdAt)
                        allCommentCell.commentLabel.text = bookDetailCell.comment
                        allCommentCell.evaluationView.currentStarCount = Float(bookDetailCell.rate)
                        return allCommentCell
                    }
                case 1:
                    let bookDetailCell = bookDetail.book.comments[indexPath.row]
                    allCommentCell.userNameLabel.text = bookDetailCell.user.name
                    allCommentCell.timeLabel.text = getTimeLabel(time: bookDetailCell.user.createdAt)
                    allCommentCell.commentLabel.text = bookDetailCell.comment
                    allCommentCell.evaluationView.currentStarCount = Float(bookDetailCell.rate)
                    return allCommentCell
                default:
                    break
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        0
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String?
    {
        "none"
    }
}
