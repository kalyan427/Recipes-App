//
//  ViewController.swift
//  Recipes-App
//
//  Created by venkata kalyan pasupuleti on 8/25/20.
//  Copyright © 2020 quiz. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var addTitle: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    //var recipes = ["Chicken Biryani","Mutton Biryani","Crab Biryani"]
    var recipes = [Any]()
    var recipesSteps = ["Cook Rice","Add Water","Heat 45 Mins"]
    var 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Recipes"
        self.titleTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.titleTextField.endEditing(true)
        return true
    }
    
    @IBAction func addTitleButton(_ sender: UIButton) {
        if let textTitle = titleTextField.text {
            recipes.append(textTitle)
            print("addButton:\(recipes)")
            tableView.reloadData()
            titleTextField.text = nil
        }
    }
}

extension ViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! RecipeTitleTableViewCell
        cell.addSteps.addTarget(self, action: #selector(addSteps(sender:)), for: .touchUpInside) // know once again.
        cell.addSteps.tag = indexPath.row
        cell.viewSteps.addTarget(self, action: #selector(viewReceipeSteps(sender:)), for: .touchUpInside)
        cell.viewSteps.tag = indexPath.row
        cell.deleteOutlet.addTarget(self, action: #selector(deletebuttonClicked(sender:)), for: .touchUpInside)
        cell.deleteOutlet.tag = indexPath.row
        cell.recipeTitle.text = recipes[indexPath.row] as? String
        return cell
    }
    
    @objc func viewReceipeSteps(sender: UIButton) {
        let VC = self.storyboard?.instantiateViewController(identifier: "viewReceipeStepsVC") as! ViewReceipeStepsTableViewController
        VC.getSteps(array: recipesSteps)
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @objc func deletebuttonClicked(sender: UIButton) {
        let clickedCell = sender.tag
        let alert = UIAlertController(title: "Alert", message: "You are deleting title of Recipe", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
        self.deleteItemInArray(arrayValue: clickedCell)
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func deleteItemInArray(arrayValue: Int) {
        recipes.remove(at: arrayValue)
        tableView.reloadData()
    }
    
    @objc func addSteps(sender: UIButton) {
        let VC = self.storyboard?.instantiateViewController(identifier: "recipesStepsVC") as! RecipesStepsViewController
        VC.recipesTL(title: recipes[sender.tag] as! String)
        self.navigationController?.pushViewController(VC, animated: true)
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let VC = self.storyboard?.instantiateViewController(identifier: "recipesStepsVC") as! RecipesStepsViewController
        VC.recipeTitle = recipes[indexPath.row] as? String
        self.navigationController?.pushViewController(VC, animated: true)
        // deleteItemInArray(arrayValue: indexPath.row)
    }
}


