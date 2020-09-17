//
//  RecipesStepsViewController.swift
//  Recipes-App
//
//  Created by venkata kalyan pasupuleti on 8/30/20.
//  Copyright © 2020 quiz. All rights reserved.
//

import UIKit

class RecipesStepsViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var stepsTF: UITextField!
    var recipeTitle: String?
    var steps = [Any]()
    @IBOutlet weak var stepsTblView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.recipeTitle
        self.stepsTF.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.stepsTF.endEditing(true)
        return true
    }
    
    func recipesTL(title: String) {
        self.recipeTitle = title
    }
    
    @IBAction func addStepsButton(_ sender: UIButton) {
        steps.append(stepsTF.text!)
        stepsTblView.reloadData()
        stepsTF.text = nil
    }
}

extension RecipesStepsViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return steps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell") as! TextInputTableViewCell
        cell.recipeStepsLabel.text = steps[indexPath.row] as! String
        cell.stepsNumber.text = String(indexPath.row + 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let alert = UIAlertController(title: "Alert", message: "You are deleting title of Recipe", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
                self.steps.remove(at: indexPath.row)
                          tableView.beginUpdates()
                          tableView.deleteRows(at: [indexPath], with: .none)
                          tableView.endUpdates()
            }))
            self.present(alert, animated: true, completion: nil)
         
        }
    }
}
