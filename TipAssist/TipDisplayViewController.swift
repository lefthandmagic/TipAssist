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

        let logo = UIImage(named: "tipez_80_80.png")
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFill // set imageview's content mode
        self.navigationItem.titleView = imageView
    }


    @IBAction func roundUp(_ sender: UIButton) {
        if isRoundUpSet  {
            tipDisplay = originalTipDisplay
            isRoundUpSet = false
            //change color to unset
            roundUpButton.setTitleColor(defaultButtonColor, for: UIControlState.normal)
        } else if(!isRoundUpSet && !isRoundDownSet) {
            originalTipDisplay = TipDisplay(tipAmount: tipDisplay!.tipAmount,
                                            totalAmount: tipDisplay!.totalAmount,
                                            billAmount: tipDisplay!.billAmount,
                                            tipPercentage: tipDisplay!.tipPercentage,
                                            roundOffOption: tipDisplay!.tipRoundOffOption)

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
        if isRoundDownSet {
            tipDisplay = originalTipDisplay
            isRoundDownSet = false
            roundDownButton.setTitleColor(defaultButtonColor, for: UIControlState.normal)
        } else if (!isRoundDownSet && !isRoundUpSet) {
        originalTipDisplay = TipDisplay(tipAmount: tipDisplay!.tipAmount,
                                        totalAmount: tipDisplay!.totalAmount,
                                        billAmount: tipDisplay!.billAmount,
                                        tipPercentage: tipDisplay!.tipPercentage,
                                        roundOffOption: tipDisplay!.tipRoundOffOption)

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
        tipAmountLabel.text = tipDisplay!.tipAmount.format(precision: ".2")
        totalAmountLabel.text = tipDisplay!.totalAmount.format(precision: ".2")
        let billAmountString = tipDisplay!.billAmount.format(precision: ".2")
        let tipPercentageString = tipDisplay!.tipPercentage.format(precision: ".1")
        tipDisplayHeader.text = String("\(tipPercentageString) % tip for \(billAmountString) bill")
    }

}
