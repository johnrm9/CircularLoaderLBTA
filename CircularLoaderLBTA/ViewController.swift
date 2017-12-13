//
//  ViewController.swift
//  CircularLoaderLBTA
//
//  Created by John Martin on 12/9/17.
//  Copyright © 2017 John Martin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var percentageLabel: UILabel = {
        let label = UILabel()
        label.text = "Start"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = .white
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        label.center = self.view.center
        self.view.addSubview(label)
        return label
    }()
    
    
    lazy var shapeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.red.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = 10
        layer.lineCap = kCALineCapRound
        layer.strokeEnd = 0
        layer.position = self.view.center
        layer.transform = CATransform3DMakeRotation(-.pi / 2, 0, 0, 1)
        return layer
    }()
    
    lazy var trackLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.lightGray.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = 10
        layer.position = self.view.center
        return layer
    }()
    
    let urlString =  "http://ipv4.download.thinkbroadband.com/5MB.zip"
    //let urlString = "https://firebasestorage.googleapis.com/v0/b/firestorechat-e64ac.appspot.com/o/intermediate_training_rec.mp4?alt=media&token=e20261d0-7219-49d2-b32d-367e1606500c"
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.backgroundColor
        
        //        view.addSubview(percentageLabel)
        //        percentageLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        //        percentageLabel.center = view.center
        
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        
        shapeLayer.path = circularPath.cgPath
        trackLayer.path = circularPath.cgPath
        
        view.layer.addSublayer(trackLayer)
        view.layer.addSublayer(shapeLayer)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(_:))))
    }
    
    fileprivate func animateCircle() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = 1
        basicAnimation.duration = 2
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "basicAnimation")
    }
    
    @objc private func handleTap(_ recognizer: UITapGestureRecognizer) {
        beginDownloadingFile()
        
        //animateCircle()
    }
}
extension ViewController: URLSessionDownloadDelegate {
    
    private func beginDownloadingFile() {
        print("Attempting to download file")
        
        shapeLayer.strokeEnd = 0
        
        //let operationQueue = OperationQueue()
        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        
        guard let url = URL(string: urlString) else { return }
        let downloadTask = urlSession.downloadTask(with: url)
        downloadTask.resume()
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Finished downloading file")
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let percentage = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)
        
        DispatchQueue.main.async {
            self.percentageLabel.text = "\(Int64(percentage * 100))%"
            self.shapeLayer.strokeEnd = percentage
        }
        
        //print(percentage)
    }
}

