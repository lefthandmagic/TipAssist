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

    @IBOutlet weak var chooseRoundOffTextField: UITextField!

    let chooseRoundOffDropDown = DropDown()
    @IBOutlet weak var quickTip1: UITextField!
    @IBOutlet weak var quickTip2: UITextField!
    @IBOutlet weak var quickTip3: UITextField!


    var defaultTip: Int? {
        get {
            if let defaultTipText = defaultTipTextField?.text {
                return (defaultTipText.isEmpty) ? 15 : Int(defaultTipText)!
            }
            return 0
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private func getQuickTip(_ option: Int) -> Int {
        var defaultQuickTipText: String?
        var defaultQuickTipVal: Int = 0
        switch(option) {
        case 1:
            defaultQuickTipText = quickTip1?.text
            defaultQuickTipVal = TipDefaults.defaultQuickTip1Value
            break
        case 2:
            defaultQuickTipText = quickTip2?.text
            defaultQuickTipVal = TipDefaults.defaultQuickTip2Value
            break
        case 3:
            defaultQuickTipText = quickTip3?.text
            defaultQuickTipVal = TipDefaults.defaultQuickTip3Value
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

        let tripControl = TipControl()

        self.defaultTipTextField.text = String(tripControl.defaultTip)

        self.chooseRoundOffTextField.text = tripControl.roundOffOption
        //setup DropDown
        chooseRoundOffDropDown.anchorView = chooseRoundOffTextField
        chooseRoundOffDropDown.bottomOffset = CGPoint(x: 0, y: chooseRoundOffTextField.bounds.height)
        chooseRoundOffDropDown.dataSource = TipDefaults.defaultRoundOffOptions
        chooseRoundOffDropDown.selectionAction = { [unowned self] (index, item) in
            self.chooseRoundOffTextField.text = item
        }
        chooseRoundOffDropDown.direction = .bottom

        //setup quick tip options
        self.quickTip1.text = String(tripControl.quickTip1)
        self.quickTip2.text = String(tripControl.quickTip2)
        self.quickTip3.text = String(tripControl.quickTip3)
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
        let tipControl = TipControl(defaultTip: defaultTip!,
                                    quickTip1: getQuickTip(1),
                                    quickTip2: getQuickTip(2),
                                    quickTip3: getQuickTip(3),
                                    roundOffOption: chooseRoundOffTextField.text!)
        tipControl.save()
    }

}
