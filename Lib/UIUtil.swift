//
//  UIUtil.swift
//  Sail
//
//  Created by Amy Harris on 04/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation
import UIKit

extension LocalizedError {
    public var localizedDescription: String {
        return ("error:" + String(describing: type(of: self)) + "_" + String(describing: self)).localized()
    }
}


func alert(error: LocalizedError) {
    let alert = UIAlertController(title: "alert".localized(), message: "Message", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
        switch action.style{
        case .default:
            print("default")
            
        case .cancel:
            print("cancel")
            
        case .destructive:
            print("destructive")
            
            
        }}))
    //alert.present(alert, animated: true, completion: nil)
}
