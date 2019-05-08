//
//  WordCell.swift
//  BrandNews
//
//  Created by 박진수 on 08/05/2019.
//  Copyright © 2019 박진수. All rights reserved.
//

import UIKit

class WordCell: UICollectionViewCell {
    @IBOutlet weak var wordLabel: UILabel!
//    var frequencyList: [Int] = []
    var maxFrequency:Int = 0
    var minFrequency:Int = 0
    
    let maxFontSize:CGFloat = 36
    let minFontSize:CGFloat = 12
    let maxAlpha:CGFloat = 1
    let minAlpha:CGFloat = 0.5
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func fill(word: Word, frequencyList: [Int]) {
        
        maxFrequency = frequencyList.max() ?? 0
        minFrequency = frequencyList.min() ?? 0
        wordLabel.text = word.sentence
        let fontSize = self.calculateItemValue(minValue: minFontSize, maxValue: maxFontSize, itemFrequency: word.frequency, minFrequency: minFrequency, maxFrequency: maxFrequency)
        wordLabel.font = wordLabel.font.withSize(fontSize)
        
        wordLabel.alpha = self.calculateItemValue(minValue: minAlpha, maxValue: maxAlpha, itemFrequency: word.frequency, minFrequency: minFrequency, maxFrequency: maxFrequency)
    }
    
    func calculateItemValue(minValue: CGFloat, maxValue: CGFloat, itemFrequency: Int, minFrequency: Int, maxFrequency: Int) -> CGFloat {
        if maxFrequency == minFrequency {
            return (maxValue + minValue)/2
        }
        let itemFrequency = CGFloat(itemFrequency)
        let minFrequency = CGFloat(minFrequency)
        let maxFrequency = CGFloat(maxFrequency)
        
        let a = (maxValue - minValue)/(maxFrequency-minFrequency)
        let b = (maxFrequency*minValue-minFrequency*maxValue)/(maxFrequency - minFrequency)
        return a*itemFrequency + b
    }
}
