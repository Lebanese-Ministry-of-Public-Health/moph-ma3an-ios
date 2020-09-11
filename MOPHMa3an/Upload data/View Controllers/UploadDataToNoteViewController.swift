//
//  UploadDataToNoteViewController.swift
//  TEDMOB

import UIKit

class UploadDataToNoteViewController: UIViewController {

    @IBOutlet weak var headToNextLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setText()
    }
    
    func setText(){
        if LanguageHelper.getLanguage() == .arabic {
            titleLabel.text = "عند الـتأكد من النتيجة الإجابية لاختبار فيروس كورونا الذي خضعت له، من المحتمل أن يتم الاتصال بك من قبل وزارة ألصحة العامة لتذكيرك بضرورة تحميل البيانات المخزنة على هاتفك لإنذار المستخدمين الذين كانوا على مقربة منك دون الكشف عن هويتك"
            headToNextLabel.text = "اضغط عند الاتصال بك "
        }else {
            titleLabel.text = "After confirming that your PCR test result is positive, the Ministry of Public Health might call you to remind you to upload your data in order to alert users who were in close contact with you, without disclosing your identity."
            headToNextLabel.text = "Tap NEXT if you were contacted"
        }
    }

}
