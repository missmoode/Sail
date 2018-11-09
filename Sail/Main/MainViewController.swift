//
//  MainViewController.swift
//  Sail
//
//  Created by Amy Harris on 04/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class MainNavigationController: UINavigationController, Themed, Personalized {
    func applyPersonalization(account: AppAccount?) {
        let imageSize = (self.navigationBar.frame.height) - 6
        
        let processor = RoundCornerImageProcessor(cornerRadius: imageSize / 2)
        
        let menuButton = UIButton(type: .custom)
        menuButton.kf.setImage(with: AccountManager.currentAccount?.avatar, for: .normal, options:[.processor(processor)])
        menuButton.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
        menuButton.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
        menuButton.layer.cornerRadius = imageSize / 2
        menuButton.layer.masksToBounds = true
        menuButton.addTarget(self, action: #selector(menuButtonAction), for: .touchUpInside)
        self.menuBarButton = UIBarButtonItem(customView: menuButton)
    }
    
    @objc func menuButtonAction(sender: UIButton) {
        self.performSegue(withIdentifier: "openMenu", sender: nil)
    }
    
    
    func applyTheme(theme: Theme) {
        self.navigationBar.barTintColor = theme.primaryTintBackgroundColor
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: theme.primaryTintForegroundColor]
    }
    
    var menuBarButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        setUpThemeing()
        setUpPersonalisation()
        self.delegate = self
        
    }
}

extension MainNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.rightBarButtonItem = self.menuBarButton
    }
}


class MainNavBarController: UIViewController, UITabBarControllerDelegate {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TabViewEmbed" {
            let vc = segue.destination as! UITabBarController
            
            vc.delegate = self
        }
    }
    
}

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        self.delegate = self
        
        self.selectedViewController = self.viewControllers![0]
        updateTitle(title: self.selectedViewController?.title)
    }
    
    func updateTitle(title: String?) {
        self.title = title
    }
    
    
}

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        updateTitle(title: viewController.title)
        return true
    }
}
