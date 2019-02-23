//
//  LoginMenuViewController.swift
//  UW-RateEm
//
//  Created by Keith Ecker on 2/20/19.
//  Copyright © 2019 Keith Ecker. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class LoginMenuViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ClassInfo.loadClasses(){ courses in
            for course in courses{
                print("Course Name: \(course.className)")
                print("Course Code: \(course.classCode)")
                print("Course Description: \(String(describing: course.description))")
                print("Assignments: \(course.assignments)")
                print("Semester: \(course.semester)")
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let user = Auth.auth().currentUser{
            self.performSegue(withIdentifier: "toHomeScreen", sender: self)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
