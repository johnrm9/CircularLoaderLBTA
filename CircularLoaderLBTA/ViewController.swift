//
//  ViewController.swift
//  CircularLoaderLBTA
//
//  Created by John Martin on 12/9/17.
//  Copyright © 2017 John Martin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let shapeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.red.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = 10
        layer.lineCap = kCALineCapRound
        layer.strokeEnd = 0
        return layer
    }()
    
    let trackLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.lightGray.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = 10
        return layer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        let center = view.center
        
        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -.pi/2, endAngle: 2 * .pi, clockwise: true)
        
        shapeLayer.path = circularPath.cgPath
        trackLayer.path = circularPath.cgPath
        
        view.layer.addSublayer(trackLayer)
        view.layer.addSublayer(shapeLayer)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(_:))))
    }

    @objc private func handleTap(_ recognizer: UITapGestureRecognizer) {

        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = 1
        basicAnimation.duration = 2
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "basicAnimation")
    }
}

