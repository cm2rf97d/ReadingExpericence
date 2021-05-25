//
//  HomePageViewController.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/5/17.
//

import UIKit

class HomePageViewController: UIViewController
{
    let homePageView = HomePageView()
    var bookDatas: [BookData] = []
    {
        didSet
        {
            homePageView.homePageCollectionView.reloadData()
        }
    }
    let url = "http://52.196.162.105/api/books"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        homePageView.homePageCollectionView.delegate = self
        homePageView.homePageCollectionView.dataSource = self
        setNavigation()
        getBookData(urlString: url)
        { (data) in
            print(data)
        }
    }
    
    override func loadView()
    {
        self.view = homePageView
    }
    
    func setNavigation()
    {
        self.navigationItem.title = "Hello"
        let sideMenuButton = UIBarButtonItem(image: UIImage(systemName: "text.justify"), style: .plain, target: self, action: #selector(callSideMenu))
        self.navigationItem.leftBarButtonItem = sideMenuButton
    }
    
    func getBookData(urlString: String, completion: @escaping (Data) -> Void) -> Void
    {
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        fetchedDataByDataTask(from: request, completion: completion)
    }
    
    private func fetchedDataByDataTask(from request: URLRequest, completion: @escaping (Data) -> Void)
    {
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil
            {
                print(error as Any)
            }
            else if let response = response as? HTTPURLResponse, let data = data
            {
                let decoder = JSONDecoder()
                do
                {
                    if let cdata = try decoder.decode([BookData]?.self, from: data)
                    {
                        DispatchQueue.main.async
                        {
                            self.bookDatas = cdata
                        }
                    }
                }
                catch
                {
                    print(error)
                }
                completion(data)
            }
        }
        task.resume()
    }
    
    @objc func callSideMenu()
    {
        sideMenuController?.toggleLeftView()
    }
    
}

extension HomePageViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return bookDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomePageCollectionViewCell.identifier, for: indexPath) as? HomePageCollectionViewCell else {return UICollectionViewCell()}
        
        let bookDatasCell = bookDatas[indexPath.row]
        
        if let url = URL(string: bookDatasCell.image)
        {
            cell.bookImage.loadImage(url: url)
        }
        cell.bookTitle.text = bookDatasCell.bookname
        return cell
    }
}

extension HomePageViewController: pushRegisterMainViewDelegate
{
    func pushRegisterMainView()
    {
        self.navigationController?.pushViewController(RegisterMainViewController(), animated: true)
        sideMenuController?.hideLeftView()
    }
}
