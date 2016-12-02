//
//  SpinningCollectionViewLayoutAttributes.swift
//
//  Created by Ugur Kilic on 27/11/2016.
//  Copyright © 2016 urklc. All rights reserved.
//

import UIKit

class SpinningCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
    var anchorPoint = CGPoint(x: 0.5, y: 0.5)
    var angle: CGFloat = 0 {

        didSet {
            zIndex = Int(angle * 1000000)
            transform = CGAffineTransform(rotationAngle: angle)
        }
    }

    override func copy(with zone: NSZone? = nil) -> Any {
        let copiedAttributes: SpinningCollectionViewLayoutAttributes =
            super.copy(with: zone) as! SpinningCollectionViewLayoutAttributes
        copiedAttributes.anchorPoint = self.anchorPoint
        copiedAttributes.angle = self.angle
        return copiedAttributes
    }
}

