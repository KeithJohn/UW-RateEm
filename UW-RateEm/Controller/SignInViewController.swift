//
//  SignInViewController.swift
//  UW-RateEm
//
//  Created by Keith Ecker on 2/20/19.
//  Copyright © 2019 Keith Ecker. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class SignInViewController: UIViewController{
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        print("Sign in Button Tapped")
        handleSignIn()
    }
    
    func handleSignIn() {
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if error == nil && user != nil {
                print("User Signed In")
                if let navController = self.navigationController {
                    navController.popViewController(animated: true)
                }
            }else{
                print("ERROR - Error signing in: \(error!.localizedDescription)")
                let alert = UIAlertController(title: "Error", message: "Your email or password is incorrect, please try again.", preferredStyle: .alert)
                self.present(alert, animated: true)
                alert.addAction(UIAlertAction(title: "Try again", style: .cancel, handler: nil))
            }
            
        }
    }
}
