//
//  TurnOnBluetoothViewController.swift
//  TEDMOB

import UIKit

class TurnOnBluetoothViewController: BaseViewController {
    @IBOutlet weak var arTitle: BaseLabel!{
        didSet {
            arTitle.numberOfLines  = 0
            arTitle.textAlignment  = .center
            arTitle.font = UIFont.bold(17)
        }
    }
    @IBOutlet weak var arPoint1: BaseLabel!{
        didSet {
            arPoint1.numberOfLines  = 0
            arPoint1.textAlignment  = .center
            arPoint1.font  = UIFont.regular(14)
        }
    }
    @IBOutlet weak var arPoint2: BaseLabel!{
        didSet {
            arPoint2.numberOfLines  = 0
            arPoint2.textAlignment  = .center
            arPoint2.font  = UIFont.regular(14)
        }
    }
    
    @IBOutlet weak var iTurnedOnBluetoothButton: RoundedGreenButton!
    @IBOutlet weak var enTitle: BaseLabel!{
        didSet {
            enTitle.numberOfLines  = 0
            enTitle.textAlignment  = .center
            enTitle.font = UIFont.bold(17)
        }
    }
    @IBOutlet weak var enPoint1: BaseLabel!{
        didSet {
            enPoint1.numberOfLines  = 0
            enPoint1.textAlignment  = .center
            enPoint1.font  = UIFont.regular(14)
        }
    }
    @IBOutlet weak var enPoint2: BaseLabel!{
        didSet {
            enPoint2.numberOfLines  = 0
            enPoint2.textAlignment  = .center
            enPoint2.font  = UIFont.regular(14)
        }
    }
    
    
    
    
    
    @IBAction func enabledBluetoothBtn(_ sender: UIButton) {
        
        OnboardingManager.shared.completedBluetoothOnboarding = true
        
        let blePoweredOn = BluetraceManager.shared.isBluetoothOn()
        let bleAuthorized = BluetraceManager.shared.isBluetoothAuthorized()
        
        BlueTraceLocalNotifications.shared.checkAuthorization { (granted) in
            if granted && blePoweredOn && bleAuthorized {
                self.performSegue(withIdentifier: "showFullySetUpFromTurnOnBtSegue", sender: self)
            } else {
                self.performSegue(withIdentifier: "showHomeFromTurnOnBtSegue", sender: self)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusBarStyle = .default
        navigationBarStyle = .appDefault
        setUI()
    }
    
}
extension TurnOnBluetoothViewController {
    func setUI(){
        
        setText()
    }
    func setText(){
        if LanguageHelper.getLanguage() == .arabic {
            iTurnedOnBluetoothButton.setTitle("لقد قمت بتشغيل البلوتوث", for: .normal)
        }else{
            iTurnedOnBluetoothButton.setTitle("I turned on Bluetooth", for: .normal)
        }
        self.arTitle.text = "قم بتشغيل البلوتوث"
        self.arPoint1.text = "قم بذلك من مركز التحكم أو الإعدادات."
        self.arPoint2.text = "ثم ارجع إلى التطبيق للتأكيد."
        
        self.enTitle.text = "Please turn on Bluetooth"
        self.enPoint1.text = "Do this either from the Control Center or the Phone Settings "
        self.enPoint2.text = "After you did that, Come back to the App & continue"
      
        
    }
    
}
