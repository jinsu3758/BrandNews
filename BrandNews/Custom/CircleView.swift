//
//  CircleView.swift
//  BrandNews
//
//  Created by 박진수 on 08/05/2019.
//  Copyright © 2019 박진수. All rights reserved.
//

import UIKit

class CircleView: UIView {

    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.width / 2
    }

}
