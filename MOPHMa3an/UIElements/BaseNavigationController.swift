//
//  BaseNavigationController.swift
//  Sanita
//
//  Created by TEDMOB on 7/5/18.
//  Copyright © 2018 Tedmob. All rights reserved.

import UIKit
//
//  File.swift
//  Sanita
//
//  Created by Mojtaba Al Moussawi on 6/19/19.
//  Copyright © 2019 Tedmob. All rights reserved.
//

import UIKit

enum NavigationBarType{
    
    case normal
    
    case transparent
    
    case hidden
    
    case custom(NavigationBarAppearance)
    
    case appDefault
    
    
    struct NavigationBarAppearance {
        
        var barTintColor : UIColor?
        var tintColor : UIColor
        var isTranslucent : Bool
        var titleTextAttributes : [NSAttributedString.Key : Any]?
        var shadowImage : UIImage?
        var shouldClipsToBound : Bool
        var backgroundImage : UIImage?
        var position : UIBarPosition?
        var metrics : UIBarMetrics
        
        init(barTintColor : UIColor?,
             tintColor: UIColor,
             isTranslucent : Bool,
             titleTextAttributes :[NSAttributedString.Key : Any]? = nil,
             shadowImage : UIImage? = nil,
             shouldClipsToBound : Bool = false,
             barPosition : UIBarPosition? = nil,
             barMetrics : UIBarMetrics = .default,
             backgroundImage : UIImage? = nil) {
            self.barTintColor = barTintColor
            self.tintColor = tintColor
            self.isTranslucent = isTranslucent
            self.shadowImage = shadowImage
            self.shouldClipsToBound  = shouldClipsToBound
            self.titleTextAttributes = titleTextAttributes
            self.backgroundImage = backgroundImage
            self.position = barPosition
            self.metrics = barMetrics
            
        }
        
        init() {
            self.isTranslucent = false
            self.shouldClipsToBound = false
            self.metrics = .default
            self.tintColor = .blue
        }
    }
    
    var isTransparent : Bool{
        switch self {
        case .transparent:
            return true
        default:
            return false
        }
    }
    
    var isHidden : Bool{
        switch self {
        case .hidden:
            return true
        default:
            return false
        }
    }
}


extension NavigationBarType.NavigationBarAppearance{
    
    func getAppBaseStyle() -> NavigationBarType.NavigationBarAppearance{
        var appearance = NavigationBarType.NavigationBarAppearance()
        appearance.backgroundImage = UIImage()
        appearance.metrics = .default
        appearance.shadowImage = UIImage()
        appearance.titleTextAttributes = [ .foregroundColor : UIColor.white]
        appearance.barTintColor = .appGreen
        appearance.tintColor = .appGreen
        
        return appearance
    }
    
}


class BaseNavigationController: UINavigationController {
    // MARK: - Lifecycle
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.setup()
    }
    
    override init(navigationBarClass: AnyClass?, toolbarClass: AnyClass?) {
        super.init(navigationBarClass: navigationBarClass, toolbarClass: toolbarClass)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setup()
    }
    
    public var style : NavigationBarType? = .normal{
        didSet{
            switch style! {
            case .custom(let appearance):
                if isNavigationBarHidden { self.setNavigationBarHidden(false, animated: false)}
                self.navigationBar.applyStyle(appearance: appearance)
            case .hidden:
                self.setNavigationBarHidden(true, animated: true)
            case .normal:
                if isNavigationBarHidden { self.setNavigationBarHidden(false, animated: false)}
                self.navigationBar.resetAppearance()
            case .transparent:
                if isNavigationBarHidden { self.setNavigationBarHidden(false, animated: false)}
                self.navigationBar.applyTransparency()
            case .appDefault:
                if isNavigationBarHidden { self.setNavigationBarHidden(false, animated: false)}
                self.navigationBar.applyStyle(appearance: NavigationBarType.NavigationBarAppearance().getAppBaseStyle())
            }
        }
    }
    
    private func setup() {
        delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // This needs to be in here, not in init
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactivePopGestureRecognizer?.isEnabled = true
    }
    
    deinit {
        delegate = nil
        interactivePopGestureRecognizer?.delegate = nil
    }
    
    // MARK: - Overrides
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        duringPushAnimation = true
        
        super.pushViewController(viewController, animated: animated)
    }
    
    
    // MARK: - Private Properties
    
    fileprivate var duringPushAnimation = false
}

// MARK: - UINavigationControllerDelegate

extension BaseNavigationController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let swipeNavigationController = navigationController as? BaseNavigationController else { return }
        
        swipeNavigationController.duringPushAnimation = false
    }
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC   : UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
    
}

// MARK: - UIGestureRecognizerDelegate

extension BaseNavigationController {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard gestureRecognizer == interactivePopGestureRecognizer else {
            return true // default value
        }
        
        // Disable pop gesture in two situations:
        // 1) when the pop animation is in progress
        // 2) when user swipes quickly a couple of times and animations don't have time to be performed
        return viewControllers.count > 1 && duringPushAnimation == false
    }
}
