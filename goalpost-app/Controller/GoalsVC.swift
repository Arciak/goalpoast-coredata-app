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
    @IBOutlet weak var undoHighConstraint: NSLayoutConstraint!
    
    
    var goals: [Goal] = []
    var removedGoal: [RemovedGoal] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
    }
    
    // view will appear is shown avrey time when view is appear not only first time when is load
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCoreDataObjects()
        tableView.reloadData()
    }
    
    func fetchCoreDataObjects() {
        self.fetch { (complete) in
            if complete {
                if goals.count >= 1 {
                    tableView.isHidden = false
                } else {
                    tableView.isHidden = true
                }
                
                if removedGoal.count == 0 {
                    undoHighConstraint.constant = 0
                    print("Frame 0")
                } else {
                    undoHighConstraint.constant = 50
                    print("Frame 50")
                }
            }
        }
    }

    @IBAction func addGoalBtnWasPressed(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") else { return }
        
        presentDetail(createGoalVC)
    }
    
    @IBAction func undoPressedBtn(_ sender: Any) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let goal = Goal(context: managedContext)
        goal.goalDescription = removedGoal[(removedGoal.endIndex - 1)].goalDescription
        goal.goalType = removedGoal[(removedGoal.endIndex - 1)].goalType
        goal.goalCompletionVal = removedGoal[(removedGoal.endIndex - 1)].goalCompletionVal
        goal.goalProgress = removedGoal[(removedGoal.endIndex - 1)].goalProgress
        
        managedContext.delete(removedGoal[(removedGoal.endIndex - 1)])
        
        do {
            try managedContext.save()
            print("Successfully removed goal!")
        } catch {
            debugPrint("Could not remove: \(error.localizedDescription)")
        }
        
        fetchCoreDataObjects()
        tableView.reloadData()
        
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "DELETE") { (_, _, complete) in
            self.removeGoal(atIndexPath: indexPath)
            self.fetchCoreDataObjects()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            complete(true)
        }
        
        let addAction = UIContextualAction(style: .normal, title: "ADD 1") { (_, _, complete) in
            self.setProgress(atIndexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        addAction.backgroundColor = #colorLiteral(red: 1, green: 0.4739384985, blue: 0.02109774237, alpha: 0.75)
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, addAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
}


extension GoalsVC {
    
    func setProgress(atIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let chosenGoal = goals[indexPath.row]
        
        if chosenGoal.goalProgress < chosenGoal.goalCompletionVal {
            chosenGoal.goalProgress = chosenGoal.goalProgress + 1
        } else {
            return
        }
        
        do {
            try managedContext.save()
            print("Successfully set progress!")
        } catch {
            debugPrint("Could not set progress: \(error.localizedDescription)")
        }
    }
    
    func removeGoal(atIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let restoreGoal = RemovedGoal(context: managedContext)
        restoreGoal.goalDescription = goals[indexPath.row].goalDescription
        restoreGoal.goalType = goals[indexPath.row].goalType
        restoreGoal.goalCompletionVal = goals[indexPath.row].goalCompletionVal
        restoreGoal.goalProgress = Int32(0)
        managedContext.delete(goals[indexPath.row])
        
        do {
            try managedContext.save()
            print("Successfully removed goal!")
        } catch {
            debugPrint("Could not remove: \(error.localizedDescription)")
        }
    }
    
    
    func fetch(completion: (_ complete: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let fetchRequestGoals = NSFetchRequest<NSFetchRequestResult>(entityName: "Goal")
        let fetchRequestRemovedGoal = NSFetchRequest<NSFetchRequestResult>(entityName: "RemovedGoal")
        
        do {
            goals = try managedContext.fetch(fetchRequestGoals) as! [Goal]
            removedGoal = try managedContext.fetch(fetchRequestRemovedGoal) as! [RemovedGoal]
            print("Succesfully fetched data.")
            completion(true)
        } catch  {
            debugPrint("Could not fetch: \(error.localizedDescription)")
            completion(false)
        }
    }
}


















