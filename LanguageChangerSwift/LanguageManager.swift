//
//  LanguageManager.swift
//  LanguageChangerSwift
//
//  Created by Harish-Uz-Jaman Mridha Raju on 9/17/16.
//  Copyright © 2016 Raju. All rights reserved.
//

import UIKit

func Localised(_ key:String) -> String {
    
    let languageCode =  UserDefaults.standard.string(forKey: Constant.DEFAULTS_KEY_LANGUAGE_CODE)
    let bundlePath = Bundle.main.path(forResource: languageCode as String?, ofType: "lproj")
    let Languagebundle = Bundle(path: bundlePath!)
    
    return (Languagebundle?.localizedString(forKey: key, value: key, table: nil))!
}

class LanguageManager: NSObject {
    
    struct Static {
        static var oneceToken: Int = 0
        static var intance: LanguageManager? = nil
    }
    private static var __once: () = { () -> Void in
        Static.intance = LanguageManager()
    }()
    
    var availableLocales = [Local]()
    
    
    class func sharedLanguageManager() -> LanguageManager {
        _ = self.__once
        return Static.intance!
    }
    
    override init() {
        super.init()
        
        // Manually create a list of available localisations for this example project.
        let bengali = Local(languageCode: "bn", countryCode: "bn", name: "বাংলা")
        let english = Local(languageCode: "en", countryCode: "en", name: "United Kingdom")
        let french = Local(languageCode: "fr", countryCode: "fr", name: "France")
        let german = Local(languageCode: "de", countryCode: "de", name: "Deutschland")
        let italian = Local(languageCode: "it", countryCode: "it", name: "Italia")
        let japanese = Local(languageCode: "ja", countryCode: "jp", name: "日本")
        self.availableLocales = [bengali, english, french, german, italian, japanese]
        
    }
    
    func setLanguageWithLocale(_ locale: Local) {
        UserDefaults.standard.set(locale.languageCode, forKey: Constant.DEFAULTS_KEY_LANGUAGE_CODE)
        UserDefaults.standard.synchronize()
    }
    
    func getSelectedLocale() -> Local {
        var selectedLocale: Local? = nil
        // Get the language code.
        
        if let languageCode = UserDefaults.standard.string(forKey: Constant.DEFAULTS_KEY_LANGUAGE_CODE)?.lowercased() {
            // Iterate through available localisations to find the one that matches languageCode.
            for locale: Local in self.availableLocales {
                if locale.languageCode!.caseInsensitiveCompare(languageCode) == .orderedSame {
                    selectedLocale = locale
                }
            }
        }
        
        //If no language selected, get the device language
        let languageCode = (Locale.current as NSLocale).object(forKey: NSLocale.Key.languageCode) as! String
        let lacalIdentifire = (Locale.current as NSLocale).object(forKey: NSLocale.Key.identifier) as! String
        
        return selectedLocale ?? Local(languageCode: languageCode, countryCode: languageCode, name: lacalIdentifire)
    }
    
    func getTranslationForKey(_ key: String) -> String {
        // Get the language code.
        let languageCode = UserDefaults.standard.string(forKey: Constant.DEFAULTS_KEY_LANGUAGE_CODE)!.lowercased()
        // Get the relevant language bundle.
        let bundlePath = Bundle.main.path(forResource: languageCode, ofType: "lproj")!
        let languageBundle = Bundle(path: bundlePath)
        // Get the translated string using the language bundle.
        var translatedString = languageBundle!.localizedString(forKey: key, value: "", table: nil)
        if translatedString.characters.count < 1 {
            // There is no localizable strings file for the selected language.
            translatedString = NSLocalizedString(key, tableName: nil, bundle: Bundle.main, value: key, comment: key)
        }
        return translatedString
    }

}
