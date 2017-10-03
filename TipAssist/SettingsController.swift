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

    let defaultTipKey :String = "DEFAULT_TIP_KEY"

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
        if (defaults.object(forKey: defaultTipKey) != nil) {
            self.defaultTipTextField.text = String(defaults.integer(forKey: defaultTipKey))
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
    }

    @IBAction func showDropDown(_ sender: Any) {
        chooseRoundOffDropDown.show()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        defaults.set(defaultTip!, forKey: defaultTipKey)
    }

}
