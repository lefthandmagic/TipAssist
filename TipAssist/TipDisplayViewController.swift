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

    var tipAmount: Double?
    var totalAmount: Double?
    var tipPercentage: Double?
    var billAmount: Double?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }


    @IBAction func roundUp(_ sender: UIButton) {
        let roundUpTotal = totalAmount?.rounded(FloatingPointRoundingRule.up)
        let tipDiff = roundUpTotal! - totalAmount!
        tipAmount = tipAmount! + tipDiff
        totalAmount = roundUpTotal
        tipPercentage = tipAmount!/billAmount! * 100
        updateUI()
    }

    @IBAction func roundDown(_ sender: Any) {
        let roundDownTotal = totalAmount?.rounded(FloatingPointRoundingRule.down)
        let tipDiff = totalAmount! - roundDownTotal!
        tipAmount = tipAmount! - tipDiff
        totalAmount = roundDownTotal!
        tipPercentage = tipAmount!/billAmount! * 100
        updateUI()
    }

    private func updateUI() {
        tipAmountLabel.text = tipAmount?.format(precision: ".2")
        totalAmountLabel.text = totalAmount?.format(precision: ".2")
        let tipPercentageString = tipPercentage?.format(precision: ".2")
        tipDisplayHeader.text = String("\(tipPercentageString!) % tip of \(billAmount!) bill")
    }

}
