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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let header1 = News(title: "네이버, LG유플러스와 AI기술로 사회적약자 돕는다", content: "네이버는 사회적 약자도 AI 기술 서비스를 쉽게 이용할 수 있도록 LG유플러스와 함께 지난해..", company: "네이버")
        let list1 = [News(title: "네이버, LG U+, 지체장애인 300명 AI 스피커 지원", content: "ee", company: "데이터넷"), News(title: "네이버와 LG U+, 지체장애인에게 음원이용권 전달", content: "ee", company: "대한금융지원")]
        
        let header2 = News(title: "구매직원 36억 횡령까지… 네이버에 무슨일이..", content: "인터넷업계 최강자 네이버가 흔들리고 있다. 네이버 창업 직후부터 일해 온 주요 임원들이...", company: "네이버")
        let list2 = [News(title: "회삿돈으로 호화 요트 구입 혐의’ CJ 이재환 대표 불구속 송치", content: "ee", company: "네이버뉴스"), News(title: "NHN, 총체적 위기 직면..", content: "ee", company: "아이뉴스24")]
        
        let header3 = News(title: "서울시-네이버, '교통약자·따릉이 길찾기 서비스' 개발", content: "네이버가 기존에 서비스하고 있는 최단시간, 최소 환승 중심 대중교통 경로 안내와 별도로 노약자나 장애인, 영유아 동반자, 무거운 짐을 든 관광객 등 '교통약자'를 위한 맞춤형 길찾기 및 내비게이션 기능을 네이버 교통안내 시스템에 추가한다", company: "네이버")
        let list3 = [News(title: "서울시+네이버, 교통약자·따릉이 길찾기 서비스 만든다", content: "뉴스토마토", company: "뉴스토마토"), News(title: "서울시-네이버 손잡고 교통약자·따릉이 길찾기 서비스 개발", content: "ee", company: "위클리오늘")]
        
        let cardList = [NewsCard(header: header1, list: list1, isGood: true, num: 1), NewsCard(header: header2, list: list2, isGood: false, num: 2), NewsCard(header: header3, list: list3, isGood: true, num: 3) ]
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
            goodCell.fill(news: newsList[indexPath.item])
            return goodCell
        }
        else if let badCell = collectionView.dequeueReusableCell(withReuseIdentifier: "badNewsCell", for: indexPath) as? BadNewsCell {
            badCell.fill(news: newsList[indexPath.item])
            return badCell
        }
      
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        let edgeInset = self.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAt: indexPath.section)
//        let width = collectionView.frame.width * 304 / 375
        let newsCount = newsList[indexPath.item].list.count
        let height = 85.5 + CGFloat(newsCount * 35)
        return CGSize(width: 321, height: height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 9.5
    }
    
    
}

