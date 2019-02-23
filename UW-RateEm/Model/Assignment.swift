//
//  Assignment.swift
//  UW-RateEm
//
//  Created by Keith Ecker on 2/20/19.
//  Copyright © 2019 Keith Ecker. All rights reserved.
//

import Foundation
import Firebase

struct Assignment {
    var assignmentCode: String
    var classCode: String
    var assignmentName: String
    var description: String

    static func getAssignmentFromDataSnapShot(snapshot: DataSnapshot) -> Assignment? {
        if let assignmentInfo = snapshot.value as? NSDictionary{
            guard let assignmentName = assignmentInfo["assignmentName"] as? String else{return nil}
            guard let classCode = assignmentInfo["classCode"] as? String else{return nil}
            guard let description = assignmentInfo["description"] as? String else{return nil}
            
            let assignment = Assignment.init(assignmentCode: snapshot.key, classCode: classCode, assignmentName: assignmentName, description: description)
            return assignment
        }else{
            print("ERROR getting assignment info from data snapshot ")
        }
        return nil
    }
}
