//
//  Strings.swift
//  Sail
//
//  Created by Amy Harris on 01/12/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation

extension String {
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
    }
}
protocol Localizable {
    var tableName: String { get }
    var localized: String { get }
}
extension Localizable where Self: RawRepresentable, Self.RawValue == String {
    var localized: String {
        return rawValue.localized(tableName: tableName)
    }
}
