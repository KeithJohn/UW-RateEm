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
    var semester: String
    var assignments: [Assignment]?
    
    static func loadClasses() -> [ClassInfo]{
        let coursesRef = Database.database().reference().child("courses")
        coursesRef.observeSingleEvent(of: .value) { (snapshot) in
            let enumerator = snapshot.children
            while let course = enumerator.nextObject() as? DataSnapshot{
                if let courseInfo = course.value as? NSDictionary{
                    let courseDescription = courseInfo["description"]!
                    let courseName = courseInfo["courseName"]
                    //TODO: Figure out how to get array values from database
                    //TODO: Get assignments
                    //TODO: Get semester
                    
                    
                }
            }
        }
        
        let class1 = ClassInfo.init(classCode: "TEST", className: "Test Class", semester: "Fall-18 19", assignments: nil)
        
        return [class1]
    }
}
