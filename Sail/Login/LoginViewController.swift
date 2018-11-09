//
//  LoginNavigationController.swift
//  Sail
//
//  Created by Amy Harris on 30/10/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import UIKit
import JGProgressHUD
import PromiseKit
import Localize_Swift

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var instanceEntry: UITextField!
    @IBOutlet weak var keyboardLayoutMaskHeight: NSLayoutConstraint!
    
    var hud: JGProgressHUD?
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        self.instanceEntry.becomeFirstResponder()
        self.instanceEntry.delegate = self
        
        self.hud = JGProgressHUD(style: .light)
        self.hud!.textLabel.text = "Loading"
        
    }
    
    @IBAction func cancelPress(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardLayoutMaskHeight.constant = keyboardSize.height
        }
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let address = instanceEntry.text!
        let match = address.range(of: "^((\\d|\\w)+[.])+(\\d|\\w)+$", options: .regularExpression) != nil
        
        if (match) {
            lockInterface()
            LoginController.attemptLogin(address: address, completion: {error in
                DispatchQueue.main.async {
                    self.unlockInterface()
                    if let error = error {
                        self.displayError(error.localizedDescription)
                    } else {
                        self.performSegue(withIdentifier: "toLoading", sender: nil)
                    }
                }
            })
        } else {
            displayError("flow:connect_addressInvalid".localized())
        }
        return true
    }
    
    func lockInterface() {
        self.instanceEntry.resignFirstResponder()
        self.instanceEntry.isUserInteractionEnabled = false
        self.hud!.show(in: self.view)
        
    }
    
    func unlockInterface() {
        self.instanceEntry.becomeFirstResponder()
        self.instanceEntry.isUserInteractionEnabled = true
        self.hud!.dismiss()
        
    }
    
    func displayError(_ message: String) {
        let alert = UIAlertController(title: "alert:error".localized(), message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "alert:action_tryAgain".localized(), style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
