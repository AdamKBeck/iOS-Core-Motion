import UIKit
import CoreMotion

class ViewController: UIViewController {
    // Motion manager
    var motion = CMMotionManager()
    var timer = Timer()
    
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
        startAccelerometers()
        
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func startAccelerometers() {
        // Make sure the accelerometer hardware is available.
        if self.motion.isAccelerometerAvailable {
            self.motion.accelerometerUpdateInterval = 1.0 / 5.0  // 60 Hz
            self.motion.startAccelerometerUpdates()
            
            // Configure a timer to fetch the data.
            self.timer = Timer(fire: Date(), interval: (1.0/60.0),
                               repeats: true, block: { (timer) in
                                // Get the accelerometer data.
                                if let data = self.motion.accelerometerData {
                                    let x = data.acceleration.x
                                    let y = data.acceleration.y
                                    let z = data.acceleration.z
                                    
                                    self.accXLabel.text = String(x)
                                    self.accYLabel.text = String(y)
                                    self.accZLabel.text = String(z)
                                    
                                    if (x > self.maxAccX) {
                                        self.maxAccXLabel.text = String(x)
                                        self.maxAccX = x
                                    }
                                    if (y > self.maxAccY) {
                                        self.maxAccYLabel.text = String(y)
                                        self.maxAccY = y
                                    }
                                    if (z > self.maxAccY) {
                                        self.maxAccZLabel.text = String(z)
                                        self.maxAccZ = z
                                    }
                                }
            })
            
            // Add the timer to the current run loop.
            RunLoop.current.add(self.timer, forMode: .defaultRunLoopMode)
        }
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

