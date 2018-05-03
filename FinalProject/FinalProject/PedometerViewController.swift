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
    
    // Labels
    @IBOutlet weak var distanceTraveled: UILabel!
    
    // Buttons
    @IBOutlet weak var createNote: UIButton!
    
    // Variables to store pedometer data
    var startDistance = 0.0
    var endDistance = 0.0
    var currentDistance = 0.0
    
    // Functions
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
                        if let pedDist = pedometerData?.distance {
                            self.currentDistance = (Double)(truncating: pedDist)
                        }
                    
                        
                    }
                }
            }
        }
    }
    
    
    @IBAction func ZeroDistance(_ sender: Any) {
        pedometer.stopUpdates()
        startDistance = 0
        endDistance = 0
        createNote.isHidden = true
        distanceTraveled.isHidden = true
    }
    @IBAction func BeginRecording(_ sender: Any) {
        startDistance = currentDistance
        distanceTraveled.text = "Measuring..."
        distanceTraveled.isHidden = false
        createNote.isHidden = true
    }
    
    @IBAction func freezeDistance(_ sender: Any) {
        endDistance = currentDistance
        let distance = endDistance - startDistance
        let stringDistance = String(distance).prefix(5)
        self.distanceTraveled.text = "Distance Traveled:"  + stringDistance + " meters."
        createNote.isHidden = false
    }
    

     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
        
        let dest = segue.destination as! CreateNoteViewController
        
        dest.identifier = "distance"
        dest.labelText = "This is my distance data!"
        
     }

}
