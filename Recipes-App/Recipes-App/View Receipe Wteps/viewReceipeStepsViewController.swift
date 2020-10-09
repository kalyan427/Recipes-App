//
//  viewReceipeStepsViewController.swift
//  Recipes-App
//
//  Created by venkata kalyan pasupuleti on 10/9/20.
//  Copyright © 2020 quiz. All rights reserved.
//

import UIKit

class viewReceipeStepsViewController: UIViewController {
    var allSteps = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func getSteps(array: Array<Any>) {
        self.allSteps = array
    }
    
}
