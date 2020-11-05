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
    @IBOutlet weak var hourView: CircularSlider!
    @IBOutlet weak var minuteView: CircularSlider!
    
    
//    var hourFrame: CGRect = CGRect(x: 120, y: 120, width: 150, height: 150)
//    var minuteFrame: CGRect = CGRect(x: 90, y: 90, width: 220, height: 220)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Circular slider implementation.
        
        
        
        
        hourView.minimumValue = 0
        hourView.maximumValue = 12
        hourView.endPointValue = 6
        hourView.backgroundColor = UIColor.clear
    
        
        
        minuteView.minimumValue = 0
        minuteView.maximumValue = 60
        minuteView.endPointValue = 35
        minuteView.diskColor = UIColor.clear
        minuteView.backgroundColor = UIColor.clear
      
        
        setupSliders()
    }
    
    func setupSliders() {
        //hours
        
    }
    
    
    
    
    
    
   
        
        
 
    
   
    
    
    
    
    
    // MARK:-  Circular progress.
    
    
    
    
}
