//
//  BookListTableViewCell.swift
//  ReadingExperience
//
//  Created by 陳郁勳 on 2021/5/30.
//

import UIKit

protocol gotoBookDetailDelegate
{
    func gotoBookDetail(index: Int)
}

class BookListTableViewCell: UITableViewCell
{
    static let identifier = "BookListTableViewCell"
    var gotoBookDetailDelegate: gotoBookDetailDelegate?
    let bookListCollectionViewHeight: Double = 180
    var bookDatas: [BookListData] = []
    {
        didSet
        {
            bookListCollectionView.reloadData()
        }
    }
    
    lazy var bookListCollectionView: UICollectionView =
    {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: 110.0, height: bookListCollectionViewHeight)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.register(BookListCollectionViewCell.self, forCellWithReuseIdentifier: BookListCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bookListCollectionView)
        self.backgroundColor = .clear
        layouts()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layouts()
    {
        bookListCollectionView.snp.makeConstraints
        { (make) in
            make.top.equalTo(self).offset(-3)
            make.left.right.bottom.equalTo(self)
        }
    }
}

extension BookListTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return bookDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookListCollectionViewCell.identifier, for: indexPath) as? BookListCollectionViewCell else {return UICollectionViewCell()}
        let bookDatasCell = bookDatas[indexPath.row]
        
        if let url = URL(string: bookDatasCell.image ?? "")
        {
            cell.bookImage.loadImage(url: url)
        }
        cell.bookTitle.text = bookDatasCell.bookname
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        gotoBookDetailDelegate?.gotoBookDetail(index: bookDatas[indexPath.row].id - 1)
    }
}
