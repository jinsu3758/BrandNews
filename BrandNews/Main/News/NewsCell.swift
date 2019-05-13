//
//  NewsCell.swift
//  BrandNews
//
//  Created by 박진수 on 09/05/2019.
//  Copyright © 2019 박진수. All rights reserved.
//

import UIKit

class NewsCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    
    func fill(_ news: News) {
        titleLabel.text = news.title
        companyLabel.text = news.company
    }
}
