//
//  WordCloudFlowLayout.swift
//  BrandNews
//
//  Created by 박진수 on 08/05/2019.
//  Copyright © 2019 박진수. All rights reserved.
//

import UIKit

class WordCloudFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let superAttributes = super.layoutAttributesForElements(in: rect) else { return nil }
        guard let attributes = NSArray(array: superAttributes, copyItems: true) as? [UICollectionViewLayoutAttributes] else { return nil }
        
        let interItemSpacing = minimumInteritemSpacing
        
        // Tracking values
        var maxY: CGFloat = -1.0 // to Know when the line breaks
        var rowWidth: CGFloat = 0
        var rowWidthList: [CGFloat] = []
        var currentRow: Int = -1
        
        //get the row width
        attributes.forEach { layoutAttribute in
            
            // Each layoutAttribute represents its own item
            if layoutAttribute.frame.origin.y >= maxY {
                currentRow += 1
                maxY = layoutAttribute.frame.maxY
                rowWidth = 0
                rowWidthList.append(0)
            }
            
            rowWidth += layoutAttribute.frame.width
            rowWidthList[currentRow] = rowWidth
            rowWidth += interItemSpacing
            
        }
        
        // using Row Width. make first item of the row's x the value it should be when center aligned
        // Then, locate following items having the minimum inter item spacing to the lft item
        var leftMargin: CGFloat = 0 // to set attribute's frame.x
        maxY = -1.0
        currentRow = -1
        attributes.forEach { layoutAttribute in
            
            // Each layoutAttribute is its own item
            if layoutAttribute.frame.origin.y >= maxY {
                currentRow += 1
                maxY = layoutAttribute.frame.maxY
                leftMargin = (collectionView!.frame.width - rowWidthList[currentRow])/2
            }
            
            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += interItemSpacing + layoutAttribute.frame.width
            
            //vertically center
            if let collectionView = collectionView {
                let topInset = (collectionView.frame.size.height - collectionViewContentSize.height) / 2
                collectionView.contentInset = UIEdgeInsets(top: topInset, left: 0, bottom: 0, right: 0)
            }
        }
        
        return attributes
    }
}
