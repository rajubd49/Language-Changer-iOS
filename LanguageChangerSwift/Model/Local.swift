//
//  Local.swift
//  LanguageChangerSwift
//
//  Created by Harish-Uz-Jaman Mridha Raju on 9/17/16.
//  Copyright © 2016 Raju. All rights reserved.
//

import UIKit


class Local: NSObject {
    
    var languageCode:String?
    var countryCode:String?
    var name:String?

    override init () {
        // uncomment this line if your class has been inherited from any other class
        super.init()
    }

    convenience init(languageCode:String?, countryCode:String?, name:String?) {
        self.init()
        
        self.languageCode = languageCode
        self.countryCode = countryCode
        self.name = name
    }
}
