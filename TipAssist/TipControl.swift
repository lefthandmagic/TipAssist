//
//  TipControl.swift
//  TipAssist
//
//  Created by Praveen Murugesan on 10/14/17.
//  Copyright © 2017 Praveen Murugesan. All rights reserved.
//

import Foundation

//Model struct of all Tip controls
struct TipControl {

    var defaultTip: Int
    let quickTip1: Int
    let quickTip2: Int
    let quickTip3: Int
    let roundOffOption: String

    init(defaultTip: Int, quickTip1: Int, quickTip2: Int, quickTip3: Int, roundOffOption: String) {
        self.defaultTip = defaultTip
        self.quickTip1 = quickTip1
        self.quickTip2 = quickTip2
        self.quickTip3 = quickTip3
        self.roundOffOption = roundOffOption
    }

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

    func save() {
        let defaults: UserDefaults = UserDefaults.standard
        defaults.set(defaultTip, forKey: TipDefaults.defaultTipKey)
        defaults.set(roundOffOption, forKey: TipDefaults.defaultRoundOffOptionKey)
        defaults.set(quickTip1, forKey: TipDefaults.defaultQuickTip1)
        defaults.set(quickTip2, forKey: TipDefaults.defaultQuickTip2)
        defaults.set(quickTip3, forKey: TipDefaults.defaultQuickTip3)
    }
}
