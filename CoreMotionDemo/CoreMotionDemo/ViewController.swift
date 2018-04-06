import UIKit
import CoreMotion

class ViewController: UIViewController {
    // Motion manager
    var motionManager = CMMotionManager()
    
    // Variables to hold data while the app is running
    var maxAccX = 0.0
    var maxAccY = 0.0
    var maxAccZ = 0.0
    var maxRotX = 0.0
    var maxRotY = 0.0
    var maxRotZ = 0.0
    
    // Outlets
    @IBOutlet weak var accXLabel: UILabel!
    @IBOutlet weak var accYLabel: UILabel!
    @IBOutlet weak var accZLabel: UILabel!
    @IBOutlet weak var maxAccXLabel: UILabel!
    @IBOutlet weak var maxAccYLabel: UILabel!
    @IBOutlet weak var maxAccZLabel: UILabel!
    
    @IBOutlet weak var rotXLabel: UILabel!
    @IBOutlet weak var rotYLabel: UILabel!
    @IBOutlet weak var rotZLabel: UILabel!
    @IBOutlet weak var maxRotXLabel: UILabel!
    @IBOutlet var maxRotYLabel: UIView!
    @IBOutlet weak var maxRotZLabel: UILabel!
    
    // Functions
    override func viewDidLoad() {
        self.resetMaxValues()
        
        // Set motion manager properties
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.gyroUpdateInterval = 0.2
        
        // start recording data
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!, withHandler: {
            (accelerometerData: CMAccelerometerData!, error: NSError!) -> Void in
            self.outputAccelerationData(accelerometerData.acceleration)
            if (error != nil) {
                print("\(error)")
            }
            } as! CMAccelerometerHandler)
        
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func outputAccelerationData(_ acceleration: CMAcceleration) {
        accXLabel?.text = "\(acceleration.x).2fg"
        
        if fabs(acceleration.x) > fabs(maxAccX) {
            maxAccX = acceleration.x
        }
        
//        accYLabel?.text = "\(acceleration.y).2fg"
//
//        if fabs(acceleration.y) > fabs(maxAccY) {
//            maxAccX = acceleration.y
//        }
//
//        accZLabel?.text = "\(acceleration.z).2fg"
//
//        if fabs(acceleration.z) > fabs(maxAccZ) {
//            maxAccX = acceleration.z
//        }
//
//        maxAccXLabel?.text = "\(maxAccX).2f"
//        maxAccYLabel?.text = "\(maxAccX).2f"
//        maxAccZLabel?.text = "\(maxAccX).2f"
    }
    

    @IBAction func resetMaxValues() {
        maxAccX = 0.0
        maxAccY = 0.0
        maxAccZ = 0.0
        
        maxRotX = 0.0
        maxRotY = 0.0
        maxRotZ = 0.0
    }
    
}

