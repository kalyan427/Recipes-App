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
    var seconds = 0
    var counter = 0
    var timer = Timer()
    var isTimerRunning = false
    var resumeTapped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        if isTimerRunning == false {
            runTimer()
        }
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    
    @objc func updateTimer() {
        if seconds > 59 {
            counter += 1
            seconds = 0
            minuteslabel.text = "\(counter)"
            //timer.invalidate()
           // print("Time is reached to end")
        } else {
            seconds += 1
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
        secondsLabel.text = "00:00"
       // secondsLabel.text = timeString(time: TimeInterval(seconds))
        isTimerRunning = false
    }
    
    func timeString(time: TimeInterval) -> String {
        //let hours = Int(time) / 3600
       // let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        //return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
        return String(format: "%02i", seconds)
    }
}
