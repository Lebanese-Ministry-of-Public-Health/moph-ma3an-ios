//
//  UploadDataStep2VC.swift
//  TEDMOB

import Foundation
import UIKit
import Firebase
import FirebaseFunctions
import CoreData

class UploadDataStep2VC: UIViewController {
    @IBOutlet weak var disclaimerTextLbl: UILabel!
    @IBOutlet weak var codeInputView: CodeInputView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var uploadErrorMsgLbl: UILabel!
    
    @IBOutlet weak var enterPinLabel: UILabel!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var uploadDataButton: RoundedGreenButton!
    let uploadFailErrMsg = "Upload failed. Please try again later."
    let invalidPinErrMsg = "Invalid PIN"
    let invalidPinErrMsgAR = "رمز PIN غير صالح"
    
    lazy var functions = Functions.functions(region: PlistHelper.getvalueFromInfoPlist(withKey: "CLOUDFUNCTIONS_REGION") ?? "asia-east2")
    let storageUrl = PlistHelper.getvalueFromInfoPlist(withKey: "FIREBASE_STORAGE_URL") ?? ""
    
    override func viewDidLoad() {
//        disclaimerTextLbl.semiBold(text: "We don’t collect any geolocation or personal data.")
        _ = codeInputView.becomeFirstResponder()
        dismissKeyboardOnTap()
        setText()
        addSwipeGesture()
    }
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func uploadDataBtnTapped(_ sender: UIButton) {
        sender.isEnabled = false
        self.uploadErrorMsgLbl.isHidden = true
        activityIndicator.startAnimating()
        let code = codeInputView.text
        
        functions.httpsCallable("getUploadToken").call(code) { [unowned self] (result, error) in
            if let error = error as NSError? {
                sender.isEnabled = true
                self.activityIndicator.stopAnimating()
                self.uploadErrorMsgLbl.text = self.uploadFailErrMsg
                
                if error.domain == FunctionsErrorDomain {
                    let code = FunctionsErrorCode(rawValue: error.code)
                    let message = error.localizedDescription
                    let details = error.userInfo[FunctionsErrorDetailsKey]
                    
                    Logger.DLog("Cloud Function Error - [\(String(describing: code))][\(message)][\(String(describing: details))]")
                }
                
                Logger.DLog("Error - \(error)")
            }
            
            if let token = (result?.data as? [String: Any])?["token"] as? String {
                self.uploadFile(token: token) { success in
                    if success {
                        self.performSegue(withIdentifier: "showSuccessVCSegue", sender: nil)
                    } else {
                        self.uploadErrorMsgLbl.isHidden = false
                        self.uploadErrorMsgLbl.text = self.uploadFailErrMsg
                        sender.isEnabled = true
                        self.activityIndicator.stopAnimating()
                    }
                }
            } else {
                self.uploadErrorMsgLbl.isHidden = false
                if LanguageHelper.getLanguage() == .arabic {
                    self.uploadErrorMsgLbl.text = self.invalidPinErrMsgAR
                }else{
                    self.uploadErrorMsgLbl.text = self.invalidPinErrMsg
                }
                
                sender.isEnabled = true
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func uploadFile(token: String, _ result: @escaping (Bool) -> Void) {
        let manufacturer = "Apple"
        let model = DeviceInfo.getModel().replacingOccurrences(of: " ", with: "")
        
        let date: Date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd_HH-mm-ss"
        let todayDate = dateFormatter.string(from: date)
        
        let file = "StreetPassRecord_\(manufacturer)_\(model)_\(todayDate).json"
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let recordsFetchRequest: NSFetchRequest<Encounter> = Encounter.fetchRequestForRecords()
        let eventsFetchRequest: NSFetchRequest<Encounter> = Encounter.fetchRequestForEvents()
        
        managedContext.perform { [unowned self] in
            guard let records = try? recordsFetchRequest.execute() else {
                Logger.DLog("Error fetching records")
                result(false)
                return
            }
            
            guard let events = try? eventsFetchRequest.execute() else {
                Logger.DLog("Error fetching events")
                result(false)
                return
            }
            
            let data = UploadFileData(token: token, records: records, events: events)
            
            let encoder = JSONEncoder()
            guard let json = try? encoder.encode(data) else {
                Logger.DLog("Error serializing data")
                result(false)
                return
            }
            
            guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                Logger.DLog("Error locating user documents directory")
                result(false)
                return
            }
            
            let fileURL = directory.appendingPathComponent(file)
            
            do {
                try json.write(to: fileURL, options: [])
            } catch {
                Logger.DLog("Error writing to file")
                result(false)
                return
            }
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyyMMdd"
            let dateString = formatter.string(from: Date())
            let fileRef = Storage.storage(url: self.storageUrl).reference().child("streetPassRecords/\(dateString)/\(file)")
            
            _ = fileRef.putFile(from: fileURL, metadata: nil) { metadata, error in
                guard let metadata = metadata else {
                    Logger.DLog("Error uploading file - \(String(describing: error))")
                    result(false)
                    return
                }
                
                let size = metadata.size
                
                do {
                    try FileManager.default.removeItem(at: fileURL)
                } catch {
                    Logger.DLog("Error deleting uploaded file on local device")
                }
                
                Logger.DLog("File uploaded [\(size)]")
                result(true)
            }
        }
    }
    
    
    func setText(){
        if LanguageHelper.getLanguage() == .arabic {
            uploadDataButton.setTitle("تحميل البيانات", for: .normal)
            enterPinLabel.text = "ادخل رمز التعريف"
            informationLabel.text = ""
        }else {
            uploadDataButton.setTitle("UPLOAD DATA", for: .normal)
            enterPinLabel.text = "Enter Pin"
            informationLabel.text = ""
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
