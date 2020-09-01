//
//  ViewController.swift
//  Recipes-App
//
//  Created by venkata kalyan pasupuleti on 8/25/20.
//  Copyright © 2020 quiz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var addTitle: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Recipes"
    }
    
    @IBAction func addTitleButton(_ sender: UIButton) {
        let recipesStepsVC = (self.storyboard?.instantiateViewController(identifier: "recipesStepsVC"))! as RecipesStepsViewController
        self.navigationController?.pushViewController(recipesStepsVC, animated: true)
    }
}


