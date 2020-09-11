//
//  IntroViewController.swift
//  TEDMOB

import UIKit
import FirebaseAuth

class IntroViewController: BaseTableViewController {
    
    @IBOutlet weak var appNameLabel: UILabel!{
        didSet {
            appNameLabel.textAlignment = .center
            appNameLabel.numberOfLines = 0
            appNameLabel.font = UIFont.bold(17)
            
        }
    }
    
    
    @IBOutlet weak var titleLabel: BaseLabel!{
        didSet {
            titleLabel.textAlignment = .center
            titleLabel.numberOfLines = 0
        }
    }
    @IBOutlet weak var descriptionLabel: BaseLabel!{
        didSet {
            descriptionLabel.textAlignment = .center
            descriptionLabel.numberOfLines = 0
            descriptionLabel.font = UIFont.regular(15)
        }
    }
    @IBOutlet weak var descrptionGreenLabel: BaseLabel!{
        didSet {
            descrptionGreenLabel.textAlignment = .center
            descrptionGreenLabel.numberOfLines = 0
            descrptionGreenLabel.font = UIFont.regular(14)
            descrptionGreenLabel.textColor = .appGreen
        }
        
    }
    @IBOutlet weak var agreeButton: RoundedGreenButton!
    
    @IBOutlet weak var buttonChangeOutlet: UIButton!{
        didSet {
            buttonChangeOutlet.setTitle("", for: .normal)
            buttonChangeOutlet.backgroundColor = .appGray
            buttonChangeOutlet.layer.cornerRadius = 15
            buttonChangeOutlet.tintColor = .black
        }
    }
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation{
        return .fade
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        statusBarStyle = .default
        navigationBarStyle = .appDefault
        addSwipeGesture()
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func buttonLanguageTapped() {
        Logger.DLog("Flipping languages was \(LanguageHelper.getLanguageFamiliarName())")
        LanguageHelper.flipLanguae()
        Logger.DLog("Flipping languages now \(LanguageHelper.getLanguageFamiliarName())")
        self.setText()
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
}
extension IntroViewController {
    func setUI(){
        self.tableView.separatorStyle = .none
        setText()
    }
    
    func setText(){
        buttonChangeOutlet.setTitle(LanguageHelper.getOppositeLanguageFamiliarName(), for: .normal)
        self.appNameLabel.text = "Ma3an - Together Against Corona"
        if LanguageHelper.getLanguage() == .arabic {
            self.agreeButton.setTitle("أكمل", for: .normal)
            
            
            self.titleLabel.text = "هذا التطبيق ينذرك عند تعرضك  لفيروس كورونا ويساعد على وقف انتشار الوباء "
            self.descriptionLabel.text = "يعلمك هذا التطبيق عن تواجدك على مسافة قريبة من مستخدم آخر أظهر نتيجة إيجابية لاختبار فيروس كورونا دون الكشف عن هويتك أو هوية المصاب"
            self.descrptionGreenLabel.text = "يقوم هذا التطبيق بإرسال ارشادات السلامة وكيفية التصرف عند التعرض لشخص مصاب"
        }else {
            
            self.agreeButton.setTitle("NEXT", for: .normal)
            self.titleLabel.text = "This app alerts you when you are exposed to COVID-19 and helps stop the spread of the epidemic"
            self.descriptionLabel.text = "If you have been in contact with a user who tested positive for COVID-19, Ma3an will notify you and send you safety instructions, guiding you to the adequate action."
            self.descrptionGreenLabel.text = "Ma3an will not disclose your identity or the identity of the user who tested positive for COVID-19 "
        }
        self.tableView.reloadData()
        
        
        
        
        
    }
}
extension  IntroViewController {
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


