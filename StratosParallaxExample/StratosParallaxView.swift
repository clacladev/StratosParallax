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
    
    // Array of views to animate with the parallax effect. The last view in the array will be the most foreground one
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
            
            fixViewsFrameForParallax()
            applyParallaxEffect()
        }
    }
    
    // Strenght of the parallax effect
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
    
    
    
    /**
    Increase the size of the views' frames, so when the parallax move the image, the views' edges are never shown
    */
    func fixViewsFrameForParallax() {
        
        let additionalSpaceNeededForParallax = CGFloat(strength.toRaw())
        
        for view in viewsToAnimate {
            
            var newFrame = view.bounds
            newFrame.origin.x = additionalSpaceNeededForParallax / -2.0
            newFrame.origin.y = additionalSpaceNeededForParallax / -2.0
            newFrame.size.width += additionalSpaceNeededForParallax
            newFrame.size.height += additionalSpaceNeededForParallax
            
            view.bounds = newFrame
        }
    }
    
    
    
    /**
    Apply the parallax motion effect to the views to create a parallax effect.
    Each view will have a different min/max motion effect relative value, so each view moves in a different fashion.
    This will make the parallax effect more realistic
    */
    func applyParallaxEffect() {
        
        // The most background view will move in the opposite direction of the most foreground one
        let startingStrength = strength.toRaw() / -2.0
        
        // Calculate how much changes the strength of the effect per view
        let strengthChangePerView = strength.toRaw() / (Double(viewsToAnimate.count) - 1)
        
        // Apply the correct parallax strength values to the views
        for index in 0 ..< viewsToAnimate.count {
        
            let strenghtCurrentView = startingStrength + strengthChangePerView * Double(index)
            
            applyParallaxMotionEffectToView(viewsToAnimate[index], strength: strenghtCurrentView)
        }
    }
    
    
    
    func applyParallaxMotionEffectToView(view: UIView, strength: Double) {
        
        let horizonalInterpolation = UIInterpolatingMotionEffect(keyPath: "center.x", type: UIInterpolatingMotionEffectType.TiltAlongHorizontalAxis)
        horizonalInterpolation.minimumRelativeValue = strength * -1
        horizonalInterpolation.maximumRelativeValue = strength
        
        let verticalInterpolation = UIInterpolatingMotionEffect(keyPath: "center.y", type: UIInterpolatingMotionEffectType.TiltAlongVerticalAxis)
        verticalInterpolation.minimumRelativeValue = strength * -1
        verticalInterpolation.maximumRelativeValue = strength
        
        view.addMotionEffect(horizonalInterpolation)
        view.addMotionEffect(verticalInterpolation)
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
