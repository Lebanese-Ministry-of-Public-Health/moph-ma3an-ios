//
//  UploadDataStep1VC.swift
//  TEDMOB

import Foundation
import UIKit

class UploadDataStep1VC: UIViewController {
    @IBOutlet weak var verificationCode: UILabel!
    @IBOutlet weak var retryBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var pageSubTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        if let savedVerificationCode = UserDefaults.standard.string(forKey: OTPViewController.userDefaultsPinKey) {
            verificationCode.text = savedVerificationCode
        } else {
            fetchedHandshakePin()
        }
        setText()
        addSwipeGesture()
    }

    @IBAction func retryBtnTapped(_ sender: UIButton) {
        fetchedHandshakePin()
    }

    private func fetchedHandshakePin() {
        nextBtn.isEnabled = false
        retryBtn.isHidden = true
        activityIndicator.startAnimating()
        FirebaseAPIs.getHandshakePin { (pin) in
            if let pin = pin {
                self.verificationCode.text = pin
                UserDefaults.standard.set(pin, forKey: OTPViewController.userDefaultsPinKey)
                self.nextBtn.isEnabled = true
            } else {
                self.verificationCode.text = "ERROR"
                self.retryBtn.isHidden = false
            }
            self.activityIndicator.stopAnimating()
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
    func setText(){
        if LanguageHelper.getLanguage() == .arabic {
            self.nextBtn.setTitle("أكمل", for: .normal)
            pageSubTitle.text = "Verification Code"
            pageTitle.text = ""
        }else {
            nextBtn.setTitle("NEXT", for: .normal)
            pageSubTitle.text = "Verification Code"
            pageTitle.text = ""
        }
    }
}
