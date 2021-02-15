//
//  CreateGoalVC.swift
//  goalpost-app
//
//  Created by Artur Zarzecki on 15/02/2021.
//  Copyright © 2021 Artur Zarzecki. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController {
    
    @IBOutlet var goalTextView: UITextView!
    @IBOutlet var shortTermBtn: UIButton!
    @IBOutlet var longTermBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func shortTermBtnWasPressed(_ sender: Any) {
    }
    
    @IBAction func longTermBtnWasPressed(_ sender: Any) {
    }
    
    @IBAction func nextBtnWasPressed(_ sender: Any) {
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
