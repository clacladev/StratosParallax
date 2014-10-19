//
//  ViewController.swift
//  StratosParallaxExample
//
//  Created by Claudio Carnino on 18/10/2014.
//  Copyright (c) 2014 Claudio Carnino's Tugulab. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    @IBOutlet weak var stratosParallaxView: StratosParallaxView!
    
    

    override func viewDidLoad() {

        super.viewDidLoad()
        
        // Enough to set the views
        stratosParallaxView.viewsToAnimate = exampleViewsForParallax()
    }
    
    
    
    func exampleViewsForParallax() -> [UIView] {
        
        var exampleViews: [UIView] = []
        
        var imageNames = ["background", "clouds", "mountains", "hill_left", "hill_right", "hill_middle", "sea"]
        
        for imageName in imageNames {
            let imageView = UIImageView(frame: self.view.bounds)
            imageView.image = UIImage(named: imageName)
            imageView.contentMode = UIViewContentMode.ScaleAspectFill
            exampleViews.append(imageView)
            
        }
        
        return exampleViews
    }
    
    
    override func didReceiveMemoryWarning() {
        stratosParallaxView.viewsToAnimate = []
    }
    
    
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
        // Calculate the other
        var newFrame = self.view.bounds
        newFrame.size = size
        
        // Update the frame of the views to animate
        for viewToAnimate in stratosParallaxView.viewsToAnimate {
            viewToAnimate.frame = newFrame
        }
    }

}

