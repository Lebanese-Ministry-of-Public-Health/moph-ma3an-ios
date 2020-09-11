//
//  LanguageHelper.swift
//  TEDMOB
//
//  Created by TEDMOB on 6/25/20.
//  Copyright © 2020 TEDMOB. All rights reserved.
//

import Foundation
class LanguageHelper {
    
    enum Langauge:String{
        case arabic = "ar"
        case english = "en"
    }
    
    class func getLanguage() -> Langauge{
        
        guard let lang = UserDefaults.standard.value(forKey: "app_language_custom") as? String else {
            return .arabic
        }
        guard let lg = Langauge(rawValue: lang) else {
            return .arabic
        }
        return lg
    }
    
    class func setLanguage( _ lang: Langauge) {
        UserDefaults.standard.set(lang.rawValue, forKey: "app_language_custom")
    }
    
    class func flipLanguae() {
        if self.getLanguage() == .arabic {
            self.setLanguage(.english)
            return 
        }
        self.setLanguage(.arabic)
    }
    class func getLanguageFamiliarName() -> String {
        if self.getLanguage() == .arabic {
            return "العربية"
        }
        return "English"
    }
    class func getLanguageAPIName() -> String {
        if self.getLanguage() == .arabic {
            return "ar"
        }
        return "en"
    }
    class func getOppositeLanguageFamiliarName() -> String {
        if self.getLanguage() == .arabic {
            return "English"
        }
        return "العربية"
    }
    
    class var isLanguageSet: Bool {
        return UserDefaults.standard.value(forKey: "app_language_custom")  != nil
    }
    
    class func  initialize(){
        guard !LanguageHelper.isLanguageSet else {
            return
        }
        Logger.DLog("Language not already set. will set now ")
        self.setLanguage(.arabic)
        
    }
    
}
