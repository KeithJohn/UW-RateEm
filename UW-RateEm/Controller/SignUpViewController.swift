//
//  SignUpViewController.swift
//  UW-RateEm
//
//  Created by Keith Ecker on 2/20/19.
//  Copyright © 2019 Keith Ecker. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class SignUpViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!

    @IBAction func signUpButtonTapped(_ sender: Any) {
        handleSignUp()
    }
    
    
    func handleSignUp(){
        guard let username = usernameTextField.text else {return}
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        Auth.auth().createUser(withEmail: email, password: password){ user, error in
            if error == nil && user != nil {
                print("User Created!")
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = username
                changeRequest?.commitChanges{ error in
                    if error == nil {
                        print("User display name changed: \(changeRequest!.displayName ?? "Error")")
                        
                        //TODO: Add to database
                        let ref = Database.database().reference().child("Users").childByAutoId()
                        ref.child("username").setValue(username)
                        ref.child("password").setValue(password)
                        ref.child("email").setValue(email)
                        ref.child("courses")
                        if let navController = self.navigationController{
                            print("pop controller")
                            navController.popViewController(animated: true)
                        }
                    }else{
                        print("ERROR - Error changing user display name: \(error!.localizedDescription)")
                    }
                }
                
            }else{
                print("ERROR - Error creating user: \(error!.localizedDescription)")
                
            }
        }
    }
}
