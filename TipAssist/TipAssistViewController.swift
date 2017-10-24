
//
//  ViewController.swift
//  TipAssist
//
//  Created by Praveen Murugesan on 9/25/17.
//  Copyright © 2017 Praveen Murugesan. All rights reserved.
//

import UIKit


class TipAssistViewController: UIViewController, UITextFieldDelegate {


    @IBOutlet weak var tipPercentageSlider: UISlider!
    
    @IBOutlet weak var tipPercentageLabel: UILabel!

    @IBOutlet weak var billAmountTextField: UITextField!

    @IBOutlet weak var tipLabel: UILabel!

    @IBOutlet weak var totalLabel: UILabel!

    private var tipPercentage: Int = TipDefaults.defaultTipValue

    private var total: Double = 0.0

    private var tip: Double = 0.0

    private var billAmount: Double {
        get {
            if let billAmountText = billAmountTextField?.text {
                return (billAmountText.isEmpty) ? 0: Double(billAmountText)!
            }
            return 0
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.billAmountTextField.addDoneButtonToKeyboard(myAction:  #selector(self.billAmountTextField.resignFirstResponder))
        self.billAmountTextField.delegate = self
        self.billAmountTextField.keyboardType = UIKeyboardType.decimalPad

        let tipControl = TipControl()
        self.tipPercentage = tipControl.defaultTip
        self.tipPercentageSlider.value = Float(self.tipPercentage)
        updateUI()

    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    @IBAction func setTipCompute(_ sender: UIButton) {
        let tipPercentageString = sender.currentTitle!
        let end = tipPercentageString.index(tipPercentageString.endIndex, offsetBy: -1)
        tipPercentage = Int(tipPercentageString[..<end])!
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

    @IBAction func roundUp(_ sender: UIButton) {
        let roundUpTotal = total.rounded(FloatingPointRoundingRule.up)
        let tipDiff = roundUpTotal - total
        tip = tip + tipDiff
        total = roundUpTotal
        updateUI()
    }

    @IBAction func roundDown(_ sender: Any) {
        let roundDownTotal = total.rounded(FloatingPointRoundingRule.down)
        let tipDiff = total - roundDownTotal
        tip = tip - tipDiff
        total = roundDownTotal
        updateUI()
    }

    func refreshTip() {
        let tipPercentageDouble = Double(tipPercentage)
        tip = (billAmount * tipPercentageDouble/100).rounded(toPlaces: 2)
        total = billAmount + tip
        updateUI()
    }

    private func updateUI() {
        let tipPercentageDouble = Double(tipPercentage)
        tipLabel.text = tip.format(precision: ".2")
        totalLabel.text = (total).format(precision: ".2")
        tipPercentageLabel.text = String("\(tipPercentage)%")
        tipPercentageSlider.value = Float(tipPercentageDouble)
    }

    @IBAction func unwindToTipAssist(sender: UIStoryboardSegue) {
        if sender.source is SettingsController {
            let tipControl = TipControl()
            tipPercentage = tipControl.defaultTip
            refreshTip()
        }
    }

}

