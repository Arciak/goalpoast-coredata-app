//
//  GoalsVC.swift
//  goalpost-app
//
//  Created by Artur Zarzecki on 05/02/2021.
//  Copyright © 2021 Artur Zarzecki. All rights reserved.
//

import UIKit

class GoalsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func addGoalBtnWasPressed(_ sender: Any) {
        print("Btn was pressed")
    }
    
}

