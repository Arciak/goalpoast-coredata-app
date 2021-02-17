//
//  CreateGoalVC.swift
//  goalpost-app
//
//  Created by Artur Zarzecki on 15/02/2021.
//  Copyright © 2021 Artur Zarzecki. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController {
    
    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var shortTermBtn: UIButton!
    @IBOutlet weak var longTermBtn: UIButton!
    
    
    var goalType: GoalType = .shortTerm
    

    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.bindToKeyboard()
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedColor()
    }
    
    

    @IBAction func shortTermBtnWasPressed(_ sender: Any) {
        goalType = .shortTerm
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedColor()
    }

    @IBAction func longTermBtnWasPressed(_ sender: Any) {
        goalType = .longTerm
        longTermBtn.setSelectedColor()
        shortTermBtn.setDeselectedColor()
    }
    
    @IBAction func nextBtnWasPressed(_ sender: Any) {
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
}
