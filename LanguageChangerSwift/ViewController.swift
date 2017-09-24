//
//  ViewController.swift
//  LanguageChangerSwift
//
//  Created by Harish-Uz-Jaman Mridha Raju on 9/17/16.
//  Copyright © 2016 Raju. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var localePicker: UIPickerView!
    @IBOutlet weak var languageNamelabel: UILabel!
    
    // View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.flagImageView.contentMode = .scaleAspectFit
        let languageManager = LanguageManager.sharedLanguageManager()
        var selectedIndex = 0
        let selectedLocale = languageManager.getSelectedLocale()
        selectedIndex = languageManager.availableLocales.index(of: selectedLocale)!
        // Move the picker to match what was selected previously.
        self.localePicker.selectRow(selectedIndex, inComponent: 0, animated: true)
        self.setupLocalisableElements()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Scroll back to the top of the text.
        self.textView.contentOffset = CGPoint.zero
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Utils
    func setupLocalisableElements() {
        
        self.title = Localised("Title")
        self.textView.text = Localised("Text")
        self.languageNamelabel.text = Localised("English")
        self.textView.contentOffset = CGPoint.zero
        
        // Flag images are named after the country code of the Localisation.
        if let image = LanguageManager.sharedLanguageManager().getSelectedLocale().countryCode {
            self.flagImageView.image = UIImage(named:image)
        } else {
            self.flagImageView.image = nil
        }
        
    }
    
    // UIPickerView Datasource and Delegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return LanguageManager.sharedLanguageManager().availableLocales.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let localeForRow = LanguageManager.sharedLanguageManager().availableLocales[row]
        return localeForRow.name!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let languageManager = LanguageManager.sharedLanguageManager()
        let localeForRow = languageManager.availableLocales[row]
        print("Language selected: \(String(describing: localeForRow.name))")
        languageManager.setLanguageWithLocale(localeForRow)
        self.setupLocalisableElements()
    }
}

