//
//  AnimatedGradientBorderedView.swift
//  BorderGradient
//
//  Created by Egor Laba on 27.08.23.
//

import UIKit

final class AnimatedGradientBorderedView: UIView {
    
    private let gradientLayer = CAGradientLayer()
    private let maskLayer = CAShapeLayer()
    
    private var lineWidth: CGFloat = 1.0 {
        didSet {
            maskLayer.lineWidth = lineWidth
        }
    }
    
    private var cornerRadius: CGFloat = 16.0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    private var diagonalSquared: CGFloat {
        return bounds.width * bounds.width + bounds.height * bounds.height
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let diagonal = sqrt(diagonalSquared)
        gradientLayer.frame = bounds.insetBy(dx: -(diagonal - bounds.width) * 0.5, dy: -(diagonal - bounds.height) * 0.5)
        maskLayer.path = UIBezierPath(roundedRect: bounds.insetBy(dx: lineWidth, dy: lineWidth), cornerRadius: cornerRadius).cgPath
        layer.mask = maskLayer
    }
    
    func doAnimate() {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2)
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = 6.0
        rotateAnimation.repeatCount = .greatestFiniteMagnitude
        
        gradientLayer.add(rotateAnimation, forKey: nil)
    }
    
    private func commonInit() {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        layer.addSublayer(gradientLayer)
        
        maskLayer.fillColor = UIColor.clear.cgColor
        maskLayer.strokeColor = UIColor.black.cgColor
        maskLayer.lineWidth = lineWidth
    }
}
