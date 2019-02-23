//
//  ClassInfo.swift
//  UW-RateEm
//
//  Created by Keith Ecker on 2/20/19.
//  Copyright © 2019 Keith Ecker. All rights reserved.
//

import Foundation
import Firebase

struct ClassInfo {
    var classCode: String
    var className: String
    var semester: Semester
    var assignments: [Assignment]?
    var description: String?
    
    static func loadClasses(completion: @escaping ([ClassInfo]) -> Void){
        var courses:[ClassInfo] = []
        let coursesRef = Database.database().reference().child("courses")
        coursesRef.observeSingleEvent(of: .value) { (snapshot) in
            let enumerator = snapshot.children
            
            //Get each childs information
            while let course = enumerator.nextObject() as? DataSnapshot{
                if let courseInfo = course.value as? NSDictionary{
                    //Get course description and name
                    let courseDescription = courseInfo["description"] as? String
                    let courseName = courseInfo["courseName"] as! String
                    
                    //Get course assignments
                    //TODO: Fix this
                    var assignments:[Assignment] = []
                    Database.database().reference().child("Assignments").queryOrdered(byChild: "classCode").queryEqual(toValue: course.key).observeSingleEvent(of: .value, with: { (assignmentSnapshot) in
                        let assignmentEnumerator = assignmentSnapshot.children
                        while let assignment = assignmentEnumerator.nextObject() as? DataSnapshot{
                            if let assignmentInfo = Assignment.getAssignmentFromDataSnapShot(snapshot: assignment){
                                assignments.append(assignmentInfo)
                            }
                        }
                    })

                    //Get course semester
                    var semester:Semester? = nil
                    let semesterSnapshot = course.childSnapshot(forPath: "semester")
                    let semesterInfo = semesterSnapshot.value as? NSDictionary
                    let term = semesterInfo?["term"] as! String
                    let year = semesterInfo?["year"] as! Int
                    semester = Semester.init(term: .spring, year: year)
                    switch term {
                    case "fall":
                        semester?.term = .fall
                        break
                    case "summer":
                        semester?.term = .summer
                        break
                    default:
                        break
                    }
                    
                    //Create class object and append to course array
                    let class1 = ClassInfo.init(classCode: course.key, className: courseName, semester: semester!, assignments: assignments, description: courseDescription)
                    courses.append(class1)
                }
            }
            //completion return
            completion(courses)
        }
    }
}
