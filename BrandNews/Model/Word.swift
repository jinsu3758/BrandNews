//
//  Word.swift
//  BrandNews
//
//  Created by 박진수 on 08/05/2019.
//  Copyright © 2019 박진수. All rights reserved.
//

import Foundation

struct Word {
    let sentence: String
    let frequency: Int
    
    init(sentence: String, frequency: Int) {
        self.sentence = sentence
        self.frequency = frequency
    }
}
