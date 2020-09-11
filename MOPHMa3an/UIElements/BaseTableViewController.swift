//
//  UITableViewController+Extensions.swift
//  TEDMOB
//
//  Created by TEDMOB on 5/22/20.
//  Copyright © 2020 TEDMOB. All rights reserved.
//

import UIKit
import UINavigationItem_Margin
class BaseTableViewController : UITableViewController  {
    var statusBarStyle : UIStatusBarStyle = .default {
        didSet{
            self.setNeedsStatusBarAppearanceUpdate()
            self.navigationController?.setNeedsStatusBarAppearanceUpdate()
            switch statusBarStyle {
            case .default:
                self.navigationController?.navigationBar.barStyle = .default
            case .lightContent:
                self.navigationController?.navigationBar.barStyle = .black
            @unknown default:
                self.navigationController?.navigationBar.barStyle = .default
            }
        }
    }
    
    var navigationBarStyle : NavigationBarType = .normal{
        didSet{
            switch navigationBarStyle{
            case .hidden:
                (self.navigationController as? BaseNavigationController)?.style = .hidden
            case .normal:
                (self.navigationController as? BaseNavigationController)?.style = .normal
            case .transparent:
                (self.navigationController as? BaseNavigationController)?.style = .transparent
            case .custom(let appearance):
                (self.navigationController as? BaseNavigationController)?.style = .custom(appearance)
            case .appDefault:
                (self.navigationController as? BaseNavigationController)?.style = .appDefault
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackButton()
        
    }
    @objc
    func backButtonTapped(){
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func addBackButton(){
        if self.navigationController == nil {
            
            return
        }
        if (self.navigationController!.viewControllers.count) == 1 {
            
            return
        }
        self.navigationController?.navigationItem.backBarButtonItem = nil
        let backButton = UIBarButtonItem(title: " ",
                                         style: .plain,
                                         target: self,
                                         action: #selector(self.backButtonTapped))
        
        
        backButton.image = UIImage(named: "iconbackNav")!.withRenderingMode(.alwaysOriginal)
        self.navigationItem.leftMargin = 0 
        backButton.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        navigationItem.leftBarButtonItem = backButton
    }
}
