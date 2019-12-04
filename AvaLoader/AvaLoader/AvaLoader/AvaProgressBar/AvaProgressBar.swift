//
//  AvaProgressBar.swift
//  AvaLoader
//
//  Created by Rost on 30.11.2019.
//  Copyright © 2019 Rost Gress. All rights reserved.
//

import Foundation
import UIKit


class AvaProgressBar: UIView {
    var progressPath: UIBezierPath!             // Path for progress
    var progressLayer: CAShapeLayer!            // Layer for draw progress
    var gradientLayer: CAGradientLayer!         // Layer for draw gradient
    var progressColor: UIColor  = .black        // Default color for stroke on progress line
    var gradientColors: [CGColor]!              // Support for gradient colors on progress line
    
    var progress: Float = 0.0 {                 // Var for change progress
         willSet(newValue) {
            if let layer = progressLayer {
                layer.strokeColor   = progressColor.cgColor
                layer.strokeEnd     = CGFloat(newValue)
            }
         }
    }
    
    
    /// ---> Function for make draw path  <--- ///
    private func makePath() {
        let x = self.bounds.width - 4.0
        let y = self.bounds.height - 4.0
        
        let startAngle: CGFloat = CGFloat(3 * Double.pi / 2)
        let endAngle: CGFloat   = CGFloat(Double.pi) + 1.5
        
        progressPath  = UIBezierPath()
        progressPath.addArc(withCenter: CGPoint(x: (x / 2) + 2.0, y: (y / 2) + 2.0),
                            radius: x / 2.0,
                            startAngle: startAngle,
                            endAngle: endAngle,
                            clockwise: true)
        
        progressPath.close()
    }
    
    
    /// ---> Function make progress layer <--- ///
    func makeProgress() {
        makePath()

        progressLayer           = CAShapeLayer()
        progressLayer.path      = progressPath.cgPath
        progressLayer.lineWidth = 2
        progressLayer.lineCap   = CAShapeLayerLineCap.round
        progressLayer.fillColor = nil
        progressLayer.strokeEnd = 0.0
      
        self.layer.addSublayer(progressLayer)
        
        if gradientColors != nil {
            addGradient(progressLayer)
        }
    }
    
    
    /// ---> Function for add gradient to progress layer <--- ///
    func addGradient(_ mask: CAShapeLayer) {
        gradientLayer               = CAGradientLayer()
        gradientLayer.startPoint    = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint      = CGPoint(x: 1.0, y: 0.5)

        gradientLayer.colors        = gradientColors
        gradientLayer.frame         = self.bounds
        gradientLayer.mask          = mask

        self.layer.addSublayer(gradientLayer)
    }
    
    
    /// ---> Function for remove progress and gradient layers <--- ///
    func removeProgress() {
        if let gradient = gradientLayer {
            gradient.removeFromSuperlayer()
        }
        
        if let progress = progressLayer {
            progress.removeFromSuperlayer()
        }
    }
    
    
    /// ---> Function for reload progress and gradient layers <--- ///
    func reloadProgress() {
        removeProgress()
        makeProgress()
    }
}
