//
//  StringExtension.swift
//  TipAssist
//
//  Created by Praveen Murugesan on 11/18/17.
//  Copyright © 2017 Praveen Murugesan. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
