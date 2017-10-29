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

    var tipDisplay: TipDisplay?

    override func viewDidLoad() {
        super.viewDidLoad()

        // update roundoff UX
        switch(tipDisplay!.tipRoundOffOption) {
        case TipControl.RoundOffOption.NONE:
            updateUI()
        case TipControl.RoundOffOption.ROUND_DOWN:
            roundDownButton.isHighlighted = true
            roundDown(roundDownButton)
        case TipControl.RoundOffOption.ROUND_UP:
            roundUpButton.isHighlighted = true
            roundUp(roundUpButton)
        }
    }


    @IBAction func roundUp(_ sender: UIButton) {
        let roundUpTotal = tipDisplay!.totalAmount.rounded(FloatingPointRoundingRule.up)
        let tipDiff = roundUpTotal - tipDisplay!.totalAmount
        tipDisplay!.tipAmount = tipDisplay!.tipAmount + tipDiff
        tipDisplay!.totalAmount = roundUpTotal
        tipDisplay!.tipPercentage = (tipDisplay!.billAmount > 0) ? tipDisplay!.tipAmount/tipDisplay!.billAmount * 100 : tipDisplay!.tipPercentage
        updateUI()
    }

    @IBAction func roundDown(_ sender: Any) {
        let roundDownTotal = tipDisplay!.totalAmount.rounded(FloatingPointRoundingRule.down)
        let tipDiff = tipDisplay!.totalAmount - roundDownTotal
        tipDisplay!.tipAmount = tipDisplay!.tipAmount - tipDiff
        tipDisplay!.totalAmount = roundDownTotal
        tipDisplay!.tipPercentage = (tipDisplay!.billAmount > 0) ? tipDisplay!.tipAmount/tipDisplay!.billAmount * 100 : tipDisplay!.tipPercentage
        updateUI()
    }

    private func updateUI() {
        tipAmountLabel.text = tipDisplay!.tipAmount.format(precision: ".2")
        totalAmountLabel.text = tipDisplay!.totalAmount.format(precision: ".2")
        let billAmountString = tipDisplay!.billAmount.format(precision: ".2")
        let tipPercentageString = tipDisplay!.tipPercentage.format(precision: ".2")
        tipDisplayHeader.text = String("\(tipPercentageString) % tip of \(billAmountString) bill")
    }

}
