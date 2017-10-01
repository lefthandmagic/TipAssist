
//
//  ViewController.swift
//  TipAssist
//
//  Created by Praveen Murugesan on 9/25/17.
//  Copyright © 2017 Praveen Murugesan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {


    @IBOutlet weak var tipPercentageSlider: UISlider!
    
    @IBOutlet weak var tipPercentageLabel: UILabel!

    @IBOutlet weak var billAmountTextField: UITextField!

    @IBOutlet weak var tipLabel: UILabel!

    @IBOutlet weak var totalLabel: UILabel!

    private var tipPercentage: Int = 15

    private var billAmount: Double {
        get {
            if let billAmountText = billAmountTextField?.text {
                return (billAmountText.isEmpty) ? 0: Double(billAmountText)!
            }
            return 0
        }
    }

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

    @IBAction func setTipCompute(_ sender: UIButton) {
        let tipPercentageString = sender.currentTitle!
        let end = tipPercentageString.index(tipPercentageString.endIndex, offsetBy: -1)
        tipPercentage = Int(tipPercentageString.substring(to: end))!
        refreshTip()
    }

    @IBAction func recomputeTip(_ sender: UISlider) {
        // computed with step function on 1
        tipPercentage = Int(tipPercentageSlider.value.rounded())
        refreshTip()
    }

    @IBAction func calculateTip(_ sender: UITextField) {
        refreshTip()
    }

    func refreshTip() {
        let tipPercentageDouble = Double(tipPercentage)
        let tip: Double = (billAmount * tipPercentageDouble/100).rounded(toPlaces: 2)
        tipLabel.text = tip.format(precision: ".2")
        totalLabel.text = (billAmount + tip).format(precision: ".2")
        tipPercentageLabel.text = String("\(tipPercentage)%")
        tipPercentageSlider.value = Float(tipPercentageDouble)
    }

}

