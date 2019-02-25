//
//  CourseInfoViewController.swift
//  UW-RateEm
//
//  Created by Keith Ecker on 2/24/19.
//  Copyright © 2019 Keith Ecker. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class CourseInfoViewController:UIViewController, UITableViewDelegate, UITableViewDataSource{
    var course:ClassInfo?
    var reviews:[Review] = []
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var courseCodeLabel: UILabel!
    @IBOutlet weak var semesterLabel: UILabel!
    @IBOutlet weak var gpaLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var reviewTableView: UITableView!
    @IBOutlet weak var reviewAddButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        courseNameLabel.text = course?.className
        courseCodeLabel.text = course?.classCode
        semesterLabel.text = course?.semester.toString()
        descriptionTextView.text = course?.description
        gpaLabel.text = "-"
        if let _ = Auth.auth().currentUser{
            reviewAddButton.isHidden = false
            reviewAddButton.isEnabled = true
        }else{
            reviewAddButton.isEnabled = false
            reviewAddButton.isHidden = true
        }
        //gpaLabel.text = course?.gpa
        reviewTableView.dataSource = self
        reviewTableView.delegate = self
        getReviews()
    }
    override func viewWillAppear(_ animated: Bool) {
        getReviews()
    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAssignments"{
            let assignmentTableViewController = segue.destination as! AssignmentTableViewController
            assignmentTableViewController.assignments = (course?.assignments)!
        } else if segue.identifier == "toCourseReview"{
            let courseReviewViewController = segue.destination as! CourseReviewViewController
            courseReviewViewController.classCodeGiven = course?.classCode
            courseReviewViewController.className = course?.className
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reviewTableCellIdentifier") as? ReviewTableViewCell else {
            fatalError("Could not dequeue a cell")
        }
        let review = reviews[indexPath.row]
        cell.subjectLabel.text = review.subject
        cell.reviewTextField.text = review.review
        cell.usernameLabel.text = review.username
        cell.gradeLabel.text = review.grade
        return cell
    }
    
    func getReviews(){
        Review.loadCourseReviews(code: (course?.classCode)!, completion: { (loadedReviews) in
            self.reviews = loadedReviews
            self.gpaLabel.text = String(Review.calculateGPA(reviews: loadedReviews))
            self.reviewTableView.reloadData()
        })
    }
}
