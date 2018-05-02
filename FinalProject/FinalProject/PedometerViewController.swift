//
//  PedometerViewController.swift
//  FinalProject
//
//  Created by Jason Harnack on 4/27/18.
//  Copyright © 2018 Jason Harnack. All rights reserved.
//

import UIKit
import CoreMotion

class PedometerViewController: UIViewController {

    @IBOutlet weak var distanceTraveled: UILabel!
    let pedometer = CMPedometer()
    let pedometerData = CMPedometerData()
    let activityManager = CMMotionActivityManager()
    var today = Date()
    var startDistance = NSNumber()
    var endDistance = NSNumber()
    @IBOutlet weak var createNote: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let cal = Calendar.current
        let cals = cal.dateComponents([.year, .month, .day, .hour, .minute], from: Date())
        
        today = cal.date(from: cals)!
        startPedometer()
        createNote.isHidden = true
        distanceTraveled.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startPedometer(){
        if(CMPedometer.isStepCountingAvailable()){
            pedometer.startUpdates(from: today) { (pedometerData, error) -> Void in
                DispatchQueue.main.async {
                    if(error != nil){

                    }
                }

            }
        }
    }
    @IBAction func ZeroDistance(_ sender: Any) {
        pedometer.stopUpdates()
        startDistance = pedometerData.distance!
        endDistance = 0
    }
    @IBAction func BeginRecording(_ sender: Any) {
        startDistance = pedometerData.distance!
        distanceTraveled.text = "Measuring..."
    }
    
    @IBAction func freezeDistance(_ sender: Any) {
        endDistance = pedometerData.distance!
        let distanceTravel = (endDistance as! Decimal) - (startDistance as! Decimal)
        self.distanceTraveled.text = "Distance Traveled: \(distanceTravel)"
    }
}
