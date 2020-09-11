//
//  HelpVViewController.swift
//  TEDMOB
//
//  Created by TEDMOB on 6/24/20.
//  Copyright © 2020 TEDMOB. All rights reserved.
//

import UIKit
import WebKit
class HelpVViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let url = URL(string: "https://mophtracer.tedmob.com/help")
        let request = URLRequest.init(url: url!)
        self.webView.load(request)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
