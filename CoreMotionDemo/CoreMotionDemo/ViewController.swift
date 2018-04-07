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
    @IBOutlet weak var maxRotYLabel: UILabel!
    @IBOutlet weak var maxRotXLabel: UILabel!
    @IBOutlet weak var maxRotZLabel: UILabel!
    
    // Functions
    override func viewDidLoad() {
        self.resetMaxValues()
        startAccelerometers()
        startGyros()
        
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
            RunLoop.current.add(self.timer, forMode: .defaultRunLoopMode)
        }
    }
    
    func startGyros() {
        if motion.isGyroAvailable {
            self.motion.gyroUpdateInterval = 1.0 / 60.0
            self.motion.startGyroUpdates()
            
            // Configure a timer to fetch the accelerometer data.
            self.timer = Timer(fire: Date(), interval: (1.0/5.0),
                               repeats: true, block: { (timer) in
                                // Get the gyro data.
                                if let data = self.motion.gyroData {
                                    let x = data.rotationRate.x
                                    let y = data.rotationRate.y
                                    let z = data.rotationRate.z
                                    
                                    self.rotXLabel.text = String(x)
                                    self.rotYLabel.text = String(y)
                                    self.rotZLabel.text = String(z)
                                    
                                    if (x > self.maxRotX) {
                                        self.maxRotXLabel.text = String(x)
                                        self.maxRotX = x
                                    }
                                    if (y > self.maxRotY) {
                                        self.maxRotYLabel.text = String(y)
                                        self.maxRotY = y
                                    }
                                    if (z > self.maxRotZ) {
                                        self.maxRotZLabel.text = String(z)
                                        self.maxRotZ = z
                                    }
                                }
            })
            RunLoop.current.add(self.timer, forMode: .defaultRunLoopMode)
        }
    }
    
    @IBAction func resetMaxValues() {
        maxAccX = 0.0
        maxAccY = 0.0
        maxAccZ = 0.0
        
        maxRotX = 0.0
        maxRotY = 0.0
        maxRotZ = 0.0
        
        accXLabel.text = "0"
        accYLabel.text = "0"
        accZLabel.text = "0"
        rotXLabel.text = "0"
        rotYLabel.text = "0"
        rotZLabel.text = "0"
        
        maxAccXLabel.text = "0"
        maxAccYLabel.text = "0"
        maxAccZLabel.text = "0"
        maxRotXLabel.text = "0"
        maxRotXLabel.text = "0"
        maxRotXLabel.text = "0"
        maxRotXLabel.text = "0"
    }
    
}

