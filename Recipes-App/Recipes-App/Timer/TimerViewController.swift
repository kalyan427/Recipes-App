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
    var primaryFrame: CGRect = CGRect(x: 90, y: 90, width: 220, height: 220)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Circular slider implementation.
        let circularSlider = CircularSlider(frame: myFrame)
        circularSlider.minimumValue = 0
        circularSlider.maximumValue = 12
        circularSlider.endPointValue = 6
        circularSlider.backgroundColor = UIColor.clear
        self.view.addSubview(circularSlider)
        
        let secondCircularView = CircularSlider(frame: primaryFrame)
        secondCircularView.minimumValue = 0
        secondCircularView.maximumValue = 60
        secondCircularView.endPointValue = 35
        secondCircularView.diskColor = UIColor.clear
        secondCircularView.backgroundColor = UIColor.clear
        self.view.addSubview(secondCircularView)
        
        setupSliders()
    }
    
    func setupSliders() {
        //hours
        
    }
    
    
    
    
    
    
   
        
        
 
    
   
    
    
    
    
    
    // MARK:-  Circular progress.
    
    
    
    
}
