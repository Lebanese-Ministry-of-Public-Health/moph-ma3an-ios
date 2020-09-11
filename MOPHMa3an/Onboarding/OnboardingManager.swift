//
//  OnboardingManager.swift
//  TEDMOB

import Foundation
import FirebaseAuth

class OnboardingManager {

    static let shared = OnboardingManager()

    func returnCurrentLaunchPage() -> String {
        if !completedIWantToHelp {
            Logger.DLog("Intro Now" )
            return "intro"
        } else if Auth.auth().currentUser == nil {
            Logger.DLog("phoneNumber Now" )
            return "phoneNumber"
        } else if !hasConsented {
            Logger.DLog("consent Now" )
            return "consent"
        } else if !allowedPermissions {
            Logger.DLog("permissions Now" )
            return "permissions"
        } else if !completedBluetoothOnboarding {
            Logger.DLog("turnOnBluetooth Now" )
            return "turnOnBluetooth"
        } else {
            return "main"
        }
//        return " "
//        if Auth.auth().currentUser != nil  && completedIWantToHelp {
//            return "main"
//        }else {
//            return "intro"
//        }
       
    }
}

extension OnboardingManager {

    var completedIWantToHelp: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "completedIWantToHelp")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "completedIWantToHelp")
        }
    }

    var completedBluetoothOnboarding: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "completedBluetoothOnboarding")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "completedBluetoothOnboarding")
        }
    }

    var hasConsented: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "hasConsented")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "hasConsented")
        }
    }

    var allowedPermissions: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "allowedPermissions")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "allowedPermissions")
        }
    }
}
