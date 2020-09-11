//
//  UploadDataSuccessVC.swift
//  TEDMOB

import Foundation
import UIKit

class UploadDataSuccessVC: UIViewController {
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBAction func doneBtnTapped(_ sender: UIButton) {
        // Bring user back to home tab
        self.navigationController?.tabBarController?.selectedIndex = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setText()
    }
    func setText(){
            if LanguageHelper.getLanguage() == .arabic {
                infoLabel.text = "تم تحميل بياناتك بنجاح الى قاعدة البيانات الآمنة التابعة لوزارة الصحة العامة. نتمنى لك الشفاء العاجل و السلامة"
            }else {
                infoLabel.text = "Your data has been successfully uploaded to the Ministry of Public Health (MoPH) secure database. We wish you a speedy recovery and stay safe"
            }
        }

}
