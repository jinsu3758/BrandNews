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
        wordList.append(Word(sentence: "카카오톡", frequency: 100, category: .institute))
        wordList.append(Word(sentence: "판교", frequency: 50, category: .place))
        wordList.append(Word(sentence: "한성숙", frequency: 10, category: .person))
        wordList.append(Word(sentence: "라이브러리", frequency: 30, category: .rest))
        wordList.append(Word(sentence: "iOS", frequency: 70, category: .rest))
        wordList.append(Word(sentence: "송창현", frequency: 120, category: .person))
        wordList.append(Word(sentence: "일본", frequency: 10, category: .place))
        wordList.append(Word(sentence: "쿠팡", frequency: 180, category: .institute))
        wordList.append(Word(sentence: "배달의민족", frequency: 50, category: .institute))
        wordList.append(Word(sentence: "게임", frequency: 10, category: .rest))
        wordList.append(Word(sentence: "노래", frequency: 30, category: .rest))
        wordList.append(Word(sentence: "기안84", frequency: 70, category: .person))
        wordList.append(Word(sentence: "서울", frequency: 190, category: .place))
        wordList.append(Word(sentence: "네이버웹툰", frequency: 50, category: .institute))
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
