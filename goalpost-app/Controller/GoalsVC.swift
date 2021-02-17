//
//  GoalsVC.swift
//  goalpost-app
//
//  Created by Artur Zarzecki on 05/02/2021.
//  Copyright © 2021 Artur Zarzecki. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate // we can access form anywhere

class GoalsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var goals: [Goal] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
    }
    
    // view will appear is shown avrey time when view is appear not only first time when is load
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetch { (complete) in
            if complete {
                if goals.count > 1 {
                    tableView.isHidden = false
                } else {
                    tableView.isHidden = true
                }
            }
        }
        tableView.reloadData()
    }

    @IBAction func addGoalBtnWasPressed(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") else { return }
        
        presentDetail(createGoalVC)
    }
    
}

extension GoalsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else { return UITableViewCell() }
        let goal = goals[indexPath.row]
        cell.configureCell(goal: goal)
        return cell
    }
}


extension GoalsVC {
    func fetch(completion: (_ complete: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Goal")
        
        do {
            goals = try managedContext.fetch(fetchRequest) as! [Goal]
            print("Succesfully fetched data.")
            completion(true)
        } catch  {
            debugPrint("Could not fetch: \(error.localizedDescription)")
            completion(false)
        }
    }
}


















