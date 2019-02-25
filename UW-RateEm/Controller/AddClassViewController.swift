//
//  AddClassViewController.swift
//  UW-RateEm
//
//  Created by Keith Ecker on 2/24/19.
//  Copyright © 2019 Keith Ecker. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class AddClassViewController:UIViewController {
    
    
    @IBOutlet weak var classCodeTextField: UITextField!
    @IBOutlet weak var classNameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var assignmentTableView: UITableView!
    @IBOutlet weak var semesterTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func addClassButtonTapped(_ sender: Any) {
        let ref = Database.database().reference().child("courses")
        
        guard let courseName = classNameTextField.text else {return}
        guard let courseCode = classCodeTextField.text else {return}
        guard let descrption = descriptionTextView.text else {return}
        guard let term = semesterTextField.text else {return}
        guard let year = Int((yearTextField.text)!)  else {return}
        
        let childRef = ref.child(courseCode)
        childRef.child("courseName").setValue(courseName)
        childRef.child("description").setValue(descrption)
        childRef.child("semester").child("term").setValue(term)
        childRef.child("semester").child("year").setValue(year)
        
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
}
