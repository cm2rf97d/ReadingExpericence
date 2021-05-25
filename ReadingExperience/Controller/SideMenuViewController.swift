//
//  SideModeViewController.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/5/20.
//

import UIKit

protocol pushRegisterMainViewDelegate
{
    func pushRegisterMainView()
}

class SideMenuViewController: UIViewController
{
    var pushRegisterMainViewDelegate: pushRegisterMainViewDelegate?
    let sideMenuView = SideMenuView()
    let sideMenuDetail = ["會員登入"]
    
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
        if indexPath.row == 0
        {
            pushRegisterMainViewDelegate?.pushRegisterMainView()
        }
    }
}
