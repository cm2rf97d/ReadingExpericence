//
//  SideModeViewController.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/5/20.
//

import UIKit

protocol pushRelateViewDelegate
{
    func pushRegisterMainView()
    func pushProfileView()
    func popToRootView()
}

class SideMenuViewController: UIViewController
{
    var pushRegisterMainViewDelegate: pushRelateViewDelegate?
    let sideMenuView = SideMenuView()
    let sideMenuDetail = ["主頁", "會員登入", "個人頁面"]
    var userInfomationData: UserData?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        sideMenuView.sideMenuTableView.delegate = self
        sideMenuView.sideMenuTableView.dataSource = self
    }
    
    override func loadView()
    {
        self.view = sideMenuView
    }
    
    
    func choosePushController()
    {
        if userInformation == nil
        {
            pushRegisterMainViewDelegate?.pushRegisterMainView()
        }
        else
        {
            pushRegisterMainViewDelegate?.pushProfileView()
        }
    }
}

extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return sideMenuDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuTableViewCell.identifier, for: indexPath) as? SideMenuTableViewCell else {return UITableViewCell()}
        cell.titleLabel.text = sideMenuDetail[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        switch indexPath.row
        {
            case 0:
                pushRegisterMainViewDelegate?.popToRootView()
            case 1:
                choosePushController()
            case 2:
                choosePushController()
            default:
                break
        }
    }
}

extension SideMenuViewController: transferDataToSideMenuDelegate
{
    func transferDataToSideMenu(data: UserData)
    {
        self.userInfomationData = data
    }
}
