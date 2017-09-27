
//
//  ViewController.swift
//  TipAssist
//
//  Created by Praveen Murugesan on 9/25/17.
//  Copyright © 2017 Praveen Murugesan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {


    @IBOutlet weak var billAmountTextField: UITextField!

    @IBOutlet weak var tipLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.billAmountTextField.addDoneButtonToKeyboard(myAction:  #selector(self.billAmountTextField.resignFirstResponder))
        self.billAmountTextField.delegate = self
        self.billAmountTextField.keyboardType = UIKeyboardType.decimalPad
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }


    @IBAction func calculateTip(_ sender: UITextField) {
        if let textVal = sender.text {
            let billVal = Double(textVal)
            let tipVal = billVal != nil ? String(billVal! * 0.15) : nil
            tipLabel.text =  tipVal ?? "Invalid"
        }
    }

}

