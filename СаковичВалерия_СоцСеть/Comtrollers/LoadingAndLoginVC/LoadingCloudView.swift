//
//  LoadingCloudView.swift
//  СаковичВалерия_СоцСеть
//
//  Created by Валерия Сакович on 14.11.21.
//

import UIKit

@IBDesignable class LoadingCloudView: UIView {
    
    @IBInspectable var currentColor: UIColor = UIColor.systemGray
    let path = UIBezierPath()
    let cloudShapeLayer = CAShapeLayer()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let cgContext = UIGraphicsGetCurrentContext() else {return}
        cgContext.setStrokeColor(currentColor.cgColor)
        cgContext.interpolationQuality = .high
       
        path.move(to: CGPoint(x: 56, y: 113))
        path.addCurve(to: CGPoint(x: 57, y: 57), controlPoint1: CGPoint(x: 14, y: 113), controlPoint2: CGPoint(x: 14, y: 57))
        path.addCurve(to: CGPoint(x: 128, y: 64), controlPoint1: CGPoint(x: 57, y: 21), controlPoint2: CGPoint(x: 128, y: 14))
        path.addCurve(to: CGPoint(x: 142, y: 113), controlPoint1: CGPoint(x: 170, y: 64), controlPoint2: CGPoint(x: 160, y: 113))
        path.addLine(to: CGPoint(x: 56, y: 113))
        path.close()
        
        cgContext.addPath(path.cgPath)
        cgContext.strokePath()
    }
    
    func animateCloud() {
        cloudShapeLayer.path = path.cgPath
        cloudShapeLayer.strokeColor = UIColor.systemGray.cgColor
        cloudShapeLayer.lineWidth = 3
        
        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.fromValue = 0
        strokeStartAnimation.toValue = 1

        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.fromValue = 0
        strokeEndAnimation.toValue = 1.2

        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 2
        animationGroup.animations = [strokeStartAnimation, strokeEndAnimation]
        
        cloudShapeLayer.add(animationGroup, forKey: nil)
    }
}
