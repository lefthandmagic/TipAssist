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

    var tipAmount: Double?
    var totalAmount: Double?
    var billAmount: Double?
    var tipPercentage: Double?
    var tipRoundOffOption: TipControl.RoundOffOption?

    override func viewDidLoad() {
        super.viewDidLoad()


        // update roundoff UX
        switch(tipRoundOffOption!) {
        case TipControl.RoundOffOption.NONE:
            break
        case TipControl.RoundOffOption.ROUND_DOWN:
            roundDownButton.isHighlighted = true
        case TipControl.RoundOffOption.ROUND_UP:
            roundUpButton.isHighlighted = true
        }

        updateUI()
    }


    @IBAction func roundUp(_ sender: UIButton) {
        let roundUpTotal = totalAmount?.rounded(FloatingPointRoundingRule.up)
        let tipDiff = roundUpTotal! - totalAmount!
        tipAmount = tipAmount! + tipDiff
        totalAmount = roundUpTotal
        tipPercentage = (billAmount! > 0) ? tipAmount!/billAmount! * 100 : tipPercentage
        updateUI()
    }

    @IBAction func roundDown(_ sender: Any) {
        let roundDownTotal = totalAmount?.rounded(FloatingPointRoundingRule.down)
        let tipDiff = totalAmount! - roundDownTotal!
        tipAmount = tipAmount! - tipDiff
        totalAmount = roundDownTotal!
        tipPercentage = (billAmount! > 0) ? tipAmount!/billAmount! * 100 : tipPercentage
        updateUI()
    }

    private func updateUI() {
        tipAmountLabel.text = tipAmount?.format(precision: ".2")
        totalAmountLabel.text = totalAmount?.format(precision: ".2")
        let billAmountString = billAmount?.format(precision: ".2")
        let tipPercentageString = tipPercentage?.format(precision: ".2")
        tipDisplayHeader.text = String("\(tipPercentageString!) % tip of \(billAmountString!) bill")
    }

}
