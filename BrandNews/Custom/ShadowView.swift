//
//  ShadowView.swift
//  BrandNews
//
//  Created by 박진수 on 08/05/2019.
//  Copyright © 2019 박진수. All rights reserved.
//

import UIKit

class ShadowView: UIView {

    override func awakeFromNib() {
        self.layer.setShadow(color: .veryDarkBrown7, alpha: 1, x: 0, y: 0, blur: 4, spread: 1.1)
    }

}
