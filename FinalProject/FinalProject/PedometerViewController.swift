//
//  PedometerViewController.swift
//  FinalProject
//
//  Created by Jason Harnack on 4/27/18.
//  Copyright © 2018 Jason Harnack. All rights reserved.
import UIKit
import CoreMotion

class PedometerViewController: UIViewController {
    // Pedometer, Activity, and Date manager
    let pedometer = CMPedometer()
    let pedometerData = CMPedometerData()
    let activityManager = CMMotionActivityManager()
    var today = Date()
    var stringDistance = String()
    
    // Labels
    @IBOutlet weak var distanceTraveled: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var createNote: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var endButton: UIButton!
    @IBOutlet weak var zeroButton: UIButton!
    
    // Variables to store pedometer data
    var startDistance: Double! = 0.0
    var endDistance: Double! = 0.0
    var distance: Double! = 0.0
    var speed: Double! = 0.0
    
    // Timers
    var timer = Timer()
    var timerInterval = 1.0
    var timeElapsed:TimeInterval = 1.0
    
    @objc func timerAction(timer:Timer){
        // pass
    }
    
    // Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        let cal = Calendar.current
        let cals = cal.dateComponents([.year, .month, .day, .hour, .minute], from: Date())
        
        today = cal.date(from: cals)!
        startPedometer()
        createNote.isHidden = true
        distanceTraveled.isHidden = true
        
        startButton.isEnabled = true
        endButton.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startTimer(){
        if timer.isValid { timer.invalidate() }
        timer = Timer.scheduledTimer(timeInterval: timerInterval,target: self,selector: #selector(timerAction(timer:)) ,userInfo: nil,repeats: true)
    }
    
    func startPedometer(){
        startTimer()
        
        pedometer.startUpdates(from: Date(), withHandler: { (pedometerData, error) in
            if let pedData = pedometerData{
                if let dist = pedData.distance{
                    self.distance = dist as! Double
                }
                if let pace = pedData.currentPace {
                    self.speed = pace as! Double
                    self.speedLabel.text = String(self.speed)
                    
                }
            }
        })
        
    }
    
    
    @IBAction func ZeroDistance(_ sender: Any) {
        pedometer.stopUpdates()
        startDistance = 0
        endDistance = 0
        createNote.isHidden = true
        distanceTraveled.isHidden = true
        
        startButton.isEnabled = true
        endButton.isEnabled = false
    }
    
    @IBAction func BeginRecording(_ sender: Any) {
        startDistance = distance
        distanceTraveled.text = "Measuring..."
        distanceTraveled.isHidden = false
        createNote.isHidden = true
        
        startButton.isEnabled = false
        endButton.isEnabled = true
    }
    
    @IBAction func freezeDistance(_ sender: Any) {
        endDistance = self.distance
        let distance = endDistance - startDistance
        stringDistance = String(String(distance).prefix(5))
        self.distanceTraveled.text = "Distance Traveled: "  + stringDistance + " meters."
        createNote.isHidden = false
        
        endButton.isEnabled = false
    }
    

     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
        
        let dest = segue.destination as! CreateNoteViewController
        
        dest.identifier = "distance"
        dest.labelText = "Distance Traveled: " + stringDistance + " meters."
        
     }

}
