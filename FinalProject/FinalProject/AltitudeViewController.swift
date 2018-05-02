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

    @IBOutlet weak var heightLabel: UILabel!
    let altitude = CMAltimeter()
    let altitudeData = CMAltitudeData()
    var startDistance = NSNumber()
    var endDistance = NSNumber()
    override func viewDidLoad() {
        super.viewDidLoad()

        startAltimeter()
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
                    
                }
                
            }
        }
    }
    
    @IBAction func BeginRecording(_ sender: Any) {
        startDistance = altitudeData.relativeAltitude
        heightLabel.text = "Measuring..."
    }
    
    @IBAction func FreezeData(_ sender: Any) {
        endDistance = altitudeData.relativeAltitude
        let distance = (endDistance as! Decimal) - (startDistance as! Decimal)
        heightLabel.text = "Height from Zero Point: \(distance)"
    }
    @IBAction func ZeroDistance(_ sender: Any) {
        endDistance = 0
        heightLabel.text = "Data zerored out!"
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
