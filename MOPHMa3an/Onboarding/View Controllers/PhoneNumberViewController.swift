//
//  PhoneNumberViewController.swift
//  TEDMOB

import UIKit
import FirebaseAuth

class PhoneNumberViewController: BaseViewController, UITextFieldDelegate {

    @IBOutlet weak var arfirstLabel: BaseLabel!{
        didSet {
            arfirstLabel.font = UIFont.regular(15)
            arfirstLabel.numberOfLines  = 0
            arfirstLabel.textAlignment  = .center
        }
    }
    @IBOutlet weak var enFirstLabel: BaseLabel!{
        didSet {
            enFirstLabel.font = UIFont.regular(15)
            enFirstLabel.numberOfLines  = 0
            enFirstLabel.textAlignment  = .center
        }
    }
    
    @IBOutlet weak var arSecondLabel: BaseLabel!{
        didSet {
            arSecondLabel.font = UIFont.regular(15)
            arSecondLabel.numberOfLines  = 0
            arSecondLabel.textAlignment  = .center
        }
    }
    @IBOutlet weak var enSecondLabel: BaseLabel!{
        didSet {
            enSecondLabel.font = UIFont.regular(15)
            enSecondLabel.numberOfLines  = 0
            enSecondLabel.textAlignment  = .center
        }
    }
    
    @IBOutlet weak var phoneNumberField: UITextField!{
        didSet {
            #if DEBUG
            phoneNumberField.text = "+33633324460"
            #endif
            
        }
    }
    @IBOutlet weak var submitButton: RoundedGreenButton!{
        didSet {
            submitButton.setTitle("Submit", for: .normal)
        }
    }
    
    let MIN_PHONE_LENGTH = 8
    let PHONE_NUMBER_LENGTH = 15
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.phoneNumberField.addTarget(self, action: #selector(self.phoneNumberFieldDidChange), for: UIControl.Event.editingChanged)
        self.phoneNumberFieldDidChange()
        phoneNumberField.delegate = self
        dismissKeyboardOnTap()
        statusBarStyle = .default
        navigationBarStyle = .appDefault
        setUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.phoneNumberField.becomeFirstResponder()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    @IBAction func nextButtonClicked(_ sender: Any) {
        submitButton.isEnabled = false
        verifyPhoneNumberAndProceed(self.phoneNumberField.text ?? "")
    }

    @objc
    func phoneNumberFieldDidChange() {
        self.submitButton.isEnabled = self.phoneNumberField.text?.count ?? 0 >= MIN_PHONE_LENGTH
        if self.phoneNumberField.text?.count == PHONE_NUMBER_LENGTH {
            self.phoneNumberField.resignFirstResponder()
        }
    }

    func verifyPhoneNumberAndProceed(_ mobileNumber: String) {
        //DEBUG
//        self.performSegue(withIdentifier: "segueFromNumberToOTP", sender: self)
//        return
        activityIndicator.startAnimating()
        PhoneAuthProvider.provider().verifyPhoneNumber(mobileNumber, uiDelegate: nil) { [weak self] (verificationID, error) in
            if let error = error {
                let errorAlert = UIAlertController(title: "Error verifying phone number", message: error.localizedDescription, preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("Unable to verify phone number")
                }))
                self?.submitButton.isEnabled = true
                self?.present(errorAlert, animated: true)
                self?.activityIndicator.stopAnimating()
                Logger.DLog("Phone number verification error: \(error.localizedDescription)")
                return
            }
            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
            UserDefaults.standard.set(mobileNumber, forKey: "mobileNumber")
            self?.performSegue(withIdentifier: "segueFromNumberToOTP", sender: self)
            self?.activityIndicator.stopAnimating()
        }
    }

    //  limit text field input to 15 characters
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                           replacementString string: String) -> Bool {
        let maxLength = PHONE_NUMBER_LENGTH
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
}
extension PhoneNumberViewController {
    func setUI(){
        setTexts()
        setTextFieldUI()
    }
    func setTexts() {
        if LanguageHelper.getLanguage() == .arabic {
            self.submitButton.setTitle("إرسال", for: .normal)
        }else{
            self.submitButton.setTitle("SUBMIT", for: .normal)
        }
        self.arfirstLabel.text = "أدخل رقم هاتفك المحمول للتسجيل "
        self.arSecondLabel.text = "ستحصل عبر رسالة نصية على رقم تعريف شخصي لمرة واحدة"
        
        self.enFirstLabel.text = "Enter your mobile number to register"
        self.enSecondLabel.text = "You will receive a One-Time Pin (OTP) through SMS"
        
    }
    func setTextFieldUI(){
        self.phoneNumberField.backgroundColor = .appGray
        self.phoneNumberField.layer.cornerRadius = 20
        self.phoneNumberField.addToolBar()
        self.phoneNumberField.leftPaddingWidth = 10
        self.phoneNumberField.rigthPaddingWidth = 10
        self.phoneNumberField.placeholder = "+96170******"
        self.phoneNumberField.font  = .bold(17)
    }
}
