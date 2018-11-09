//
//  APIProvider.swift
//  Sail
//
//  Created by Amy Harris on 08/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation

class APIProvider: Personalized {
    func applyPersonalization(account: AppAccount?) {
        account?.instance
    }
    
    init() {
        setUpPersonalisation()
    }
}
