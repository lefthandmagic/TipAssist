//
//  TipControl.swift
//  TipAssist
//
//  Created by Praveen Murugesan on 10/14/17.
//  Copyright © 2017 Praveen Murugesan. All rights reserved.
//

import Foundation


struct TipControl {

    let defaultTip: Int
    let quickTip1: Int
    let quickTip2: Int
    let quickTip3: Int
    let roundOffOption: String

    init() {

        let defaults: UserDefaults = UserDefaults.standard

        if (defaults.object(forKey: TipDefaults.defaultTipKey) != nil) {
            self.defaultTip = defaults.integer(forKey: TipDefaults.defaultTipKey)
        } else {
            self.defaultTip = TipDefaults.defaultTipValue
        }

        //set roundoff value
        if (defaults.object(forKey: TipDefaults.defaultRoundOffOptionKey) != nil) {
            self.roundOffOption = defaults.string(forKey: TipDefaults.defaultRoundOffOptionKey)!
        } else {
            self.roundOffOption = TipDefaults.defaultRoundOffOptionValue
        }

        //setup quick tip options
        if (defaults.object(forKey: TipDefaults.defaultQuickTip1) != nil) {
            self.quickTip1 = defaults.integer(forKey: TipDefaults.defaultQuickTip1)
        } else {
            quickTip1 = TipDefaults.defaultQuickTip1Value
        }
        if (defaults.object(forKey: TipDefaults.defaultQuickTip2) != nil) {
            self.quickTip2 = defaults.integer(forKey: TipDefaults.defaultQuickTip2)
        } else {
            quickTip2 = TipDefaults.defaultQuickTip2Value
        }
        if (defaults.object(forKey: TipDefaults.defaultQuickTip3) != nil) {
            self.quickTip3 = defaults.integer(forKey: TipDefaults.defaultQuickTip3)
        } else {
            quickTip3 = TipDefaults.defaultQuickTip3Value
        }
    }
}
