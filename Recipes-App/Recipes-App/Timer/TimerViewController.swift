//
//  TimerViewController.swift
//  Recipes-App
//
//  Created by venkata kalyan pasupuleti on 10/18/20.
//  Copyright © 2020 quiz. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var minuteslabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var minutesCounterTF: UITextField!
    @IBOutlet weak var startBttn: UIButton!
    @IBOutlet weak var pauseBttn: UIButton!
    @IBOutlet weak var resetBttn: UIButton!
    @IBOutlet weak var hoursTF: UITextField!
    @IBOutlet weak var minutesTF: UITextField!
    @IBOutlet weak var secondsTF: UITextField!
    var seconds = 60
    var hoursCounterString: String = ""
    var counterString: String = ""
    var hoursCounter: Int = 0
    var minutesCounter: Int = 60
    var timer = Timer()
    var isTimerRunning = false
    var resumeTapped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the corner radius for start button.
        startBttn.layer.masksToBounds = true
        startBttn.layer.cornerRadius = 45/2
        
        // Set the corner radius for pause button.
        pauseBttn.layer.masksToBounds = true
        pauseBttn.layer.cornerRadius = 45/2
        
        // Set the corner radius for reset button.
        resetBttn.layer.masksToBounds = true
        resetBttn.layer.cornerRadius = 45/2
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        if hoursTF.text != "" {
            hoursCounterString = hoursTF.text!
            hoursCounter = Int(hoursCounterString)!
            hoursLabel.text = "\(hoursCounter)"
            hoursTF.text = nil
            if isTimerRunning == false {
                runTimer()
            }
        } else {
            counterString = minutesTF.text!
            if counterString == "" {
                minutesTF.placeholder = "Please enter the value"
            } else {
                minutesCounter = Int(counterString)!
                minuteslabel.text = "\(minutesCounter)"
                minutesTF.text = nil
                if isTimerRunning == false {
                    runTimer()
                }
            }
        }
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    
    @objc func updateTimer() {
//        if hoursCounter >= 1 {
//            hoursCounter -= 1
//
//
//            seconds -= 1
//            if seconds < 1 {
//
//            }
//        }
        if seconds < 1 {
            minutesCounter -= 1
            seconds = 0
            minuteslabel.text = "\(minutesCounter)"
            if minutesCounter == 0 {
                timer.invalidate()
                seconds = 60
                secondsLabel.text = "00"
                isTimerRunning = false
            }
        } else {
            seconds -= 1
            secondsLabel.text = timeString(time: TimeInterval(seconds))
        }
    }
    
    @IBAction func pauseButton(_ sender: UIButton) {
        if (resumeTapped == false) {
            timer.invalidate()
            resumeTapped = true
        } else {
            runTimer()
            resumeTapped = false
        }
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        timer.invalidate()
        seconds = 60
        minutesCounter = 0
        secondsLabel.text = "00"
        //counter = 0
        isTimerRunning = false
    }
    
    func timeString(time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        print("hours: \(hours)")
        let minutes = Int(time) / 60 % 60
        print("minutes: \(minutes)")
        let seconds = Int(time) % 60
        print(seconds)
        return String(format: "%02i", seconds)
    }
    
    
}
