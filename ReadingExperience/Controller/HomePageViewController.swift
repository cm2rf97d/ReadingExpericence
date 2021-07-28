//
//  HomePageViewController.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/6/10.
//

import UIKit

class HomePageViewController: UIViewController
{
    let homePageView = HomePageView()
    let pages = ["全部","商業理財","文學小說","藝術設計","人文史地","社會科學","自然科普","心理勵志",]
    var pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    var pageViewIndex: Int = 0
    var viewControllers = [HomeBookViewController(categoryId: .all),
                           HomeBookViewController(categoryId: .business),
                           HomeBookViewController(categoryId: .fiction),
                           HomeBookViewController(categoryId: .art),
                           HomeBookViewController(categoryId: .history),
                           HomeBookViewController(categoryId: .society),
                           HomeBookViewController(categoryId: .natural),
                           HomeBookViewController(categoryId: .psychology)]
    var startPosition: UITextPosition?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setDelegate()
        setNavigation()
        setPageViewController()
        startPosition = homePageView.searchTextField.beginningOfDocument
    }
    
    override func loadView()
    {
        self.view = homePageView
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2609430552, green: 0.2443105876, blue: 0.05599819124, alpha: 1)
    }
    
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        guard let bookName = textField.text else { return true }
        goSearchBook(bookName: bookName)
        return true
    }
    
    func goSearchBook(bookName: String)
    {
        if bookName == ""
        {
            self.presentAlert(alertText: "請輸入書名", mode: .cancelAlert)
        }
        else
        {
            let vc = SearchBookViewController()
            vc.searchBookName = bookName
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
//    {
//        UIView.animate(withDuration: 0.4, delay: 0, options: UIView.AnimationOptions.curveEaseIn, animations:
//        {
//               // HERE
//            self.homePageView.searchTextField.transform = CGAffineTransform.identity.scaledBy(x: 1.5, y: 1.5) // Scale your image
//        })
//        { (finished) in
//            UIView.animate(withDuration: 0.5, animations:
//            {
//                self.homePageView.searchTextField.transform = CGAffineTransform.identity // undo in 1 seconds
//           })
//        }
//        return true
//    }

    func setDelegate()
    {
        homePageView.searchTextField.delegate = self
        homePageView.homeCollectionView.delegate = self
        homePageView.homeCollectionView.dataSource = self
        homePageView.homeCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }
    
    func setNavigation()
    {
        self.navigationItem.titleView = homePageView.testView
        
        //Left Button
        let sideMenuButton = UIBarButtonItem(image: UIImage(systemName: "text.justify"), style: .plain, target: self, action: #selector(callSideMenu))
        sideMenuButton.tintColor = #colorLiteral(red: 0.9424498677, green: 0.8881112337, blue: 0.9064692855, alpha: 1)
        self.navigationItem.leftBarButtonItem = sideMenuButton
        
//        //Right Button
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchBook))
        searchButton.tintColor = #colorLiteral(red: 0.9424498677, green: 0.8881112337, blue: 0.9064692855, alpha: 1)
        self.navigationItem.rightBarButtonItem = searchButton
    }
    
    func setPageViewController()
    {
        view.addSubview(pageViewController.view)
        addChild(pageViewController)
        
        pageViewController.view.snp.makeConstraints
        { (make) in
            make.edges.equalTo(homePageView.bottomView)
        }
        
//        pageViewController.delegate = self
//        pageViewController.dataSource = self
        
        pageViewController.setViewControllers([viewControllers[pageViewIndex]], direction: .forward, animated: true)
    }
    
//    func pageViewToChange(index: Int) -> UIViewController?
//    {
//        if index < 0
//        {
//            return viewControllers.last
//        }
//        else if index > viewControllers.count - 1
//        {
//            return viewControllers.first
//        }
//        else
//        {
//            return viewControllers[index]
//        }
//    }

    @objc func callSideMenu()
    {
        sideMenuController?.toggleLeftView()
    }
    
    @objc func searchBook()
    {
        guard let bookName = homePageView.searchTextField.text else {return}
        goSearchBook(bookName: bookName)
    }
}

extension HomePageViewController: pushRelateViewDelegate
{
    func pushRegisterMainView()
    {
        self.navigationController?.pushViewController(RegisterMainViewController(), animated: true)
        sideMenuController?.hideLeftView()
    }
    
    func pushProfileView()
    {
        let vc = ProfileViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        sideMenuController?.hideLeftView()
    }
    
    func popToRootView()
    {
        self.navigationController?.popToRootViewController(animated: true)
        sideMenuController?.hideLeftView()
    }
}

extension HomePageViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomePageCollectionViewCell.identifier, for: indexPath) as? HomePageCollectionViewCell else {return UICollectionViewCell()}
        cell.pageLabel.text = pages[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: homePageView.homeCollectionView.frame.width / 5, height: homePageView.homeCollectionView.frame.height - 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if indexPath.item > pageViewIndex
        {
            pageViewIndex = indexPath.item
            pageViewController.setViewControllers([viewControllers[pageViewIndex]], direction: .forward, animated: true)
        }
        
        if indexPath.item < pageViewIndex
        {
            pageViewIndex = indexPath.item
            pageViewController.setViewControllers([viewControllers[pageViewIndex]], direction: .forward, animated: true)
        }
    }
}

//extension HomePageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource
//{
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
//    {
//        return pageViewToChange(index: pageViewIndex - 1)
//    }
//
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
//    {
//        return pageViewToChange(index: pageViewIndex + 1)
//    }
//
//    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool)
//    {
//        if finished
//        {
//            if completed
//            {
//                guard let vc = pageViewController.viewControllers?.first else {return}
//
//                pageViewIndex = vc.view.tag
//
//                homePageView.homeCollectionView.selectItem(at: IndexPath(item: pageViewIndex, section: 0), animated: true, scrollPosition: .centeredVertically)
//            }
//        }
//    }
//}

extension HomeBookViewController: gotoBookDetailDelegate
{
    func gotoBookDetail(index: Int)
    {
        print(index)
        let vc = BookDetailViewController()
        vc.bookId = index + 1
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
