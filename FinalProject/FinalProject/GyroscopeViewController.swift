//
//  GyroscopeViewController.swift
//  FinalProject
//
//  Created by Jason Harnack on 4/27/18.
//  Copyright © 2018 Adam Beck & Jason Harnack. All rights reserved.

import UIKit
import CoreMotion

class GyroscopeViewController: UIViewController {
    // Motion manager
    var motion = CMMotionManager()
    var timer = Timer()
    
    // Variables to hold data while the app is running
    var currentAngleX = "-1.0"
    var beginAngleX = "-1.0"
    var endAngleX = "-1.0"
    
    // Outlets
    // Buttons
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var beginButton: UIButton!
    @IBOutlet weak var freezeButton: UIButton!
    
    // Labels
    @IBOutlet weak var angleXLabel: UILabel!
    @IBOutlet weak var currentAngleXLabel: UILabel!
    @IBOutlet weak var beginLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    
    // Functions
    override func viewDidLoad() {
        freezeButton.isEnabled = false
        startGyros()
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startGyros() {
        // Gimbal lock problem makes this very difficult, can't use traditional accelerometer/gryo data
        // to display roation in a 3-tuple Euler angles.
        if motion.isDeviceMotionAvailable {
            motion.deviceMotionUpdateInterval = 0.1
            motion.startDeviceMotionUpdates(to: OperationQueue.main) {
                (data, error) in
                if let data = data {
                    // notes: atan2 of x and y yield sideways rotation (face your phone, rotate hand clockwise)
                    // atan2 of y and z measures traditional angles in a construction-sense.
                    var rotation = atan2(data.gravity.y, data.gravity.z) - Double.pi
                    
                    // At this point, our data measures fro 0 to -6.2, radians.
                    // Convert this to degrees
                    rotation = rotation * (180 / Double.pi)
                    
                    // Convert the degrees to output how a unit circle displays angles.
                    rotation = 360 - (rotation * -1)
                    
                    self.currentAngleXLabel.text = String(rotation)
                    self.currentAngleX = String(rotation)
                }
            }
        }
    }
    
    
    
    // Take a current measurement as a starting value.
    @IBAction func startRecording(_ sender: UIButton) {
        beginAngleX = currentAngleX
        beginLabel.text = beginAngleX
        beginButton.isEnabled = false
        freezeButton.isEnabled = true
    }
    
    // Take a current measurement as an ending value, and displays the difference.
    @IBAction func stopRecording(_ sender: UIButton) {
        endAngleX = currentAngleX
        endLabel.text = currentAngleX
        
        // display the difference
        let diff = Double(endLabel.text!)! - Double(beginLabel.text!)!
        angleXLabel.text = String(diff)
        freezeButton.isEnabled = false
    }
    
    // Clears the displayed value.
    @IBAction func clearValue(_ sender: UIButton) {
        beginButton.isEnabled = true
        freezeButton.isEnabled = false
        
        angleXLabel.text = "0"
        currentAngleXLabel.text = "0"
        beginLabel.text = "0"
        endLabel.text = "0"
    }
}
