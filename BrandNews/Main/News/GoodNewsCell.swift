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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        newsCollectionView.register(UINib(nibName: "NewsHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "newsHeader")
        newsCollectionView.register(UINib(nibName: "NewsCell", bundle: nil), forCellWithReuseIdentifier: "newsCell")
    }
}
