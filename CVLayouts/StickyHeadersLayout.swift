//
//  StickyHeadersLayout.swift
//  Camera Roll
//
//  Created by Mic Pringle on 18/03/2015.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

import UIKit

class StickyHeadersLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

        var layoutAttributes = super.layoutAttributesForElements(in: rect) as! [UICollectionViewLayoutAttributes]
    
    let headersNeedingLayout = NSMutableIndexSet()
    for attributes in layoutAttributes {
        if attributes.representedElementCategory == .cell {
            headersNeedingLayout.add(attributes.indexPath.section)
      }
    }
        for attributes in layoutAttributes {
            if let elementKind = attributes.representedElementKind {
                if elementKind == UICollectionElementKindSectionHeader {
                    headersNeedingLayout.remove(attributes.indexPath.section)
                }
            }
        }
        headersNeedingLayout.enumerate { (index, stop) -> Void in
            let indexPath = IndexPath(item: 0, section: index)
            let attributes = super.layoutAttributesForSupplementaryView(ofKind: UICollectionElementKindSectionHeader, at: indexPath)
            layoutAttributes.append(attributes!)
        }

        for attributes in layoutAttributes {
            if let elementKind = attributes.representedElementKind {
                if elementKind == UICollectionElementKindSectionHeader {
                    let section = attributes.indexPath.section
                    let attributesForFirstItemInSection = layoutAttributesForItem(at: IndexPath(item: 0, section: section))
                    let attributesForLastItemInSection = layoutAttributesForItem(at: IndexPath(item: collectionView!.numberOfItems(inSection: section) - 1, section: section))
          var frame = attributes.frame
          let offset = collectionView!.contentOffset.y
          
          /* The header should never go further up than one-header-height above
             the upper bounds of the first cell in the current section */
          let minY = attributesForFirstItemInSection!.frame.minY - frame.height
          /* The header should never go further down than one-header-height above
             the lower bounds of the last cell in the section */
          let maxY = attributesForLastItemInSection!.frame.maxY - frame.height
          /* If it doesn't break either of those two rules then it should be 
             positioned using the y value of the content offset */
          let y = min(max(offset, minY), maxY)
          
          frame.origin.y = y
          attributes.frame = frame
          attributes.zIndex = 99
        }
      }
    }
    
    return layoutAttributes
  }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
  
  
}
