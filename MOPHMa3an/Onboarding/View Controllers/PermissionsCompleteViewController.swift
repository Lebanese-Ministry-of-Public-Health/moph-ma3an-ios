//
//  PermissionsCompleteViewController.swift
//  TEDMOB

import UIKit

class PermissionsCompleteViewController: BaseViewController {
    @IBOutlet weak var arTitle: BaseLabel!{
        didSet {
            arTitle.numberOfLines  = 0
            arTitle.textAlignment  = .center
            arTitle.font = UIFont.bold(17)
        }
    }
    @IBOutlet weak var continueButton: RoundedGreenButton!
    @IBOutlet weak var arPoint: BaseLabel!{
        didSet {
            arPoint.numberOfLines  = 0
            arPoint.textAlignment  = .center
            arPoint.font  = UIFont.regular(14)
        }
    }
    
    @IBOutlet weak var enTitle: BaseLabel!{
        didSet {
            enTitle.numberOfLines  = 0
            enTitle.textAlignment  = .center
            enTitle.font = UIFont.bold(17)
        }
    }
    @IBOutlet weak var enPoint: BaseLabel!{
        didSet {
            enPoint.numberOfLines  = 0
            enPoint.textAlignment  = .center
            enPoint.font  = UIFont.regular(14)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusBarStyle = .default
        navigationBarStyle = .appDefault
        setUI()
    }
}
extension PermissionsCompleteViewController {
    func setUI(){
        
        setText()
    }
    func setText(){
        
        if LanguageHelper.getLanguage() == .arabic {
            self.continueButton.setTitle("أكمل", for: .normal)
        }else{
            continueButton.setTitle("NEXT", for: .normal)
        }
        self.arTitle.text = "تم تشغيل جميع الإعدادات بنجاح"
        self.arPoint.text = "يرجى ترك جميع الإعدادات قيد التشغيل حتى انتهاء وباء كورونا"
        
        self.enTitle.text = "All settings are now ON"
        self.enPoint.text = "Please leave all the settings turned on until the end of COVID-19 Pandemic"
        
      
        
    }
    
}
