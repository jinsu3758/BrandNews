//
//  ViewController.swift
//  BrandNews
//
//  Created by 박진수 on 08/05/2019.
//  Copyright © 2019 박진수. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyFieldLabel: UILabel!
    @IBOutlet weak var goodView: UIView!
    @IBOutlet weak var badView: UIView!
    @IBOutlet weak var badGoodView: UIView!
    @IBOutlet weak var newsCollectionView: UICollectionView!
    @IBOutlet weak var newsCollectionViewHeightConstraint: NSLayoutConstraint!
    
    private var pageVC = UIPageViewController()
    private var cellHeight: CGFloat = 0
    var newsList: [NewsCard] = []
    
    lazy var pageArray: [UIViewController] = {
        return [getVC(name: "news"), getVC(name: "brand")]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        statusBar.backgroundColor = .dark
        pageVC.setViewControllers([pageArray[0]], direction: .forward, animated: true, completion: nil)
        pageVC.delegate = self
        pageVC.dataSource = self
        pageControl.currentPage = pageArray.count
        newsCollectionView.register(UINib(nibName: "GoodNewsCell", bundle: nil), forCellWithReuseIdentifier: "goodNewsCell")
        newsCollectionView.register(UINib(nibName: "BadNewsCell", bundle: nil), forCellWithReuseIdentifier: "badNewsCell")
        if let flowLayout = newsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        newsCollectionView.delegate = self
        newsCollectionView.dataSource = self
        
        let list = [News(title: "ee", content: "ee", company: "ee"), News(title: "ee", content: "ee", company: "ee"),
        News(title: "ee", content: "ee", company: "ee"), News(title: "ee", content: "ee", company: "ee")]
        let cardList = [NewsCard(list: list, isGood: true), NewsCard(list: list, isGood: false), NewsCard(list: list, isGood: true)]
        newsList = cardList
        newsCollectionView.reloadData()
        newsCollectionViewHeightConstraint.constant = newsCollectionView.collectionViewLayout.collectionViewContentSize.height
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let container = segue.destination as? UIPageViewController {
            pageVC = container
        }
    }
    
    private func getVC(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: name)
    }


}

extension MainViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pageArray.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        
        guard previousIndex >= 0 else { return pageArray.last }
        guard pageArray.count > previousIndex else { return nil }
        return pageArray[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pageArray.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        
        guard nextIndex < pageArray.count else { return pageArray.first }
        guard pageArray.count > nextIndex else { return nil }
        return pageArray[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        if let page = self.pageArray.firstIndex(of: pendingViewControllers[0]) {
            pageControl.currentPage = page
        }
    }
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageArray.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if newsList[indexPath.item].isGood, let goodCell = collectionView.dequeueReusableCell(withReuseIdentifier: "goodNewsCell", for: indexPath) as? GoodNewsCell {
            goodCell.fill(list: newsList[indexPath.item].list)
            return goodCell
        }
        else if let badCell = collectionView.dequeueReusableCell(withReuseIdentifier: "badNewsCell", for: indexPath) as? BadNewsCell {
            badCell.fill(list: newsList[indexPath.item].list)
            return badCell
        }
      
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        let edgeInset = self.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAt: indexPath.section)
//        let width = collectionView.frame.width * 304 / 375
        let newsCount = newsList[indexPath.item].list.count
        let height = 85.5 + CGFloat(newsCount * 35)
        return CGSize(width: collectionView.frame.width, height: height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 9.5
    }
    
    
}

