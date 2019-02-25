//
//  Review.swift
//  UW-RateEm
//
//  Created by Keith Ecker on 2/24/19.
//  Copyright © 2019 Keith Ecker. All rights reserved.
//

import Foundation
import Firebase

struct Review {
    var subject:String
    var grade: String
    var review: String
    var code: String
    var username: String
    
    static func loadCourseReviews(code: String, completion: @escaping ([Review]) -> Void) {
        let ref = Database.database().reference().child("CourseReviews").queryOrdered(byChild: "classCode").queryEqual(toValue: code)
        var reviews:[Review] = []
        ref.observeSingleEvent(of: .value) { (reviewsSnap) in
            let reviewEnum = reviewsSnap.children
            while let review = reviewEnum.nextObject() as? DataSnapshot{
                if let reviewInfo = review.value as? NSDictionary{
                    let subject = reviewInfo["subject"] as! String
                    let grade = reviewInfo["grade"] as! String
                    let classCode = reviewInfo["classCode"] as! String
                    let username = reviewInfo["username"] as! String
                    let review = reviewInfo["review"] as! String
                    
                    let rev = Review.init(subject: subject, grade: grade, review: review, code: classCode, username: username)
                    reviews.append(rev)
                }
            }
            completion(reviews)
        }
    }
    
    static func loadAssignmentReviews(code: String, completion: @escaping ([Review]) -> Void) {
        let ref = Database.database().reference().child("AssignmentReviews").queryOrdered(byChild: "assignmentCode").queryEqual(toValue: code)
        var reviews:[Review] = []
        ref.observeSingleEvent(of: .value) { (reviewsSnap) in
            let reviewEnum = reviewsSnap.children
            while let review = reviewEnum.nextObject() as? DataSnapshot{
                if let reviewInfo = review.value as? NSDictionary{
                    let subject = reviewInfo["subject"] as! String
                    let grade = reviewInfo["grade"] as! String
                    let assignmentCode = reviewInfo["assignmentCode"] as! String
                    let username = reviewInfo["username"] as! String
                    let review = reviewInfo["review"] as! String
                    
                    let rev = Review.init(subject: subject, grade: grade, review: review, code: assignmentCode, username: username)
                    reviews.append(rev)
                }
            }
            completion(reviews)
        }
    }
    static func calculateGPA(reviews: [Review]) -> Double{
        var gradePointSum:Double = 0
        for review in reviews{

            switch review.grade{
            case "A":
                gradePointSum += 4.0
            case "A-":
                gradePointSum += 3.75
            case "B+":
                gradePointSum += 3.25
            case "B":
                gradePointSum += 3
            case "B-":
                gradePointSum += 2.75
            case "C":
                gradePointSum += 2.0
            case "D":
                gradePointSum += 1.0
            default:
                gradePointSum += 0
            }
        }
        return gradePointSum / Double(reviews.count)
    }
}
