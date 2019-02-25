//
//  AssignmentTableViewController.swift
//  UW-RateEm
//
//  Created by Keith Ecker on 2/24/19.
//  Copyright © 2019 Keith Ecker. All rights reserved.
//

import Foundation
import UIKit

class AssignmentTableViewController:UITableViewController{
    var assignments: [Assignment]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor.lightGray
        self.tableView.rowHeight = 80.0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assignments?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "assignmentTableCellIdentifier") as? AssignmentTableViewCell else {
            fatalError("Could not dequeue a cell")
        }
        let assignment = assignments?[indexPath.row]
        cell.assignmentNameLabel.text = assignment?.assignmentName
        cell.classCodeLabel.text = assignment?.classCode
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAssignmentInfo"{
            let assignmentInfoController = segue.destination as! AssignmentInfoViewController
            let indexPath = tableView.indexPathForSelectedRow!
            let selectedAssignment = assignments?[indexPath.row]
            assignmentInfoController.assignment = selectedAssignment
        }
    }
}
