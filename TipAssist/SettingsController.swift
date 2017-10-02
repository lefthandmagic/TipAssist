//
//  SettingsController.swift
//  TipAssist
//
//  Created by Praveen Murugesan on 10/1/17.
//  Copyright © 2017 Praveen Murugesan. All rights reserved.
//

import Foundation

import UIKit


class SettingsController: UIViewController, UITextFieldDelegate {

     @IBOutlet weak var defaultTipTextField: UITextField!

    var defaultTip: Int? {
        get {
            if let defaultTipText = defaultTipTextField?.text {
                return (defaultTipText.isEmpty) ? 15 : Int(defaultTipText)!
            }
            return 0
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.defaultTipTextField.addDoneButtonToKeyboard(myAction:  #selector(self.defaultTipTextField.resignFirstResponder))
        self.defaultTipTextField.delegate = self
        self.defaultTipTextField.keyboardType = UIKeyboardType.decimalPad
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    @IBAction func setDefaultTipValue(_ sender: UITextField) {
        defaultTipTextField.text = String(defaultTip!)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
    }



}
