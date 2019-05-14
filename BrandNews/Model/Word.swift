//
//  Word.swift
//  BrandNews
//
//  Created by 박진수 on 08/05/2019.
//  Copyright © 2019 박진수. All rights reserved.
//

import Foundation

enum WordCategory {
    case good
    case bad
    case place
    case institute
    case person
    case rest
}

struct Word {
    let sentence: String
    let frequency: Int
    let category: WordCategory
}
