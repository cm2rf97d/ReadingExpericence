//
//  HomePageCollectionViewCell.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/6/10.
//

import UIKit

class HomePageCollectionViewCell: UICollectionViewCell
{
    static let identifier = "HomePageCollectionViewCell"
    
    let pageLabel: UILabel =
    {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        label.layer.backgroundColor = #colorLiteral(red: 0.6247964501, green: 0.6984365582, blue: 0.5420147181, alpha: 1).cgColor
        label.layer.cornerRadius = 21
        label.layer.borderWidth = 1
        label.layer.borderColor = #colorLiteral(red: 0.4512063265, green: 0.5094847679, blue: 0.3660366833, alpha: 1).cgColor
        label.layer.shadowOffset = CGSize(width: 5, height: 5)
        label.layer.shadowOpacity = 0.5
        label.layer.shadowRadius = 3
        label.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
    }()
    
    let displayTheCurrentPageView: UIView =
    {
        let view = UIView()
        return view
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        addSubview(pageLabel)
        addSubview(displayTheCurrentPageView)
        layouts()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layouts()
    {
        pageLabel.snp.makeConstraints
        { (make) in
            make.right.equalTo(self).offset(-5)
            make.left.equalTo(self).offset(5)
            make.top.equalTo(self)
            make.bottom.equalTo(self).offset(-10)
        }
        
        displayTheCurrentPageView.snp.makeConstraints
        { (make) in
            make.top.equalTo(pageLabel.snp.bottom)
            make.right.left.equalTo(pageLabel)
            make.bottom.equalTo(self)
        }
    }
    
    override var isSelected: Bool
    {
        didSet
        {
            DispatchQueue.main.async
            {
                UIView.animate(withDuration: 0.3)
                {
                    self.pageLabel.layer.backgroundColor = self.isSelected ? #colorLiteral(red: 0.4512063265, green: 0.5094847679, blue: 0.3660366833, alpha: 1).cgColor : #colorLiteral(red: 0.6247964501, green: 0.6984365582, blue: 0.5420147181, alpha: 1).cgColor
                    self.pageLabel.textColor = self.isSelected ? .white : .black
//                    self.displayTheCurrentPageView.backgroundColor = self.isSelected ? UIColor.red : UIColor.clear
                    self.layoutIfNeeded()
                }
            }
        }
    }
}
