//
//  HowItWorksViewController.swift
//  TEDMOB

import UIKit
import FirebaseAuth

class HowItWorksViewController: BaseTableViewController {

    @IBOutlet weak var pageTitle: BaseLabel!{
        didSet {
            pageTitle.font = UIFont.bold(17)
            pageTitle.numberOfLines  = 0
            pageTitle.textAlignment  = .center
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
    
   
    @IBOutlet weak var nextButton: RoundedGreenButton!
    
    @IBAction func greatBtnOnClick(_ sender: RoundedGreenButton) {
        OnboardingManager.shared.completedIWantToHelp = true
        goToOTPFlow()
        return
//
        
//
//        if Auth.auth().currentUser == nil {
//            self.performSegue(withIdentifier: "iWantToHelpToPhoneSegue", sender: self)
//        } else {
//            self.performSegue(withIdentifier: "iWantToHelpToConsentSegue", sender: self)
//        }
    }
    func goToOTPFlow(){
          self.performSegue(withIdentifier: "iWantToHelpToPhoneSegue", sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        statusBarStyle = .default
        navigationBarStyle = .appDefault
        setUI()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        self.setUI()
    }

}
extension  HowItWorksViewController {
    func setUI(){
        fillTexts()
        self.tableView.separatorStyle = .none
    }
    func fillTexts(){
        
        if LanguageHelper.getLanguage() == .arabic {
            self.nextButton.setTitle("أكمل", for: .normal)
            
            self.pageTitle.text = "كيف يعمل تطبيق Ma3an"
            self.point1.text = "يستخدم هذا التطبيق إشارات البلوتوث لجمع المعلومات التالية: التاريخ، الوقت، وقوة إشارة البلوتوث المرتبطة  بأجهزة مستخدمي  التطبيق المجاورين."
            self.point2.text = "يتم حفظ هذه المعلومات وتشفيرها حصراً  على هاتف المستخدم لمدة  ٣٠ يومًا "
            self.point3.text = "فور تسجيل نتيجة إيجابية لاختبار فيروس كورونا لأي مستخدم سوف تقوم وزارة الصحة العامة بالإستعانة بهذه المعلومات لإنذارالمستخدمين المخالطين دون الكشف عن هوية المصاب او المخالطين إطلاقا"
            self.point4.text = "لا يقوم التطبيق بجمع او حفظ أي بيانات متعلقة بتحديد الموقع الجغرافي أوأي بيانات شخصية "
            
            
        }else {
            
            self.nextButton.setTitle("NEXT", for: .normal)
            
            self.pageTitle.text = "How does Ma3an work?"
            self.point1.text = "The app uses Bluetooth to collect the following information: date, time, and strength of the Bluetooth signal from nearby users’ devices."
            self.point2.text = "The information is stored on your phone for 30 days "
            self.point3.text = "When a user tests positive for COVID-19, the information will allow the Ministry of Public Health to alert users who have been in close contact with the positive case without disclosing any of the users’ identities"
            self.point4.text = "No geo-location or personal data is collected or stored by this app"
        }
       
        
        self.tableView.reloadData()
        
        
    }
    
}
extension  HowItWorksViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return self.view.frame.width.heightRespectingAspectRatio(Constants.ImageAspectRatios.topImagesAspectRatio)
        case 1:
            return 80
        default:
            return UITableView.automaticDimension
        }
    }
}


extension  HowItWorksViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != nil && segue.identifier! == "iWantToHelpToPhoneSegue"{
            segue.destination.modalPresentationStyle = .fullScreen
        }
    }
}


