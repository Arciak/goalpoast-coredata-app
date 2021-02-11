//
//  GoalsVC.swift
//  goalpost-app
//
//  Created by Artur Zarzecki on 05/02/2021.
//  Copyright © 2021 Artur Zarzecki. All rights reserved.
//

import UIKit
import CoreData

class GoalsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let goal = Goal()
        goal.goalCompletionVal = Int32(exactly: 12.0)
    }

    @IBAction func addGoalBtnWasPressed(_ sender: Any) {
        print("Btn was pressed")
    }
    
}

