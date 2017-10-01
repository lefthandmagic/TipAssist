//
//  DoubleExtension.swift
//  TipAssist
//
//  Created by Praveen Murugesan on 9/30/17.
//  Copyright © 2017 Praveen Murugesan. All rights reserved.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }

    func format(precision: String) -> String {
        return String(format: "%\(precision)f", self)
    }
}
