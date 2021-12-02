//
//  CircularProgressActivity.swift
//  WabiSabiTeamProject
//
//  Created by Giovanni Tjahyamulia on 01/12/21.
//

import UIKit

class CircularProgressActivity: UIView {
    private var backgroundLayer: CAShapeLayer!
    private var foregroundLayer: CAShapeLayer!
    private var gradientLayer: CAGradientLayer!
    
    public var strokeColor: CGColor = UIColor(named: "ColorPrimary")?.cgColor ?? UIColor.systemIndigo.cgColor
    
    public var fillColor: CGColor = UIColor.clear.cgColor {
        didSet {
            
        }
    }
    
    public var progress: CGFloat = 0 {
        didSet {
            didProgressUpdated()
        }
    }

    override func draw(_ rect: CGRect) {
        // Background Layer
        backgroundLayer = createCircularLayer(rect: rect, strokeColor: UIColor.lightGray.cgColor, fillColor: fillColor, lineWidth: 0.5)
        // Foreground Layer
        foregroundLayer = createCircularLayer(rect: rect, strokeColor: strokeColor, fillColor: fillColor, lineWidth: 1)
        
        // Add Layer
        layer.addSublayer(backgroundLayer)
        layer.addSublayer(foregroundLayer)
    }
    
    private func createCircularLayer(rect: CGRect, strokeColor: CGColor, fillColor: CGColor, lineWidth: CGFloat) -> CAShapeLayer{
        // properties of Circular Progress Bar
        let width: CGFloat = rect.width
        let height: CGFloat = rect.height
        let center: CGPoint = CGPoint (x: width / 2, y: height / 2)
        let radius: CGFloat = width / 2
        let startAngle: CGFloat = -CGFloat.pi / 2
        let endAngle: CGFloat = startAngle + 2 * CGFloat.pi
        
        let circularPath: UIBezierPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = strokeColor
        shapeLayer.fillColor = fillColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineCap = .round
        
        return shapeLayer
    }
    
    private func didProgressUpdated() {
        foregroundLayer?.strokeEnd = progress
    }
    
    private func changeFillColor() {
        backgroundLayer?.fillColor = fillColor
    }
}

