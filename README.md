StratosParallax
===============

StratosParallax is an iOS library written in *swift* that makes easy to add a multi-stratos (multi view) parallax effect.

You can use it to make really cool backgrounds for your app/game.

It is made in *swift*, but it works just fine in an Objective-C project.


#* What's the goal?

The goal is to help you make a multi-view parallax effect like the one in the opening screen of the iOS game [The Boxtrolls](https://itunes.apple.com/us/app/the-boxtrolls-slide-n-sneak/id911631097?mt=8).

Here's a 4 view parallax made with StratosParallax (bg, mountains, hills and sea + button on top):
![StratosParallax example](http://tugulab.org/files/StratosParallax/example.gif)

It's the same you get downloading the project.


#* How is it made?
Add a **StratosParallaxView** view-component to your view (using Interface Builder or programmatically). Then set the in the property **viewsToAnimate** an array of views you want to apply the effect upon.

You can add anything that inherits from UIView. Optionally you can set the strength of the parallax effect (with some predefined values or in number of points).

Here you can see how the views in the StratosParallaxView are layered:
![StratosParallax structure](http://tugulab.org/files/StratosParallax/structure.gif)


#* How-to use this library?

### Step 1:
First you need to add the **StratosParallaxView.swift** file to your project.


### Step 2, option A: Interface Builder

The first option is to add an UIView component to your view, then opening the **Identity inspector** in the right side pane, change the class of the view to **StratosParallaxView**.

In your view controller create an IBOutlet and connect it to the StratosParallaxView component in Interface Builder.

In your ViewController setup the **StratosParallaxView**. Like in the following example:

	class ViewController: UIViewController {
    
    @IBOutlet weak var stratosParallaxView: StratosParallaxView!
    
      override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the StratosParallaxView
        stratosParallaxView.viewsToAnimate = [...]		// Array of n views
        stratosParallaxView.strength = .Strong			// Set the strength of the effect
        //stratosParallaxView.strengthPoints = 300.0 	// Alternative method to set the strength
      }
    }
    

### Step 2, option B: programmatically

In your view controller instatiate the StratosParallaxView component and the setup it. 
Here's an example:

	class ViewController: UIViewController {
    
      override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the StratosParallaxView
        var stratosParallaxView = StratosParallaxView(frame: self.view.bounds)
        stratosParallaxView.viewsToAnimate = [...]		// Array of n views
        stratosParallaxView.strength = .Strong			// Set the strength of the effect
        //stratosParallaxView.strengthPoints = 300.0 	// Alternative method to set the strength
        
        self.view.addSubview(stratosParallaxView)		// Add the stratosParallaxView to the view
      }
    }


# Notes

Few notes here:

* You can use the StratosParallaxView component in an Objective-C project. The interface is the same
* The component support resizing of the StratosParallaxView component
* The component displays the views as is. It's your responsibility to set their frames.
* The component frame's is incresed and repositioned by an amount big as strengthPoints. This way the StratosParallaxView component is able to move the views inside to create the parallax effect without showing their edges
* You can add as view to animate, everything that subclass UIView


# Contacts

Please comment, report issues and suggest improvements. You can write me at <claudio@tugulab.org>. 
Cheers!
