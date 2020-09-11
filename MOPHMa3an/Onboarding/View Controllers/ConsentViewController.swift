//
//  ConsentViewController.swift
//  TEDMOB

import UIKit
import SafariServices

class ConsentViewController: BaseTableViewController, SFSafariViewControllerDelegate {
    @IBOutlet weak var privacyButton: UIButton!{
        didSet {
            privacyButton.setTitleColor(.appGreen, for: .normal)
        }
    }
    @IBOutlet weak var submitButton: RoundedGreenButton!
    
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
    
    @IBOutlet weak var readOurLabel: UILabel!
    @IBOutlet weak var point2: BaseLabel!{
        didSet {
            point2.numberOfLines  = 0
            point2.textAlignment  = .center
            point2.font  = UIFont.regular(14)
        }
    }

    @IBAction func consentBtn(_ sender: RoundedGreenButton) {
        OnboardingManager.shared.hasConsented = true
    }
    
    
    @IBAction func privacySafeguardsBtn(_ sender: Any) {
        guard let url = URL(string: "https://mophtracer.tedmob.com/privacy-policy") else {
            return
        }
        
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
        
        safariVC.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusBarStyle = .default
        navigationBarStyle = .appDefault
        setUI()
        addSwipeGesture()
    }
    
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
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
extension  ConsentViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return self.view.frame.width.heightRespectingAspectRatio(Constants.ImageAspectRatios.topImagesAspectRatio)
        case 7 :
            return 30
        default:
            return UITableView.automaticDimension
        }
    }
}

extension  ConsentViewController {
    func setUI(){
        self.tableView.separatorStyle = .none
        setText()
    }
    func setText(){
        if LanguageHelper.getLanguage() == .arabic {
            privacyButton.setTitle("سياسة الخصوصية", for: .normal)
            self.submitButton.setTitle("أكمل", for: .normal)
            readOurLabel.text = "اقرأ"
            self.pageTitle.text = "مطلوب موافقتك على آلية عمل هذا التطبيق خاصة بما يتعلق بالتالي:"
            self.point1.text = "- حفظ رقم هاتفك المحمول في قاعدة بيانات وزارة الصحة العامة بطريقة آمنة وسرية"
            self.point2.text = "- في حال اصابتك بفيروس الكورونا: السماح لوزارة الصحة باستعمال معلومات التطبيق الموجودة على هاتفك لإبلاغ المخالطين فور التشخيص دون الكشف عن هويتك أو هوية المخالطين"
        }else {
            
            privacyButton.setTitle("privacy policy", for: .normal)
            submitButton.setTitle("NEXT", for: .normal)
            readOurLabel.text = "Read our"
            self.pageTitle.text = "Ma3an needs your consent for the following"
            self.point1.text = "To store your mobile number in a secured database, hosted at the Ministry of Public Health"
            self.point2.text = "If you test positive for COVID-9, allow the Ministry of Public Health to use the information stored on your phone to notify users who were in close contact with you without disclosing your identity or the identity of the contacts."
        }
        
        self.tableView.reloadData()
        
        
        
    }
    
}



