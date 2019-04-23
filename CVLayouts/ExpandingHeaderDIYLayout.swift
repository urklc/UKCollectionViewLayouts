//
//  DIYLayout.swift
//  DIY
//
//  Created by Mic Pringle on 10/03/2015.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

import UIKit

class DIYLayoutAttributes: UICollectionViewLayoutAttributes {

    var deltaY: CGFloat = 0

    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! DIYLayoutAttributes
        copy.deltaY = deltaY
        return copy
    }

    override func isEqual(_ object: Any?) -> Bool {
        if let attributes = object as? DIYLayoutAttributes {
            if attributes.deltaY == deltaY {
                return super.isEqual(object)
            }
        }
        return false
    }
  
}

class DIYLayout: UICollectionViewFlowLayout {

    override class var layoutAttributesClass: AnyClass {
        return DIYLayoutAttributes.self
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect) as! [DIYLayoutAttributes]
        let insets = collectionView!.contentInset
        let offset = collectionView!.contentOffset
        let minY = -insets.top
        if (offset.y < minY) {
            let deltaY = fabs(offset.y - minY)
            for attributes in layoutAttributes {
                if let elementKind = attributes.representedElementKind {
                    if elementKind == UICollectionElementKindSectionHeader {
                        var frame = attributes.frame
                        frame.size.height = max(minY, headerReferenceSize.height + deltaY)
                        frame.origin.y = frame.minY - deltaY
                        attributes.frame = frame
                        attributes.deltaY = deltaY
                    }
                }
            }
        }
        return layoutAttributes
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
