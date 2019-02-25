//
//  AssignmentRevewViewController.swift
//  UW-RateEm
//
//  Created by Keith Ecker on 2/24/19.
//  Copyright © 2019 Keith Ecker. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class AssignmentReviewViewController: UIViewController{
    var assignmentCodeGiven:String?
    var assignmentName:String?
    @IBOutlet weak var assignmentNameLabel: UILabel!
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var gradeTextField: UITextField!
    @IBOutlet weak var reviewTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assignmentNameLabel.text = assignmentName
    }
    @IBAction func leaveReviewButtonTapped(_ sender: Any) {
        let ref = Database.database().reference().child("AssignmentReviews")
        
        guard let reviewSubject = subjectTextField.text else {return}
        guard let grade = gradeTextField.text else {return}
        guard let reviewText = reviewTextField.text else {return}
        guard let assignmentCode = assignmentCodeGiven else {return}
        let childRef = ref.childByAutoId()
        childRef.child("assignmentCode").setValue(assignmentCode)
        childRef.child("subject").setValue(reviewSubject)
        childRef.child("grade").setValue(grade)
        childRef.child("review").setValue(reviewText)
        childRef.child("username").setValue(Auth.auth().currentUser?.displayName)
        
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
}
