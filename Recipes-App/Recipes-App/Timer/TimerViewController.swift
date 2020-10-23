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
    @IBOutlet weak var counterTF: UITextField!
    @IBOutlet weak var startBttn: UIButton!
    @IBOutlet weak var pauseBttn: UIButton!
    @IBOutlet weak var resetBttn: UIButton!
    var seconds = 60
    var counterString: String = ""
    var counter: Int = 0
    var timer = Timer()
    var isTimerRunning = false
    var resumeTapped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        counterString = counterTF.text!
        counter = Int(counterString)!
        minuteslabel.text = "\(counter)"
        if isTimerRunning == false {
            runTimer()
        }
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    
    @objc func updateTimer() {
        if seconds < 1 {
            counter -= 1
            seconds = 0
            minuteslabel.text = "\(counter)"
            if counter < 0 {
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
        counter = 0
        secondsLabel.text = "00:00"
        isTimerRunning = false
    }
    
    func timeString(time: TimeInterval) -> String {
        let seconds = Int(time) % 60
        return String(format: "%02i", seconds)
    }
}
