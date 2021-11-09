import UIKit

class CircularProgressBar: UIView {
    private var backgroundLayer: CAShapeLayer!
    private var foregroundLayer: CAShapeLayer!
    private var textLayer: CATextLayer!
    private var gradientLayer: CAGradientLayer!
    
    public var progress: CGFloat = 0 {
        didSet {
            didProgressUpdated()
        }
    }
    
    public var textLabel = "" {
        didSet {
            didLabelUpdated()
        }
    }

    override func draw(_ rect: CGRect) {
        // Background Layer
        backgroundLayer = createCircularLayer(rect: rect, strokeColor: UIColor.systemIndigo.cgColor, fillColor: UIColor.clear.cgColor, lineWidth: 2)
        // Foreground Layer
        foregroundLayer = createCircularLayer(rect: rect, strokeColor: UIColor.white.cgColor, fillColor: UIColor.clear.cgColor, lineWidth: 5)
        // Text Layer
        textLayer = createTextLayer(rect: rect, textColor: UIColor.white.cgColor)
        
        /*
        // Gradient Layer
        gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.colors = [UIColor.systemTeal.cgColor, UIColor.systemBlue.cgColor]
        gradientLayer.frame = rect
        gradientLayer.mask = foregroundLayer
        */
        
        // Add Layer
        layer.addSublayer(backgroundLayer)
        layer.addSublayer(foregroundLayer)
        layer.addSublayer(textLayer)
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
    
    private func createTextLayer(rect: CGRect, textColor: CGColor) -> CATextLayer {
        // properties of Circular Progress Bar Text
        let width: CGFloat = rect.width
        let height: CGFloat = rect.height
        
        let fontSize: CGFloat = 30
        let offset: CGFloat = width * 0.1

        let textLayer = CATextLayer()
        textLayer.string = ""
        textLayer.backgroundColor = UIColor.clear.cgColor
        textLayer.foregroundColor = textColor
        textLayer.fontSize = fontSize
        textLayer.font = UIFont(name: "Euphemia UCAS", size: fontSize)
        textLayer.frame = CGRect(x: 0.0, y: (height - fontSize - offset) / 2, width: width, height: fontSize + offset)
        textLayer.alignmentMode = .center
        
        return textLayer
    }
    
    private func didProgressUpdated() {
        foregroundLayer?.strokeEnd = progress
    }
    
    private func didLabelUpdated(){
//        textLayer?.string = "\(textLabel)"
    }
}
