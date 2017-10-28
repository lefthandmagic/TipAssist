
//
//  ViewController.swift
//  TipAssist
//
//  Created by Praveen Murugesan on 9/25/17.
//  Copyright © 2017 Praveen Murugesan. All rights reserved.
//

import UIKit


class TipAssistViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var quickTip1Button: UIButton!

    @IBOutlet weak var quickTip2Button: UIButton!

    @IBOutlet weak var quickTip3Button: UIButton!

    @IBOutlet weak var tipPercentageSlider: UISlider!
    
    @IBOutlet weak var tipPercentageLabel: UILabel!

    @IBOutlet weak var billAmountTextField: UITextField!

    @IBOutlet weak var tipLabel: UILabel!

    @IBOutlet weak var totalLabel: UILabel!

    private var tipControl: TipControl = TipControl()

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
        updateUI()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    @IBAction func computeQuickTip(_ sender: UIButton) {
        let tipPercentageString = sender.currentTitle!
        let end = tipPercentageString.index(tipPercentageString.endIndex, offsetBy: -1)
        tipControl.defaultTip = Int(tipPercentageString[..<end])!
        refreshTip()
    }

    @IBAction func computeCustomTip(_ sender: Any) {
        // computed with step function on 1
        tipControl.defaultTip = Int(tipPercentageSlider.value.rounded())
        refreshTip()
    }

    private func refreshTip() {
        let tipPercentageDouble = Double(tipControl.defaultTip)
        tip = (billAmount * tipPercentageDouble/100).rounded(toPlaces: 2)
        total = billAmount + tip
        updateUI()
    }

    private func updateUI() {
        let tipPercentageDouble = Double(tipControl.defaultTip)
        tipPercentageLabel.text = String("\(tipControl.defaultTip)%")
        tipPercentageSlider.value = Float(tipPercentageDouble)
        quickTip1Button.setTitle(String("\(tipControl.quickTip1)%"), for: .normal)
        quickTip2Button.setTitle(String("\(tipControl.quickTip2)%"), for: .normal)
        quickTip3Button.setTitle(String("\(tipControl.quickTip3)%"), for: .normal)
    }

    @IBAction func unwindToTipAssist(sender: UIStoryboardSegue) {
        if sender.source is SettingsController {
            tipControl = TipControl()
            updateUI()
            refreshTip()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination
        if let tipDisplayViewController = destinationViewController as? TipDisplayViewController {
                refreshTip()
            tipDisplayViewController.tipAmount = tip
            tipDisplayViewController.totalAmount = total
            tipDisplayViewController.tipPercentage = Double(tipControl.defaultTip)
            tipDisplayViewController.billAmount = billAmount
            tipDisplayViewController.tipRoundOffOption = tipControl.roundOffOption
        }
    }

}

