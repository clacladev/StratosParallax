//
//  StratosParallaxView.swift
//  StratosParallaxExample
//
//  Created by Claudio Carnino on 18/10/2014.
//  Copyright (c) 2014 Claudio Carnino's Tugulab. All rights reserved.
//

import UIKit



enum StratosParallaxStrength: Double {
    case Strong = 300.0
    case Medium = 150.0
    case Soft = 50.0
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
            
            cacheViewsFrames()
            self.setNeedsLayout()
        }
    }
    
    // Strenght of the parallax effect using the predefined strengths levels
    var strength: StratosParallaxStrength = .Medium {
        didSet {
            self.strengthPoints = strength.toRaw()
            self.setNeedsLayout()
        }
    }
    
    // Strenght of the parallax effect using the movement in points
    var strengthPoints: Double = StratosParallaxStrength.Medium.toRaw() {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    
    
    // MARK: - Private properties
    private var viewsFrames: [CGRect] = []
    
    
    
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
    
    
    
    private func initializer() {
        
        self.backgroundColor = UIColor.clearColor()
    }
    
    
    
    private func cacheViewsFrames() {
        
        viewsFrames = []
        for view in viewsToAnimate {
            viewsFrames.append(view.bounds)
        }
    }
    
    
    
    /**
    Increase the size of the views' frames, so when the parallax move the image, the views' edges are never shown
    */
    private func fixViewsFrames() {
        
        let additionalSpaceNeededForParallax = CGFloat(strengthPoints)
        
        for index in 0 ..< viewsToAnimate.count {
            
            let originalFrame = viewsFrames[index]
            var view = viewsToAnimate[index]
        
            var newFrame = originalFrame
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
    private func applyParallaxEffect() {
        
        // The most background view will move in the opposite direction of the most foreground one
        let startingStrength = strengthPoints / -2.0
        
        // Calculate how much changes the strength of the effect per view
        let strengthChangePerView = strengthPoints / (Double(viewsToAnimate.count) - 1)
        
        // Apply the correct parallax strength values to the views
        for index in 0 ..< viewsToAnimate.count {
        
            let strenghtCurrentView = startingStrength + strengthChangePerView * Double(index)
            
            applyParallaxMotionEffectToView(viewsToAnimate[index], strength: strenghtCurrentView)
        }
    }
    
    
    
    private func applyParallaxMotionEffectToView(view: UIView, strength: Double) {
        
        let horizonalInterpolation = UIInterpolatingMotionEffect(keyPath: "center.x", type: UIInterpolatingMotionEffectType.TiltAlongHorizontalAxis)
        horizonalInterpolation.minimumRelativeValue = strength * -1
        horizonalInterpolation.maximumRelativeValue = strength
        
        let verticalInterpolation = UIInterpolatingMotionEffect(keyPath: "center.y", type: UIInterpolatingMotionEffectType.TiltAlongVerticalAxis)
        verticalInterpolation.minimumRelativeValue = strength * -1
        verticalInterpolation.maximumRelativeValue = strength
        
        view.motionEffects = [horizonalInterpolation, verticalInterpolation]
    }
    
    
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        fixViewsFrames()
        applyParallaxEffect()
    }

}
