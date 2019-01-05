//
//  Menu.swift
//  Sail
//
//  Created by Amy Harris on 04/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation
import UIKit

class MenuViewController: UIViewController, Themed {
//    func applyPersonalization(session: LoginSession?) {
//        loggedInAccountView.account = account
//    }
    
    func applyTheme(theme: Theme) {
        
        if !UIAccessibility.isReduceTransparencyEnabled {
            let blurEffect = UIBlurEffect(style: .regular)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = self.view.bounds
            view.addSubview(blurEffectView)
            view.sendSubviewToBack(blurEffectView)
            blurEffectView.backgroundColor = theme.primaryTintBackgroundColor.withAlphaComponent(0.1)
        } else {
            view.backgroundColor = theme.primaryTintBackgroundColor
        }
    }
    
    @IBOutlet weak var loggedInAccountView: MenuAccountView!
    
    override func viewDidLoad() {
        setUpThemeing()
        //setUpPersonalisation()
    }
}
 
