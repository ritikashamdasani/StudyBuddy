//
//  TimerViewController.swift
//  StudyBudy
//
//  Created by Apple on 6/27/19.
//  Copyright © 2019 Apple. All rights reserved.
//
import UIKit

class TimerViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    var seconds = 60 //This variable will hold a starting value of seconds. It could be any amount above 0.
    var timer = Timer()
    var isTimerRunning = false //This will be used to make sure only one timer is created at a time.
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        if isTimerRunning == false {
            runTimer()
            self.startButton.isEnabled = false
        }
        
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(TimerViewController.updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
        pauseButton.isEnabled = true
    }
    
    
    var resumeTapped = false
    
    @IBAction func pauseButtonTapped(_ sender: UIButton) {
        if self.resumeTapped == false {
            timer.invalidate()
            self.resumeTapped = true
            self.pauseButton.setTitle("Resume",for: .normal)
        } else {
            runTimer()
            self.resumeTapped = false
            self.pauseButton.setTitle("Pause",for: .normal)
        }
    }
    
    @IBAction func resetButtonTappped(_ sender: UIButton) {
        timer.invalidate()
        seconds = 60//Here we manually enter the restarting point for the seconds, but it would be wiser to make this a variable or constant.
        timerLabel.text = timeString(time: TimeInterval(seconds))
        isTimerRunning = false
        startButton.isEnabled = true
        pauseButton.isEnabled = false
    }
    
    
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    func alertMessage() {
        let alert = UIAlertController(title: "Study Session Complete!", message: "Now take a five minute break.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay :)", style: .cancel, handler: nil))
        self.present(alert, animated: true)
        
    }
    
    
    
    
    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            alertMessage()
            //send alert to indicate that time is up
        } else {
            seconds -= 1     //This will decrement(count down)the seconds.
            timerLabel.text = timeString(time: TimeInterval(seconds))
        }
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pauseButton.isEnabled = false
        // Do any additional setup after loading the view.
    }
    
}
