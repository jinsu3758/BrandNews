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
        wordList.append(Word(sentence: "선행", frequency: 110, category: .good))
        wordList.append(Word(sentence: "송치", frequency: 120, category: .bad))
        wordList.append(Word(sentence: "공헌", frequency: 10, category: .good))
        wordList.append(Word(sentence: "연탄봉사", frequency: 180, category: .good))
        wordList.append(Word(sentence: "폭행", frequency: 30, category: .bad))
        wordList.append(Word(sentence: "기부", frequency: 200, category: .good))
        wordList.append(Word(sentence: "봉사", frequency: 30, category: .good))
        wordList.append(Word(sentence: "입막음", frequency: 10, category: .bad))
        wordList.append(Word(sentence: "위조", frequency: 70, category: .bad))
        wordList.append(Word(sentence: "횡령", frequency: 120, category: .bad))
        wordList.append(Word(sentence: "자선기부", frequency: 10, category: .good))
        wordList.append(Word(sentence: "지원", frequency: 70, category: .bad))
        wordCollectionView.reloadData()
    }

}

extension NewsWordViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
