//
//  TimbreLayout.swift
//  RWDevCon
//
//  Created by Mic Pringle on 02/03/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit

func degreesToRadians(degrees: Double) -> CGFloat {
  return CGFloat(.pi * (degrees) / 180.0)
}

class TimbreLayout: UICollectionViewFlowLayout {

  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    let layoutAttributes = super.layoutAttributesForElements(in: rect)!
    for attributes in layoutAttributes {
      let frame = attributes.frame
        attributes.transform = CGAffineTransform(rotationAngle: degreesToRadians(degrees: -14))
        attributes.frame = frame.insetBy(dx: 12, dy: 0)
    }
    return layoutAttributes
  }
  
}
