//
//  TipDefaults.swift
//  TipAssist
//
//  Created by Praveen Murugesan on 10/23/17.
//  Copyright © 2017 Praveen Murugesan. All rights reserved.
//

import Foundation
import UIKit

// all static defaults in one place
struct TipDefaults {

    static let defaultTipKey: String = "DEFAULT_TIP_KEY"
    static let defaultRoundOffOptionKey: String = "DEFAULT_ROUNDOFF_OPTION_KEY"
    static let defaultQuickTip1: String = "QUICK_TIP_1_KEY"
    static let defaultQuickTip2: String = "QUICK_TIP_2_KEY"
    static let defaultQuickTip3: String = "QUICK_TIP_3_KEY"

    static let defaultQuickTip1Value = 10
    static let defaultQuickTip2Value = 15
    static let defaultQuickTip3Value = 20

    static let defaultTipValue = 15

    static func getNavTitleImage() -> UIImageView  {
        let logo = UIImage(named: "tipez_80_80.png")
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFill // set imageview's content mode
        return imageView
    }

    static func getPercentageNumberFormatter() -> NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.percent
        numberFormatter.multiplier = 1
        return numberFormatter
    }

}
