//
//  SettingsController.swift
//  TipAssist
//
//  Created by Praveen Murugesan on 10/1/17.
//  Copyright © 2017 Praveen Murugesan. All rights reserved.
//

import Foundation

import UIKit
import DropDown

class SettingsController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var defaultTipTextField: UITextField!

    let defaults: UserDefaults = UserDefaults.standard

    @IBOutlet weak var chooseRoundOffTextField: UITextField!

    let chooseRoundOffDropDown = DropDown()
    @IBOutlet weak var quickTip1: UITextField!
    @IBOutlet weak var quickTip2: UITextField!
    @IBOutlet weak var quickTip3: UITextField!

    let defaultTipKey: String = "DEFAULT_TIP_KEY"
    let defaultRoundOffOptionKey: String = "DEFAULT_ROUNDOFF_OPTION_KEY"
    let defaultQuickTip1: String = "QUICK_TIP_1_KEY"
    let defaultQuickTip2: String = "QUICK_TIP_2_KEY"
    let defaultQuickTip3: String = "QUICK_TIP_3_KEY"

    let defaultQuickTip1Value = 10
    let defaultQuickTip2Value = 15
    let defaultQuickTip3Value = 20


    var defaultTip: Int? {
        get {
            if let defaultTipText = defaultTipTextField?.text {
                return (defaultTipText.isEmpty) ? 15 : Int(defaultTipText)!
            }
            return 0
        }
    }

    func getQuickTip(_ option: Int) -> Int {
        var defaultQuickTipText: String?
        var defaultQuickTipVal: Int = 0
        switch(option) {
        case 1:
            defaultQuickTipText = quickTip1?.text
            defaultQuickTipVal = defaultQuickTip1Value
            break
        case 2:
            defaultQuickTipText = quickTip2?.text
            defaultQuickTipVal = defaultQuickTip2Value
            break
        case 3:
            defaultQuickTipText = quickTip3?.text
            defaultQuickTipVal = defaultQuickTip3Value
            break
        default:
            fatalError()
        }
        if defaultQuickTipText != nil {
            return (defaultQuickTipText!.isEmpty) ? defaultQuickTipVal : Int(defaultQuickTipText!)!
        }
        return 0
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.defaultTipTextField.addDoneButtonToKeyboard(myAction:  #selector(self.defaultTipTextField.resignFirstResponder))
        self.quickTip1.addDoneButtonToKeyboard(myAction:  #selector(self.quickTip1.resignFirstResponder))
        self.quickTip2.addDoneButtonToKeyboard(myAction:  #selector(self.quickTip2.resignFirstResponder))
        self.quickTip3.addDoneButtonToKeyboard(myAction:  #selector(self.quickTip3.resignFirstResponder))
        self.defaultTipTextField.delegate = self
        self.quickTip1.delegate = self
        self.quickTip2.delegate = self
        self.quickTip3.delegate = self
        self.defaultTipTextField.keyboardType = UIKeyboardType.decimalPad
        self.quickTip1.keyboardType = UIKeyboardType.decimalPad
        self.quickTip2.keyboardType = UIKeyboardType.decimalPad
        self.quickTip3.keyboardType = UIKeyboardType.decimalPad

        // set default Tip text field
        if (defaults.object(forKey: defaultTipKey) != nil) {
            self.defaultTipTextField.text = String(defaults.integer(forKey: defaultTipKey))
        } else {
            self.defaultTipTextField.text = String(defaultTip!)
        }

        //set roundoff value
        if (defaults.object(forKey: defaultRoundOffOptionKey) != nil) {
            self.chooseRoundOffTextField.text = defaults.string(forKey: defaultRoundOffOptionKey)
        } else {
            self.chooseRoundOffTextField.text = "None"
        }
        //setup DropDown
        chooseRoundOffDropDown.anchorView = chooseRoundOffTextField
        chooseRoundOffDropDown.bottomOffset = CGPoint(x: 0, y: chooseRoundOffTextField.bounds.height)
        chooseRoundOffDropDown.dataSource = [
            "None",
            "Round Up",
            "Round Down"
        ]
        chooseRoundOffDropDown.selectionAction = { [unowned self] (index, item) in
            self.chooseRoundOffTextField.text = item
        }
        chooseRoundOffDropDown.direction = .bottom

        //setup quick tip options
        if (defaults.object(forKey: defaultQuickTip1) != nil) {
            self.quickTip1.text = String(defaults.integer(forKey: defaultQuickTip1))
        } else {
            quickTip1.text = "10"
        }
        if (defaults.object(forKey: defaultQuickTip2) != nil) {
            self.quickTip2.text = String(defaults.integer(forKey: defaultQuickTip2))
        } else {
            quickTip2.text = "15"
        }
        if (defaults.object(forKey: defaultQuickTip3) != nil) {
            self.quickTip3.text = String(defaults.integer(forKey: defaultQuickTip3))
        } else {
            quickTip3.text = "20"
        }

    }

    @IBAction func showDropDown(_ sender: Any) {
        chooseRoundOffDropDown.show()
    }

    /**
     * Text field delegate callback for adding "done" action to keyboard
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    /**
      * Prepare to go back after saving settings
      */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        defaults.set(defaultTip!, forKey: defaultTipKey)
        defaults.set(chooseRoundOffTextField.text!, forKey: defaultRoundOffOptionKey)
        defaults.set(getQuickTip(1), forKey:defaultQuickTip1)
        defaults.set(getQuickTip(2), forKey:defaultQuickTip2)
        defaults.set(getQuickTip(3), forKey:defaultQuickTip3)
    }

}
