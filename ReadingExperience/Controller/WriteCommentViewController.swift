//
//  WriteCommentViewController.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/6/2.
//

import UIKit
import Alamofire

protocol allCommentReloadDataDelegate
{
    func allCommentReloadData(type: CommentType)
}

class WriteCommentViewController: UIViewController
{
    let writeCommentView = WriteCommentView()
    var bookID: Int = 0
    var currentUserComment: Comment?
    var allCommentReloadDataDelegate: allCommentReloadDataDelegate?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setAlreadyCommentScreen()
    }
    
    override func loadView()
    {
        self.view = writeCommentView
    }
    
    func setAlreadyCommentScreen()
    {
        if let currentUsercomment = self.currentUserComment
        {
            writeCommentView.sendCommentButton.setTitle("刪除留言", for: .normal)
            writeCommentView.sendCommentButton.backgroundColor = .red
            writeCommentView.sendCommentButtonAction = deleteComment
            setNavigationBar()
            setAlreadycommentDetail(userComment: currentUsercomment)
        }
        else
        {
            
            writeCommentView.sendCommentButtonAction = sendComment
        }
    }
    
    func setNavigationBar()
    {
        self.title = "評論"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        //Left Button
        let sideMenuButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(quitEditing))
        sideMenuButton.tintColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        self.navigationItem.leftBarButtonItem = sideMenuButton
        
        //Right Button
        let searchButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(editComment))
        searchButton.tintColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        self.navigationItem.rightBarButtonItem = searchButton
    }
    
    func setAlreadycommentDetail(userComment: Comment)
    {
        writeCommentView.commentEvaluationView.currentStarCount =  Float(userComment.rate)
        writeCommentView.commentTextView.text = userComment.comment
    }
    
    @objc func quitEditing()
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func editComment()
    {
        if let currentUsercomment = self.currentUserComment
        {
            let url = "comments/\(currentUsercomment.id)"
            let parameters = setCommentParameter()
            let headers = setCommentHeaders()
            
            APICaller.shared.sendBookComment(url: url, method: .put, headers: headers, parameters: parameters)
            { result in
                switch result
                {
                    case .success:
                        self.deleteOrEditCommentSuccessful(type: .edit, text: "修改留言成功")
                    case .failure(.alreadyComment(let errorMessage)):
                        self.presentAlert(alertText: errorMessage, mode: .cancelAlert)
                    case .failure(.commentError(let errorMessage)):
                        self.presentAlert(alertText: errorMessage, mode: .cancelAlert)
                }
            }
        }
    }
    
    func deleteOrEditCommentSuccessful(type: CommentType, text: String)
    {
        self.allCommentReloadDataDelegate?.allCommentReloadData(type: type)
        presentAlert(alertText: text, mode: .cancelAlertAndDismissView)
    }
    
    func sendComment()
    {
        if writeCommentView.commentEvaluationView.currentStarCount != 0.0
        {
            let url = "books/\(bookID)/comment"
            let parameters = setCommentParameter()
            let headers = setCommentHeaders()
            
            APICaller.shared.sendBookComment(url: url, method: .post, headers: headers, parameters: parameters)
            { result in
                switch result
                {
                    case .success:
                        self.presentAlert(alertText: "留言成功", mode: .cancelAlertAndPopView)
                    case .failure(.alreadyComment(let errorMessage)):
                        self.presentAlert(alertText: errorMessage, mode: .cancelAlert)
                    case .failure(.commentError(let errorMessage)):
                        self.presentAlert(alertText: errorMessage, mode: .cancelAlert)
                }
            }
        }
        else
        {
            presentAlert(alertText: "評價分數不可為0", mode: .cancelAlert)
        }
    }
    
    func setCommentParameter() -> [String: Any]
    {
        let commentParameter: [String : Any] =
        [
            "rate": writeCommentView.commentEvaluationView.currentStarCount,
            "comment": writeCommentView.commentTextView.text ?? ""
        ]
        print(commentParameter)
        return commentParameter
    }
    
    func setCommentHeaders() -> HTTPHeaders
    {
        let headers: HTTPHeaders =
        [
            "Accept": "application/json",
            "Authorization": "Bearer \(userInformation!.token)"
        ]
        return headers
    }
    
    func deleteComment()
    {
        if let currentUsercomment = self.currentUserComment
        {
            let url = "comments/\(currentUsercomment.id)"
            let headers = setCommentHeaders()
            
            APICaller.shared.deleteBookComment(url: url, method: .delete, headers: headers)
            { result in
                switch result
                {
                    case .success:
                        self.deleteOrEditCommentSuccessful(type: .delete, text: "刪除留言成功")
                    case.fail:
                        break
                }
            }
        }
    }
}

enum CommentType
{
    case delete, edit
}
