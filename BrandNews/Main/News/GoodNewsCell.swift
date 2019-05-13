//
//  GoodNewsCell.swift
//  BrandNews
//
//  Created by 박진수 on 09/05/2019.
//  Copyright © 2019 박진수. All rights reserved.
//

import UIKit


class GoodNewsCell: UICollectionViewCell {
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var newsCollectionView: UICollectionView!
    @IBOutlet weak var dateLabel: UILabel!
    var newsList: [News] = []
    
    private let gradient = CAGradientLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        newsCollectionView.register(UINib(nibName: "NewsCell", bundle: nil), forCellWithReuseIdentifier: "newsCell")
        newsCollectionView.register(UINib(nibName: "NewsHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "newsHeader")
       
        newsCollectionView.delegate = self
        newsCollectionView.dataSource = self
        

    }
    
    
    func fill(list: [News]) {
        self.newsList = list
//        self.newsCollectionView.collectionViewLayout.invalidateLayout()
        self.newsCollectionView.reloadData()
        self.newsCollectionView.performBatchUpdates(nil, completion: { [unowned self] _ in
            self.gradient.frame = self.leftView.bounds
            self.gradient.colors = [UIColor.sapphire.cgColor, UIColor.darkSkyBlue.cgColor]
            self.leftView.layer.insertSublayer(self.gradient, at: 0)
        })
        self.newsCollectionView.reloadData()
    }
}

extension GoodNewsCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath)
        if let newsCell = cell as? NewsCell {
            //            if indexPath.item == newsList.count - 1 {
            //                newsCell.bottomView.isHidden = true
            //            }
            newsCell.fill(newsList[indexPath.item])
            return newsCell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "newsHeader", for: indexPath) as? NewsHeaderView else { fatalError()}
        header.layoutIfNeeded()
        header.titleLabel.text = "와우"
        header.contentLabel.text = "ee"
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 72)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
}
