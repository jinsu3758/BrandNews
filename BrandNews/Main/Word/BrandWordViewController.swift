//
//  BrandWordViewController.swift
//  BrandNews
//
//  Created by 박진수 on 08/05/2019.
//  Copyright © 2019 박진수. All rights reserved.
//

import UIKit

class BrandWordViewController: UIViewController {
    @IBOutlet weak var wordCollectionView: UICollectionView!
    @IBOutlet weak var ovalView: UIView!
    
    private var wordList: [Word] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ovalView.layer.cornerRadius = 9.3
        wordCollectionView.register(UINib.init(nibName: "WordCell", bundle: nil), forCellWithReuseIdentifier: "cell")
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

extension BrandWordViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wordList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? WordCell {
            let frequencyList = wordList.map{$0.frequency}
            cell.fill(word: wordList[indexPath.row], frequencyList: frequencyList)
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

}
