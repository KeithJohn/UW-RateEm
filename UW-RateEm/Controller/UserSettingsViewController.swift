//
//  UserSettingsViewController.swift
//  UW-RateEm
//
//  Created by Keith Ecker on 2/21/19.
//  Copyright © 2019 Keith Ecker. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class UserSettingsViewController: UIViewController{
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var coursesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let userID = Auth.auth().currentUser?.uid{
            print("userID: \(userID)")
            let ref = Database.database().reference().child("Users").child(userID)
            print(ref)
            ref.observeSingleEvent(of: .value) { (userSnap) in
                if let userInfo = userSnap.value as? NSDictionary{
                    self.usernameTextField.text = userInfo["Username"] as? String
                    self.emailTextField.text = userInfo["email"] as? String
                    self.passwordTextField.text = userInfo["password"] as? String
                    //Get Courses
                    //TODO:
                }
            }
            
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text else {return}
        guard let username = usernameTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        let user = Auth.auth().currentUser
        let userId = user?.uid
        let ref = Database.database().reference().child("Users").child(userId!)
        ref.child("email").setValue(email)
        ref.child("username").setValue(username)
        let changeRequest = user?.createProfileChangeRequest()
        if username != nil {
        changeRequest?.displayName = username
        changeRequest?.commitChanges(completion: { (error) in
            if error != nil{
                print("ERROR - Error changing username: \(error!.localizedDescription)")
            }
        })
        }
        if email != ""{
        user?.updateEmail(to: email, completion: { (error) in
            if error != nil{
                print("ERROR - Error changing email: \(error!.localizedDescription)")
            }
        })
        }
        if password != ""{
        user?.updatePassword(to: password, completion: { (error) in
            if error != nil{
                print("ERROR - Error changing user password: \(error!.localizedDescription)")
            }
        })
        }
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
}
