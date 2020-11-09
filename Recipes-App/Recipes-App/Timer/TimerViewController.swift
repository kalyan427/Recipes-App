//
//  TimerViewController.swift
//  Recipes-App
//
//  Created by venkata kalyan pasupuleti on 10/18/20.
//  Copyright © 2020 quiz. All rights reserved.
//

import UIKit
import HGCircularSlider
import Spring

class TimerViewController: UIViewController {
    @IBOutlet weak var hourView: CircularSlider!
    @IBOutlet weak var minuteView: CircularSlider!
    @IBOutlet weak var timerView: CircularSlider!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var setClockView: SpringView!
    @IBOutlet weak var displayClockView: SpringView!
    
    var hour: Int = 0
    var minutes: Int = 0
    var hoursText: String = ""
    var minutestext: String = "30"
    var flipDuration: Double = 0.20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Circular slider implementation.
        
        // Hours slider.
        hourView.minimumValue = 0
        hourView.maximumValue = 12
        hourView.endPointValue = 6
        hourView.backgroundColor = UIColor.clear
        
        // Minutes slider
        minuteView.minimumValue = 0
        minuteView.maximumValue = 60
        minuteView.endPointValue = 30
        minuteView.diskColor = UIColor.clear
        minuteView.backgroundColor = UIColor.clear
        
        // Timer view.
        displayClockView.isHidden = true
        setClockView.isHidden = false
        
        // TimerSet View.
        timerView.diskColor = UIColor.white
        timerView.endThumbStrokeColor = UIColor.black
        
        self.title = "Timer"
    }
    
   
    // Flip view action.
    @IBAction func showDisplayClockView(_ sender: UIButton) {
        DispatchQueue.main.asyncAfter(deadline:.now()+0.6) {
            self.setClockView.isHidden = true
            self.displayClockView.isHidden = false
        }
        setClockView.animation = "flipX"
        setClockView.curve = "easeIn"
        setClockView.duration = 1.0
        setClockView.animate()
       
    }
    
    @IBAction func showSetClockView(_ sender: UIButton) {
        DispatchQueue.main.asyncAfter(deadline:.now()+0.6) {
            self.setClockView.isHidden = false
            self.displayClockView.isHidden = true
        }
        displayClockView.animation = "flipX"
        displayClockView.curve = "easeIn"
        displayClockView.duration = 1.0
        displayClockView.animate()
    }
}

//MARK: - View Clock

extension TimerViewController {
    
}

//MARK: - Set Clock
extension TimerViewController {
    
    // MARK: Action for circular slider.
       
           // Hours slider action.
       @IBAction func hoursSlider(_ sender: CircularSlider) {
           hour = Int(sender.endPointValue)
           hoursText = "\(hour)"
           timerLabel.text = "0\(hoursText)" + ":" + "\(minutestext)"
       }
       
       // Minutes slider action.
       @IBAction func minuteSlider(_ sender: CircularSlider) {
           minutes = Int(sender.endPointValue)
           minutestext = "\(minutes)"
           timerLabel.text = "\(hoursText)" + ":" + "\(minutestext)"
       }
}
