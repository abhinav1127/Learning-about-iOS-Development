//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Abhinav Tirath on 3/8/18.
//  Copyright © 2018 LearningSwift. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    @IBOutlet var backgroundView: UIView!
    
    var count = 1
    
    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet {
            updateCelsiusValue()
        }
    }
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf }()
    
    
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
        
        if let text = textField.text, let number = numberFormatter.number(from: text) {
            fahrenheitValue = Measurement(value: number.doubleValue, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.becomeFirstResponder()
    }
    
    func updateCelsiusValue() {
        if let celsiusValue = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("CView")
        
        updateCelsiusValue()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        count += 1
        
        if (count % 2 == 0) {
            backgroundView.backgroundColor = UIColor(red: 245, green: 244, blue: 241, alpha: 1)
        } else {
            backgroundView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentLocale = Locale.current
        let decimalSeparator: String = currentLocale.decimalSeparator ?? "."
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: decimalSeparator)
        let replacementTextHasDecimalSeparator = string.range(of: decimalSeparator)

        if existingTextHasDecimalSeparator != nil,
            replacementTextHasDecimalSeparator != nil {
            return false
        } else {
            return true
        }
    }
}
