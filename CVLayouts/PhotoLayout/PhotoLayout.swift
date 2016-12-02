//
//  PhotoLayout.swift
//
//  Created by Ugur Kilic on 26/11/2016.
//  Copyright © 2016 urklc. All rights reserved.
//

import UIKit

protocol PhotoLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView!, isFullSizedItemFor indexPath: IndexPath) -> Bool
}

class PhotoLayout: UICollectionViewLayout {

    var delegate: PhotoLayoutDelegate!
    var cellPadding: CGFloat = 2
    var numberOfRows = 2

    private var width: CGFloat {
        get {
            let insets = collectionView!.contentInset
            return collectionView!.bounds.width - (insets.left + insets.right)
        }
    }
    private var contentWidth: CGFloat = 0

    private var cache = [UICollectionViewLayoutAttributes]()

    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: collectionView!.bounds.height)
    }

    override func prepare() {
        if cache.isEmpty {
            let cellEdgeSize = (collectionView!.bounds.height) / CGFloat(numberOfRows) - cellPadding

            var yOffset: CGFloat = cellPadding
            var xOffset: CGFloat = cellPadding

            var row = 0
            for item in 0..<collectionView!.numberOfItems(inSection: 0) {
                let indexPath = IndexPath(item: item, section: 0)

                var width: CGFloat = cellEdgeSize
                var height: CGFloat = cellEdgeSize
                if self.delegate.collectionView(collectionView!, isFullSizedItemFor: indexPath) {
                    width = collectionView!.bounds.height - (2 * cellPadding)
                    height = width
                }

                let frame = CGRect(x: xOffset, y: yOffset, width: width, height: height)
                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)

                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = insetFrame
                cache.append(attributes)

                if self.delegate.collectionView(collectionView!, isFullSizedItemFor: indexPath) {
                    xOffset = xOffset + width
                    yOffset = cellPadding
                    row = 0
                } else {
                    if row >= (numberOfRows - 1) {
                        xOffset = xOffset + width
                        yOffset = cellPadding
                        row = 0
                    } else {
                        yOffset = yOffset + width
                        row = row + 1
                    }
                }
            }

            contentWidth = xOffset;
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    
    
    
}
