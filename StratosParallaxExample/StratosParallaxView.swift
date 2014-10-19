//
//  StratosParallaxView.swift
//  StratosParallaxExample
//
//  Created by Claudio Carnino on 18/10/2014.
//  Copyright (c) 2014 Claudio Carnino's Tugulab. All rights reserved.
//

import UIKit



enum StratosParallaxStrength: Double {
    case Strong = 100.0
}



class StratosParallaxView: UIView {
    
    // MARK: - Public interface
    
    /// Array of views to animate with the parallax effect. The last view in the array will be the most foreground one
    var viewsToAnimate: [UIView] = [] {
        willSet {
            // Remove the views added previously
            for viewToAnimate in viewsToAnimate {
                viewToAnimate.removeFromSuperview()
            }
        }
        didSet {
            // Add the newly setted views
            for viewToAnimate in viewsToAnimate {
                self.addSubview(viewToAnimate)
            }
            
            applyParallaxEffect()
        }
    }
    
    /// Strenght of the parallax effect
    var strength = StratosParallaxStrength.Strong
    
    
    
    // MARK: - Private properties
    
    
    
    // MARK: - App lifecyle
    
    override init() {
        super.init()
        initializer()
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializer()
    }
    
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializer()
    }
    
    
    
    func initializer() {
        
        self.backgroundColor = UIColor.clearColor()
    }
    
    
    
    func applyParallaxEffect() {
        
        let parallaxStrengthPerView = strength.toRaw() / Double(viewsToAnimate.count)
        
        for index in 0 ..< viewsToAnimate.count {
        
            let viewToAnimate = viewsToAnimate[index]
            let parallaxStrenghtCurrentView = parallaxStrengthPerView * Double(index + 1)
            
            let horizonalInterpolation = UIInterpolatingMotionEffect(keyPath: "center.x", type: UIInterpolatingMotionEffectType.TiltAlongHorizontalAxis)
            horizonalInterpolation.minimumRelativeValue = parallaxStrenghtCurrentView * -1
            horizonalInterpolation.maximumRelativeValue = parallaxStrenghtCurrentView
            
            let verticalInterpolation = UIInterpolatingMotionEffect(keyPath: "center.y", type: UIInterpolatingMotionEffectType.TiltAlongVerticalAxis)
            verticalInterpolation.minimumRelativeValue = parallaxStrenghtCurrentView * -1
            verticalInterpolation.maximumRelativeValue = parallaxStrenghtCurrentView
            
            viewToAnimate.addMotionEffect(horizonalInterpolation)
            viewToAnimate.addMotionEffect(verticalInterpolation)
        }
    }
    
    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        // Drawing code
    }
    */

}
