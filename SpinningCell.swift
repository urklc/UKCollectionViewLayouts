//
//  SpinningCell.swift
//
//  Created by Ugur Kilic on 24/11/2016.
//  Copyright © 2016 urklc. All rights reserved.
//

import UIKit

class SpinningCell: UICollectionViewCell {
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)

        let spinningLayoutAttributes = layoutAttributes as! SpinningCollectionViewLayoutAttributes
        self.layer.anchorPoint = spinningLayoutAttributes.anchorPoint
        self.center.y += (spinningLayoutAttributes.anchorPoint.y - 0.5) * self.bounds.height
    }
}

