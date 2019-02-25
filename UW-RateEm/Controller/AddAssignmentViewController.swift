//
//  AddAssignmentViewController.swift
//  UW-RateEm
//
//  Created by Keith Ecker on 2/24/19.
//  Copyright © 2019 Keith Ecker. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class AddAssignmentViewController:UIViewController{
    @IBOutlet weak var assignmentNameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var classCodeTextField: UITextField!
    
    
    @IBAction func addButtonTapped(_ sender: Any) {
        //Create new assignment
        let ref = Database.database().reference().child("Assignments")
        let childRef = ref.childByAutoId()
        guard let assignmentName = assignmentNameTextField.text else {return}
        guard let description = descriptionTextView.text else {return}
        guard let classCode = classCodeTextField.text else {return}
        childRef.child("assignmentName").setValue(assignmentName)
        childRef.child("description").setValue(description)
        childRef.child("classCode").setValue(classCode)
        
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
}
