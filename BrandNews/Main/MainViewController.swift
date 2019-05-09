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
    
    private var pageVC = UIPageViewController()
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
        newsCollectionView.register(UINib(nibName: "GoodNewsCell", bundle: nil), forCellWithReuseIdentifier: "mainNewsCell")
        if let flowLayout = newsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        newsCollectionView.delegate = self
        newsCollectionView.dataSource = self
    }
    
//    override func viewDidLayoutSubviews() {
//        let goodGradientLayer = CAGradientLayer()
//        let badGradientLayer = CAGradientLayer()
//        goodGradientLayer.cornerRadius = 10
//        badGradientLayer.cornerRadius = 10
//        goodGradientLayer.frame = goodView.bounds
//        goodGradientLayer.colors = [UIColor.sapphire.cgColor, UIColor.darkSkyBlue.cgColor]
//        badGradientLayer.frame = badView.bounds
//        badGradientLayer.colors = [UIColor.vermillion.cgColor, UIColor.orange.cgColor]
//        goodView.layer.addSublayer(goodGradientLayer)
//        badView.layer.addSublayer(badGradientLayer)
//        goodView.layer.cornerRadius = 10
//    }
    
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainNewsCell", for: indexPath)
        if let goodCell = cell as? GoodNewsCell {
            goodCell
        }
    }
    
    
}
