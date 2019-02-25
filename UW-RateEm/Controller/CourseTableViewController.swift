//
//  CourseTableViewController.swift
//  UW-RateEm
//
//  Created by Keith Ecker on 2/23/19.
//  Copyright © 2019 Keith Ecker. All rights reserved.
//

import Foundation
import UIKit

class CourseTableViewController: UITableViewController{
    var courses:[ClassInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getClasses()
        self.tableView.rowHeight = 100.0
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "classTableCellIdentifier") as? CourseTableViewCell else {
            fatalError("Could not dequeue a cell")
        }
        let course = courses[indexPath.row]
        cell.courseCodeLabel.text = course.classCode
        cell.courseNameLabel.text = course.className
        cell.semesterLabel.text = course.semester.toString()
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCourseInfo"{
            let courseInfoController = segue.destination as! CourseInfoViewController
            let indexPath = tableView.indexPathForSelectedRow!
            let selectedClass = courses[indexPath.row]
            print("SELECTED CLASS: \(selectedClass)")
            courseInfoController.course = selectedClass
        }
    }
    
    func getClasses(){
        ClassInfo.loadClasses { (loadedCourses) in
           self.courses = loadedCourses
            self.tableView.reloadData()
        }
    }
}
