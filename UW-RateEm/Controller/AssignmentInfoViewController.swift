//
//  AssignmentInfoViewController.swift
//  UW-RateEm
//
//  Created by Keith Ecker on 2/24/19.
//  Copyright © 2019 Keith Ecker. All rights reserved.
//

import Foundation
import UIKit

class AssignmentInfoViewController:UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var assignment: Assignment?
    var reviews:[Review] = []
    @IBOutlet weak var assignmentNameLabel: UILabel!
    @IBOutlet weak var classCodeLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var reviewTableView: UITableView!
    @IBOutlet weak var gpaLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignmentNameLabel.text = assignment?.assignmentName
        classCodeLabel.text = assignment?.classCode
        descriptionTextView.text = assignment?.description
        reviewTableView.dataSource = self
        reviewTableView.delegate = self
        getReviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getReviews()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAssignmentReview" {
            let assignmentReviewViewController = segue.destination as! AssignmentReviewViewController
            assignmentReviewViewController.assignmentCodeGiven = assignment?.assignmentCode
            assignmentReviewViewController.assignmentName = assignment?.assignmentName
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
        Review.loadAssignmentReviews(code: (assignment?.assignmentCode)!, completion: { (loadedReviews) in
            self.reviews = loadedReviews
            print("REVIEWS_____\(self.reviews)")
            self.gpaLabel.text = String(Review.calculateGPA(reviews: loadedReviews))
            self.reviewTableView.reloadData()
        })
    }
    
    }
