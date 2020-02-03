//
//  ViewController.swift
//  KeyboardHandling
//
//  Created by Matthew Ramos on 2/3/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pursuitLogo: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var pursuitLogoCenterYConstraint: NSLayoutConstraint!
    
    private var originalYconstraint: NSLayoutConstraint!
    private var keyboardIsVisable = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        unregisterForKeyboardNotifications()
    }

    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
    }
    
    private func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc
    private func keyboardWillShow(_ notification: NSNotification) {
        print("keyboardWillShow")
        
//        "UIKeyboardFrameBeginUserInfoKey"
        
        guard let keyboardFrame = notification.userInfo?[ "UIKeyboardFrameBeginUserInfoKey"] as? CGRect else {
            return
        }
        moveKeyboardUp(keyboardFrame.size.height)
        
    }
    
    @objc
    private func keyboardWillHide(_ notification: NSNotification) {
        print("keyboardWillHide")
        print(notification.userInfo)
    }
    
    private func moveKeyboardUp(_ height: CGFloat) {
        if keyboardIsVisable { return }
        keyboardIsVisable = true
        originalYconstraint = pursuitLogoCenterYConstraint
        pursuitLogoCenterYConstraint.constant -= (height * 0.80)
    }
    
    private func resetUI() {
        keyboardIsVisable = false
        pursuitLogoCenterYConstraint.constant -= originalYconstraint.constant
    }

}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        resetUI()
        return true
    }
}
