//
//  CourseReviewViewController.swift
//  UW-RateEm
//
//  Created by Keith Ecker on 2/24/19.
//  Copyright © 2019 Keith Ecker. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class CourseReviewViewController: UIViewController{
    var classCodeGiven:String?
    var className:String?
    
    @IBOutlet weak var reviewSubjectTextField: UITextField!
    @IBOutlet weak var classNameLabel: UILabel!
    @IBOutlet weak var gradeTextField: UITextField!
    @IBOutlet weak var reviewTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        classNameLabel.text = className
    }
    
    @IBAction func leaveReviewButtonTapped(_ sender: Any) {
        let ref = Database.database().reference().child("CourseReviews")
        
        guard let reviewSubject = reviewSubjectTextField.text else {return}
        guard let grade = gradeTextField.text else {return}
        guard let reviewText = reviewTextView.text else {return}
        guard let classCode = classCodeGiven else {return}
        let childRef = ref.childByAutoId()
        childRef.child("classCode").setValue(classCode)
        childRef.child("subject").setValue(reviewSubject)
        childRef.child("grade").setValue(grade)
        childRef.child("review").setValue(reviewText)
        childRef.child("username").setValue(Auth.auth().currentUser?.displayName)
        
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
}
