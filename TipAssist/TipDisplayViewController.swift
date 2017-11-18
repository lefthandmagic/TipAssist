//
//  TipDisplayViewController.swift
//  TipAssist
//
//  Created by Praveen Murugesan on 10/26/17.
//  Copyright © 2017 Praveen Murugesan. All rights reserved.
//

import UIKit

class TipDisplayViewController: UIViewController {

    @IBOutlet weak var tipDisplayHeader: UILabel!

    @IBOutlet weak var tipAmountLabel: UILabel!

    @IBOutlet weak var totalAmountLabel: UILabel!

    @IBOutlet weak var roundUpButton: UIButton!

    @IBOutlet weak var roundDownButton: UIButton!

    var defaultButtonColor: UIColor?

    var tipDisplay: TipDisplay?

    var originalTipDisplay: TipDisplay?

    var isRoundUpSet: Bool = false
    var isRoundDownSet:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // update roundoff UX
        defaultButtonColor = roundUpButton.titleColor(for: .normal)

        switch(tipDisplay!.tipRoundOffOption) {
        case TipControl.RoundOffOption.NONE:
            updateUI()
        case TipControl.RoundOffOption.ROUND_DOWN:
            roundDown(roundDownButton)
        case TipControl.RoundOffOption.ROUND_UP:
            roundUp(roundUpButton)
        }
        self.navigationItem.titleView = TipDefaults.getNavTitleImage()
    }


    @IBAction func roundUp(_ sender: UIButton) {
        if isRoundUpSet  {
            tipDisplay = originalTipDisplay
            isRoundUpSet = false
            //change color to unset
            roundUpButton.setTitleColor(defaultButtonColor, for: UIControlState.normal)
        } else {

            if(!isRoundUpSet && !isRoundDownSet) {
                originalTipDisplay = TipDisplay(tipAmount: tipDisplay!.tipAmount,
                                            totalAmount: tipDisplay!.totalAmount,
                                            billAmount: tipDisplay!.billAmount,
                                            tipPercentage: tipDisplay!.tipPercentage,
                                            roundOffOption: tipDisplay!.tipRoundOffOption)
            } else if (isRoundDownSet) {
                tipDisplay = originalTipDisplay
                isRoundDownSet = false
                roundDownButton.setTitleColor(defaultButtonColor, for: UIControlState.normal)
            }

            let roundUpTotal = tipDisplay!.totalAmount.rounded(FloatingPointRoundingRule.up)
            let tipDiff = roundUpTotal - tipDisplay!.totalAmount
            tipDisplay!.tipAmount = tipDisplay!.tipAmount + tipDiff
            tipDisplay!.totalAmount = roundUpTotal
            tipDisplay!.tipPercentage = (tipDisplay!.billAmount > 0) ? tipDisplay!.tipAmount/tipDisplay!.billAmount * 100 : tipDisplay!.tipPercentage
            isRoundUpSet = true
            roundUpButton.setTitleColor(UIColor.gray, for: UIControlState.normal)
        }
        updateUI()
    }

    @IBAction func roundDown(_ sender: Any) {
        // if round down is set, toggle back to default 
        if isRoundDownSet {
            tipDisplay = originalTipDisplay
            isRoundDownSet = false
            roundDownButton.setTitleColor(defaultButtonColor, for: UIControlState.normal)
        } else {
            // if round down is not set, verify if both options not set, then round down
            if (!isRoundDownSet && !isRoundUpSet) {
                originalTipDisplay = TipDisplay(tipAmount: tipDisplay!.tipAmount,
                                        totalAmount: tipDisplay!.totalAmount,
                                        billAmount: tipDisplay!.billAmount,
                                        tipPercentage: tipDisplay!.tipPercentage,
                                        roundOffOption: tipDisplay!.tipRoundOffOption)

                // else if round up option is set, toggle directly to round down
            } else if (isRoundUpSet) {
                tipDisplay = originalTipDisplay
                isRoundUpSet = false
                roundUpButton.setTitleColor(defaultButtonColor, for: UIControlState.normal)
            }
        let roundDownTotal = tipDisplay!.totalAmount.rounded(FloatingPointRoundingRule.down)
        let tipDiff = tipDisplay!.totalAmount - roundDownTotal
        tipDisplay!.tipAmount = tipDisplay!.tipAmount - tipDiff
        tipDisplay!.totalAmount = roundDownTotal
        tipDisplay!.tipPercentage = (tipDisplay!.billAmount > 0) ? tipDisplay!.tipAmount/tipDisplay!.billAmount * 100 : tipDisplay!.tipPercentage
            isRoundDownSet = true
            roundDownButton.setTitleColor(UIColor.gray, for: UIControlState.normal)
        }
        updateUI()
    }

    private func updateUI() {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.minimumIntegerDigits = 1
        tipAmountLabel.text = numberFormatter.string(from: NSNumber.init(value: tipDisplay!.tipAmount))
        totalAmountLabel.text = numberFormatter.string(from: NSNumber.init(value: tipDisplay!.totalAmount))
        let billAmountString = numberFormatter.string(from: NSNumber.init(value: tipDisplay!.billAmount))
        numberFormatter.maximumFractionDigits = 1
        let tipPercentageString = numberFormatter.string(from: NSNumber.init(value: tipDisplay!.tipPercentage))
        let tipFor = "TipFor".localized
        let bill = "Bill".localized
        tipDisplayHeader.text = String("\(tipPercentageString!) \(tipFor) \(billAmountString!) \(bill)")
    }

}
