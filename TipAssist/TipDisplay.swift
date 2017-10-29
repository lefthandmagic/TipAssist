//
//  TipDisplay.swift
//  TipAssist
//
//  Created by Praveen Murugesan on 10/29/17.
//  Copyright © 2017 Praveen Murugesan. All rights reserved.
//

import Foundation

struct TipDisplay {

    var tipAmount: Double
    var totalAmount: Double
    var billAmount: Double
    var tipPercentage: Double
    var tipRoundOffOption: TipControl.RoundOffOption

    init(tipAmount: Double, totalAmount: Double, billAmount: Double, tipPercentage: Double, roundOffOption: TipControl.RoundOffOption) {
        self.tipAmount = tipAmount
        self.totalAmount = totalAmount
        self.billAmount = billAmount
        self.tipPercentage = tipPercentage
        self.tipRoundOffOption = roundOffOption
    }
    
}
