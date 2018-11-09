//
//  PersonalizationProvider.swift
//  Sail
//
//  Created by Amy Harris on 08/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation


protocol Personalized {
    func applyPersonalization(account: MAccount?)
}

extension Personalized where Self: AnyObject {
    func setUpPersonalisation() {
        self.applyPersonalization(account: PersonalizationProvider.currentAccount)
        PersonalizationProvider.subscribeToChanges(self) { [weak self] newAccount in
            self?.applyPersonalization(account: newAccount)
        }
    }
}

class PersonalizationProvider {
    private static var account: SubscribableValue<MAccount?> = SubscribableValue<MAccount?>(value: AccountManager.currentAccount)
    
    static var currentAccount: MAccount? {
        get {
            return account.value
        } set {
            account.value = newValue
        }
    }
    
    static func subscribeToChanges(_ object: Personalized, handler: @escaping (MAccount?) -> Void) {
        self.account.subscribe(object as AnyObject, using: handler)
    }
}
