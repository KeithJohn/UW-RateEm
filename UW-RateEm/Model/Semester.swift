//
//  Semester.swift
//  UW-RateEm
//
//  Created by Keith Ecker on 2/20/19.
//  Copyright © 2019 Keith Ecker. All rights reserved.
//

import Foundation

struct Semester: Comparable{
    static func < (lhs: Semester, rhs: Semester) -> Bool{
        return lhs.year <= rhs.year && lhs.term < rhs.term
    }
    
    enum Term: Int, Comparable {
        
        case spring = 0;
        case summer = 1;
        case fall = 2;
        
        static func < (lhs: Semester.Term, rhs: Semester.Term) -> Bool {
            return lhs.rawValue < rhs.rawValue
        }
        
    }
    var term: Term
    var year: Int
    
    func toString() -> String{
        var semesterString = ""
        switch term {
        case .spring:
            semesterString.append("Spring ")
        case .fall:
            semesterString.append("Fall ")
        case .summer:
            semesterString.append("Summer ")
        default:
            return ""
        }
        semesterString.append(String(year))
        return semesterString
    }
}
