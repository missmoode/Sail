//
//  Strings.swift
//  Sail
//
//  Created by Amy Harris on 01/12/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation

enum AlertStrings: String, Localizable {
    case error = "error_occured"
    case dataLoaded = "data_loaded"
    
    var tableName: String {
        return "Alert"
    }
}
