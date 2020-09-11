//
//  PermissionsViewController.swift
//  TEDMOB

import UIKit
import UserNotifications

class PermissionsViewController: BaseTableViewController {
    
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
    
    
    
    @IBOutlet weak var batteryNoticeLabel: BaseLabel!{
        didSet {
            batteryNoticeLabel.font = .light(13)
            batteryNoticeLabel.textColor = .appGreen
            batteryNoticeLabel.textAlignment  = .center
            batteryNoticeLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet weak var proceedButton: RoundedGreenButton!{
        didSet {
            proceedButton.setTitle("PROCEED", for: .normal)
        }
    }
    
    @IBAction func allowPermissionsBtn(_ sender: RoundedGreenButton) {
        BluetraceManager.shared.turnOn()
        OnboardingManager.shared.allowedPermissions = true
        registerForPushNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusBarStyle = .default
        navigationBarStyle = .appDefault
        setUI()
        addSwipeGesture()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the navigation bar on other view controllers
        
    }
    
    func registerForPushNotifications() {
        BlueTraceLocalNotifications.shared.checkAuthorization { (_) in
            //Make updates to VCs if any here.
        }
    }
    
}
extension  PermissionsViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return self.view.frame.width.heightRespectingAspectRatio(Constants.ImageAspectRatios.topImagesAspectRatio)
        case 8 :
            return 30
        default:
            return UITableView.automaticDimension
        }
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
extension PermissionsViewController {
    func setUI(){
        self.tableView.separatorStyle = .none
        setText()
    }
    func setText(){
        if LanguageHelper.getLanguage() == .arabic {
            self.proceedButton.setTitle("أكمل", for: .normal)
            self.pageTitle.text = "تشغيل الإعدادات على التطبيق  "
            self.point1.text = "إستفد من هذا التطبيق وساعد على وقف انتشار وباء كورونا، عبر  تشغيل الاشعارات وتشغيل إشارة البلوتوث الخاصة بك.            يمكنك إلغاء هذا التطبيق في أي وقت"
            self.point2.text = "إختر نعم للشاشتين التاليتين للإعداد\n\n١- بلوتوث\n٢- الإشعارات"
            self.batteryNoticeLabel.text = "يلزم توفر البلوتوث والإشعارات حتى يعمل التطبيق. \n قد يزيد استخدام البطارية"
        }else {
            self.proceedButton.setTitle("NEXT", for: .normal)
            
            self.pageTitle.text = "Turn on settings on app"
            self.point1.text = "Benefit from Ma3an and help stop the spread of COVID 19 by turning on Notifications and turning on your Bluetooth signal. You can uninstall this app any time. "
            self.point2.text = "Select “YES” for the next two screens to set up.\n  1- Bluethooth \n  2- Push notifications"
            self.batteryNoticeLabel.text = "Bluetooth & Notifications are needed for the app to work.\n your battery usage may increase "
        }
        self.tableView.reloadData()
        
        
        
    }
    
}
