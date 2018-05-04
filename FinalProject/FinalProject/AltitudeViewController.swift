//
//  AltitudeViewController.swift
//  FinalProject
//
//  Created by Jason Harnack on 4/27/18.
//  Copyright © 2018 Jason Harnack. All rights reserved.
//

import UIKit
import CoreMotion

class AltitudeViewController: UIViewController {
    // Altitude manager
    let altitude = CMAltimeter()
    let altitudeData = CMAltitudeData()
    
    // Buttons
    @IBOutlet weak var createNote: UIButton!
    
    @IBOutlet weak var beginButton: UIButton!
    @IBOutlet weak var freezeButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var metersSwitch: UISwitch!
    
    // Labels
    @IBOutlet weak var heightLabel: UILabel!
    
    // Variables to store altitude data
    var startDistance = 0.0
    var endDistance = 0.0
    var currentAltitude = 0.0
    var stringDistance = String()
    
    
    // Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        freezeButton.isEnabled = false
        startAltimeter()
        createNote.isHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startAltimeter(){
        if(CMAltimeter.isRelativeAltitudeAvailable()){
            altitude.startRelativeAltitudeUpdates(to: OperationQueue.main) {
                (altitudeData, error) in
                if(error == nil){
                    self.currentAltitude = (Double)(truncating: (altitudeData?.relativeAltitude)!)
                }
                
            }
        }
    }
    
    @IBAction func BeginRecording(_ sender: Any) {
        startDistance = currentAltitude
        heightLabel.text = "Measuring..."
        createNote.isHidden = true
        beginButton.isEnabled = false
        freezeButton.isEnabled = true
    }
    
    @IBAction func FreezeData(_ sender: Any) {
        endDistance = currentAltitude
        let distance = endDistance - startDistance
        let stringDistance = String(distance).prefix(5)
        
        if (metersSwitch.isOn) {
            heightLabel.text = "Height from Zero Point: " + stringDistance + " meters."
        }
        else {
            let feet = distance * 3.28084
            
            heightLabel.text = "Height from Zero Point: " + String(feet).prefix(5) + " feet."
        }
        createNote.isHidden = false
        freezeButton.isEnabled = false
    }
    @IBAction func ZeroDistance(_ sender: Any) {
        endDistance = 0.0
        heightLabel.text = "Data zerored out!"
        createNote.isHidden = true
        beginButton.isEnabled = true
        freezeButton.isEnabled = false
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let dest = segue.destination as! CreateNoteViewController
        
        dest.identifier = "altitude"
        dest.labelText = "Height from Zero Point: " + stringDistance + " meters."
    }


}
