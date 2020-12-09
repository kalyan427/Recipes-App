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
    @IBOutlet weak var secondsView: CircularSlider!
    @IBOutlet weak var hourView: CircularSlider!
    @IBOutlet weak var minuteView: CircularSlider!
    @IBOutlet weak var timerView: CircularSlider!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var setClockView: SpringView!
    @IBOutlet weak var displayClockView: SpringView!
    @IBOutlet weak var timerViewLabel: UILabel!
    
    var hour: Int = 0
    var minutes: Int = 0
    var seconds: Int = 0
    var hoursText: String = ""
    var minutestext: String = "30"
    var secondsText: String = ""
    var flipDuration: Double = 0.20
    var totalHours: Int = 0
    var totalMinutes: Int = 0
    var totalSeconds: Int = 0
    var totalTimeInSeconds: Int = 0
    var constantTotalTimeInSeconds: Int = 0
    var totalValueafterMinus: Int = 0
    var timer: Timer?
    
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
        
        // Seconds Slider
        secondsView.minimumValue = 0
        secondsView.maximumValue = 60
        secondsView.endPointValue = 30
        
        // minuteView.end
        minuteView.diskColor = UIColor.clear
        minuteView.backgroundColor = UIColor.clear
        
        // Timer view.
        displayClockView.isHidden = true
        setClockView.isHidden = false
        
        // TimerSet View.
        // timerView.minimumValue = 0
        timerView.diskColor = UIColor.white
        timerView.endThumbStrokeColor = UIColor.black
    }
}

//MARK: - View Clock

extension TimerViewController {
    @IBAction func showSetClockView(_ sender: UIButton) {
        DispatchQueue.main.asyncAfter(deadline:.now() + 0.6) {
            self.setClockView.isHidden = false
            self.displayClockView.isHidden = true
        }
        displayClockView.animation = "flipX"
        displayClockView.curve = "easeIn"
        displayClockView.duration = 1.0
        displayClockView.animate()
    }
    
    func resetTheClockView () {
        timerView.maximumValue = CGFloat(0)
        timerView.minimumValue = CGFloat(0)
    }
    
    @objc func countDown() {
        timerView.maximumValue = CGFloat(constantTotalTimeInSeconds)
        if totalTimeInSeconds != 0 {
            totalTimeInSeconds -= 1
            totalValueafterMinus = totalTimeInSeconds
            updatePlayerUI(currentTime: CGFloat(totalTimeInSeconds))
        } else {
            timer?.invalidate()
        }
    }
    
    // update the slider position and the timer text
    func updatePlayerUI(currentTime: CGFloat) {
        timerView.endPointValue = CGFloat(constantTotalTimeInSeconds) - CGFloat(totalValueafterMinus)
        
        // Conversion from seconds to hours.
        let hour = totalTimeInSeconds / 3600
        let minsec = totalTimeInSeconds % 3600
        let mins = minsec / 60
        let sec = minsec % 60
        timerViewLabel.text = String(format: "%02d:%02d:%02d", hour, mins, sec)
    }
}

//MARK: - Set Clock
extension TimerViewController {
    
    // MARK: Action for circular slider.
    
    // Hours slider action.
    @IBAction func hoursSlider(_ sender: CircularSlider) {
        hour = Int(sender.endPointValue)
        hoursText = "\(hour)"
        timerLabel.text = "\(hoursText)" + ":" + "\(minutestext)" + ":" + "\(secondsText)"
    }
    
    // Minutes slider action.
    @IBAction func minuteSlider(_ sender: CircularSlider) {
        minutes = Int(sender.endPointValue)
        minutestext = "\(minutes)"
        timerLabel.text = "\(hoursText)" + ":" + "\(minutestext)" + ":" + "\(secondsText)"
    }
    
    // Seconds Slider.
    @IBAction func secondsSlider(_ sender: CircularSlider) {
        seconds = Int(sender.endPointValue)
        secondsText = "\(seconds)"
        timerLabel.text = "\(hoursText)" + ":" + "\(minutestext)" + ":" + "\(secondsText)"
    }
    
    //On Set Click
    @IBAction func showDisplayClockView(_ sender: UIButton) {
        DispatchQueue.main.asyncAfter(deadline:.now() + 0.6) {
            self.setClockView.isHidden = true
            self.displayClockView.isHidden = false
        }
        setClockView.animation = "flipX"
        setClockView.curve = "easeIn"
        setClockView.duration = 1.0
        setClockView.animate()
        
        // Conversion total time to seconds
        totalHours = hour * 60 * 60
        totalMinutes = minutes * 60
        totalSeconds = seconds
        totalTimeInSeconds = totalHours + totalMinutes + totalSeconds
        constantTotalTimeInSeconds = totalTimeInSeconds
        resetTheClockView()
        
        //Setting Timer.
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
    }
}
