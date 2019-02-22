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
        let userID = Auth.auth().currentUser?.uid
        print("userID: \(userID ?? "No userId found")")
        let ref = Database.database().reference()
        print("Got reference")
        //TODO: get user info from database.
//        let username = ref.child(userID!).value(forKey: "Username")
//        usernameTextField.text = username as? String
    }
}
