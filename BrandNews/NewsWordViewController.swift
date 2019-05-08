//
//  NewsWordViewController.swift
//  BrandNews
//
//  Created by 박진수 on 08/05/2019.
//  Copyright © 2019 박진수. All rights reserved.
//

import UIKit

class NewsWordViewController: UIViewController {
    @IBOutlet weak var wordCollectionView: UICollectionView!
    
    private var wordList: [Word] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        if let flowLayout = self.wordCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        wordCollectionView.dataSource = self
        wordCollectionView.delegate = self
        setList()
    }
    
    private func setList() {
        wordList.append(Word(sentence: "ee", frequency: 100))
        wordList.append(Word(sentence: "wer", frequency: 50))
        wordList.append(Word(sentence: "ewrq", frequency: 10))
        wordList.append(Word(sentence: "fsre1", frequency: 30))
        wordList.append(Word(sentence: "324", frequency: 70))
        wordList.append(Word(sentence: "ewrq", frequency: 120))
        wordList.append(Word(sentence: "fsre1", frequency: 10))
        wordList.append(Word(sentence: "324", frequency: 180))
        wordList.append(Word(sentence: "324", frequency: 120))
        wordList.append(Word(sentence: "ewrq", frequency: 10))
        wordList.append(Word(sentence: "fsre1", frequency: 30))
        wordList.append(Word(sentence: "324", frequency: 70))
        wordCollectionView.reloadData()
    }
    

}

extension NewsWordViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wordList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        if let sentenceLabel = cell.contentView.subviews.first as? UILabel {
            sentenceLabel.text = wordList[indexPath.row].sentence
            
            let frequencyList = wordList.map{$0.frequency}
            let maxFrequency = frequencyList.max()
            let minFrequency = frequencyList.min()
            let maxFontSize:CGFloat = 36
            let minFontSize:CGFloat = 12
            let maxAlpha:CGFloat = 1
            let minAlpha:CGFloat = 0.5
            
            let fontSize = self.calculateItemValue(minValue: minFontSize, maxValue: maxFontSize, itemFrequency: wordList[indexPath.row].frequency, minFrequency: minFrequency!, maxFrequency: maxFrequency!)
            sentenceLabel.font = sentenceLabel.font.withSize(fontSize)
            
            sentenceLabel.alpha = self.calculateItemValue(minValue: minAlpha, maxValue: maxAlpha, itemFrequency: wordList[indexPath.row].frequency, minFrequency: minFrequency!, maxFrequency: maxFrequency!)
        }
        
        return cell
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
