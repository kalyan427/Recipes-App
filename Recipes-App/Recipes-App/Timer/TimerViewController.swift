//
//  TimerViewController.swift
//  Recipes-App
//
//  Created by venkata kalyan pasupuleti on 10/18/20.
//  Copyright © 2020 quiz. All rights reserved.
//

import UIKit
import HGCircularSlider

class TimerViewController: UIViewController {
    var myFrame: CGRect = CGRect(x: 120, y: 120, width: 150, height: 150)
    var primaryFrame: CGRect = CGRect(x: 140, y: 140, width: 180, height: 180)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Circular slider implementation.
        let circularSlider = CircularSlider(frame: myFrame)
        circularSlider.minimumValue = 0.0
        circularSlider.maximumValue = 1.0
        circularSlider.endPointValue = 0.2
        circularSlider.backgroundColor = UIColor.clear
        self.view.addSubview(circularSlider)
        
        let secondCircularView = CircularSlider(frame: primaryFrame)
        secondCircularView.minimumValue = 0.0
        secondCircularView.maximumValue = 1.0
        secondCircularView.endPointValue = 0.2
        secondCircularView.diskColor = UIColor.clear
        secondCircularView.backgroundColor = UIColor.clear
        self.view.addSubview(secondCircularView)
    }
    
   
    
    
    
    
    
    
   
        
        
 
    
   
    
    
    
    
    
    // MARK:-  Circular progress.
    
    
    
    
}
