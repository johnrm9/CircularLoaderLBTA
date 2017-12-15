//
//  Extensions.swift
//  CircularLoaderLBTA
//
//  Created by John Martin on 12/13/17.
//  Copyright © 2017 John Martin. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    static let backgroundColor = UIColor.rgb(r: 21, g: 22, b: 33)
    static let outlineStrokeColor = UIColor.rgb(r: 234, g: 46, b: 111)
    static let trackStrokeColor = UIColor.rgb(r: 56, g: 25, b: 49)
    static let pulsatingFillColor = UIColor.rgb(r: 86, g: 30, b: 63)
}

extension UIView{
    func addSubLayers(_ layers: CAShapeLayer...) {
        layers.forEach { self.layer.addSublayer($0) }
    }
}

extension CATransform3D {
    static func rotateBy(_ angle: CGFloat) -> CATransform3D {
        return CATransform3DMakeRotation(angle, 0, 0, 1)
    }
}
