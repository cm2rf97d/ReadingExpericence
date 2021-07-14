//
//  ProfileViewController.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/5/25.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    let profileView = ProfileView()
    let imagePicker = UIImagePickerController()
    var profileImageName: Data!
    var url = "http://52.196.162.105/api/profile/"
    var profileInfo: ProfileUserData?
    {
        didSet
        {
            profileView.profileBookCollectionView.reloadData()
            if let profileInfo = self.profileInfo
            {
                if let profileImage = URL(string: profileInfo.user.image ?? "" )
                {
                    self.profileView.profileImage.loadImage(url: profileImage)
                }
                profileView.profileCommentCountLabel.text = "已評論書籍數量 : \(profileInfo.user.comments.count)"
            }
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setImagePicker()
        setActionAndDelegate()
    }
    
    override func loadView()
    {
        self.view = profileView
    }
    
    func setImagePicker()
    {
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
    }
    
    func setActionAndDelegate()
    {
        profileView.logOutButtonAction = userLogOut
        profileView.profileImageAction = changeProfileImage
        profileView.profileBookCollectionView.delegate = self
        profileView.profileBookCollectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        if let user = userInformation
        {
            getProfileData(userId: "\(user.user.id)")
            profileView.logOutButton.isHidden = false
            profileView.profileNameLabel.text = user.user.name
        }
    }
    
    func getProfileData(userId: String)
    {
        APICaller.shared.getProfileData(url: "profile/\(userId)", headersTitle: "Authorization", headersContent: "Bearer \(userInformation!.token)")
        { result in
            switch result
            {
                case .success(let profileData):
                    self.profileInfo = profileData
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func userLogOut()
    {
        APICaller.shared.userLogOut(url: "logout", headersTitle: "Authorization", headersContent: "Bearer \(userInformation!.token)")
        { result in
            if result == .success
            {
                DispatchQueue.main.async
                {
                    userInformation = nil
                    self.presentAlert(alertText: "登出成功", mode: .cancelAlertAndPopToRootView)
                }
            }
        }
    }
    
    @objc func changeProfileImage()
    {
        print("Step 1. Choose Picture")
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func uploadProfileImage()
    {
        print("Step 3. Upload Picture")
        if let user = userInformation
        {
            let basePostURL = "http://52.196.162.105/api/profile/\(user.user.id)/photo?_method=PUT"
            let image = UIImage(data: self.profileImageName)
            if let imagee = image
            {
                let uploadData = imagee.jpegData(compressionQuality: 1.0)
                let dataPath = ["image":uploadData!]
                let postFormData = ["para1":"value1"]
                
                requestWithFormData(urlString: basePostURL, parameters: postFormData, dataPath: dataPath)
                { (data) in
                    DispatchQueue.main.async
                    {
                        print("getporfile")
                        self.getProfileData(userId: "\(user.user.id)")
                    }
                }
            }
        }
    }
    
    func requestWithFormData(urlString: String, parameters: [String: Any], dataPath: [String: Data], completion: @escaping (Data) -> Void)
    {
        print("Step 4. Start Upload Picture")
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(userInformation!.token)", forHTTPHeaderField: "Authorization")
        request.addValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
        let boundary = "Boundary+\(arc4random())\(arc4random())"
        var body = Data()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        for (key, value) in dataPath
        {
            body.appendString(string: "--\(boundary)\r\n")
            body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(arc4random())\"\r\n") //此處放入file name，以隨機數代替，可自行放入
            body.appendString(string: "Content-Type: image/jpg\r\n\r\n") //image/png 可改為其他檔案類型 ex:jpeg
            body.append(value)
            body.appendString(string: "\r\n")
        }
        
        body.appendString(string: "--\(boundary)--\r\n")
        request.httpBody = body
        
        fetchedDataByDataTask(from: request, completion: completion)
    }
    
    private func fetchedDataByDataTask(from request: URLRequest, completion: @escaping (Data) -> Void)
    {
        print("Step 5. Start Upload Picture 2")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil
            {
                print(error as Any)
            }
            else if let response = response as? HTTPURLResponse, let data = data
            {
                if response.statusCode == 200
                {
                    print("upload Image Success")
                    completion(data)
                }
                else
                {
                    print("response.statusCode = \(response.statusCode)")
                }
            }
            else
            {
                guard data != nil else{return}
                
            }
        }
        task.resume()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        print("Step 2. Choosed Picture Finish")
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        {
            guard let dataImg = image.jpegData(compressionQuality: 1.0) else { return }
            self.profileImageName = dataImg
            self.dismiss(animated: true)
            {
                self.uploadProfileImage()
            }
        }
    }
}

extension Data
{
    func parseData() -> NSDictionary
    {
        
        let dataDict = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers) as? NSDictionary
        
        return dataDict!
    }
    
    mutating func appendString(string: String)
    {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if let profileInfo = profileInfo
        {
            return profileInfo.user.comments.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookListCollectionViewCell.identifier, for: indexPath) as? BookListCollectionViewCell else {return UICollectionViewCell()}
        if let profileInfo = profileInfo
        {
            let profileBook = profileInfo.user.comments[indexPath.row].book
            
            if let url = URL(string: profileBook.image)
            {
                cell.bookImage.image = nil
                cell.bookImage.loadImage(url: url)
            }
            cell.bookTitle.text = profileBook.bookname
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if let profileInfo = profileInfo
        {
            let profileBookId = profileInfo.user.comments[indexPath.row].bookID
            let vc = BookDetailViewController()
            vc.bookId = profileBookId
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
