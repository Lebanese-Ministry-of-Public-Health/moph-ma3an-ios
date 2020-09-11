//
//  PogoInstructionsViewController.swift
//  TEDMOB

import UIKit

class PogoInstructionsViewController: BaseViewController {
    @IBOutlet weak var pageTitle: BaseLabel!{
        didSet {
            pageTitle.numberOfLines  = 0
            pageTitle.textAlignment  = .center
            pageTitle.font = UIFont.bold(17)
        }
    }
    @IBOutlet weak var point1: BaseLabel!{
        didSet {
            point1.numberOfLines  = 0
            point1.textAlignment  = .center
            point1.font  = UIFont.regular(14)
        }
    }
    @IBOutlet weak var point2: BaseLabel!{
        didSet {
            point2.numberOfLines  = 0
            point2.textAlignment  = .center
            point2.font  = UIFont.regular(14)
        }
    }
    @IBOutlet weak var point3: BaseLabel!{
        didSet {
            point3.numberOfLines  = 0
            point3.textAlignment  = .center
            point3.font  = UIFont.regular(14)
        }
    }
    @IBOutlet weak var point4: BaseLabel!{
        didSet {
            point4.numberOfLines  = 0
            point4.textAlignment  = .center
            point4.font  = UIFont.regular(14)
        }
    }
    @IBOutlet weak var continueButton: RoundedGreenButton!
    
   
    @IBOutlet weak var batteryNoticeLabel: BaseLabel!{
        didSet {
            batteryNoticeLabel.font = .light(13)
            batteryNoticeLabel.textColor = .appGreen
            batteryNoticeLabel.textAlignment  = .center
            batteryNoticeLabel.numberOfLines = 0
            batteryNoticeLabel.isHidden = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        addSwipeGesture()
    }
    func addSwipeGesture() {
            let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
            swipeLeft.direction = .left
            self.view.addGestureRecognizer(swipeLeft)
            
            let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
            swipeRight.direction = .right
            self.view.addGestureRecognizer(swipeRight)
        }
        @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
            if gesture.direction == .right {
                self.buttonLanguageTapped()
            }
            else if gesture.direction == .left {
                self.buttonLanguageTapped()
            }
        }
        func buttonLanguageTapped() {
                Logger.DLog("Flipping languages was \(LanguageHelper.getLanguageFamiliarName())")
                LanguageHelper.flipLanguae()
                Logger.DLog("Flipping languages now \(LanguageHelper.getLanguageFamiliarName())")
                self.setText()
            }
}
extension PogoInstructionsViewController {
    func setUI(){
        
        setText()
    }
    func setText(){
        
        if LanguageHelper.getLanguage() == .arabic {
            self.continueButton.setTitle("أكمل", for: .normal)
            self.pageTitle.text = "تنبيه هام! لمستخدمي أجهزة أيفون"
            self.point1.text = "لمستخدمي جهاز أيفون. يجب أن يبقى التطبيق مفتوحاً"
            self.point2.text = "للوصول إلى وضع توفير الطاقة"
            self.point3.text = "اقلب هاتفك للاسفل أو"
            self.point4.text = "ابقيه مقلوباً في جيبك"
        }else {
            continueButton.setTitle("NEXT", for: .normal)
            self.pageTitle.text = "iPhone Users: Take note!"
            self.point1.text = "On iPhone, the app needs to be kept on to work"
            self.point2.text = "To access power saver mode:"
            self.point3.text = "Turn the phone face down or,"
            self.point4.text = "Keep it upside down in your pocket"
        }
        
        
        
        
        self.batteryNoticeLabel.text = "This saved battery by letting the app scan with the phone display turned off"
        
    }
    
}
extension PogoInstructionsViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != nil && segue.identifier! == "ToHome" {
            segue.destination.modalPresentationStyle = .fullScreen
        }
    }
}
