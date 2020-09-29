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
  
    var item1 = ["item": "Chicken", "Steps": ["CookRice","Add Water","Heat 45 Mins"]] as [String : Any]
    var item2 = ["item": "Mutton", "Steps": ["Hot water","lamb pieces","Heat for 30 mins"]] as [String : Any]
    var item3 = ["item": "Shrimp", "Steps": ["cold Water","Shrimp","Heat for 1 hour"]] as [String : Any]
    var item4 = ["item": "Mushroom", "Steps": ["cold Water","mushroom","Heat for 2 hour"]] as [String : Any]
    var receipers = [[String:Any]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.receipers.append(item1)
        self.receipers.append(item2)
        self.receipers.append(item3)
        self.receipers.append(item4)
        self.title = "Recipes"
        self.titleTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.titleTextField.endEditing(true)
        return true
    }
    
    @IBAction func addTitleButton(_ sender: UIButton) {
        if let textTitle = titleTextField.text {
            let newRecipe =  ["item": textTitle, "Steps": []] as [String : Any]
           // receipers.insert(newRecipe, at: 0)
            receipers.append(newRecipe)
            //receipers.reverse()
            tableView.reloadData()
          //  titleTextField.text = nil
        }
    }
    
    @objc func moreButtonClicked(sender: UIButton) {
        let clickedCell = sender.tag
        let alert = UIAlertController(title: "Select Option", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Add Steps", style: .default, handler: { (UIAlertAction) in
            self.addSteps(tag: clickedCell)
        }))
        
        alert.addAction(UIAlertAction(title: "View Steps", style: .default, handler: { (UIAlertAction) in
            self.deletebuttonClicked(tag: clickedCell)
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { (UIAlertAction) in
            
        }))
        
        
        
            }
}

extension ViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receipers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! RecipeTitleTableViewCell
        cell.btnMore.addTarget(self, action: #selector(moreButtonClicked(sender:)), for: .touchUpInside)
        cell.btnMore.tag = indexPath.row
        //cell.addSteps.addTarget(self, action: #selector(addSteps(sender:)), for: .touchUpInside) // know once again.
//        cell.addSteps.tag = indexPath.row
//        cell.viewSteps.addTarget(self, action: #selector(viewReceipeSteps(sender:)), for: .touchUpInside)
//        cell.viewSteps.tag = indexPath.row
//        cell.deleteOutlet.addTarget(self, action: #selector(deletebuttonClicked(sender:)), for: .touchUpInside)  // know it once.
//        cell.deleteOutlet.tag = indexPath.row
        cell.recipeTitle.text = receipers[indexPath.row]["item"] as? String
        print(receipers[indexPath.row]["item"])
        return cell
    }
    
    
    
    @objc func viewReceipeSteps(sender: UIButton) {
        let VC = self.storyboard?.instantiateViewController(identifier: "viewReceipeStepsVC") as! ViewReceipeStepsTableViewController
        VC.getSteps(array: receipers[sender.tag]["Steps"] as! [String])
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @objc func deletebuttonClicked(tag: Int) {
        let alert = UIAlertController(title: "Alert", message: "You are deleting title of Recipe", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
        self.deleteItemInArray(arrayValue: tag)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func deleteItemInArray(arrayValue: Int) {
        receipers.remove(at: arrayValue)
        tableView.reloadData()
    }
    
    @objc func addSteps(tag: Int) {
        let VC = self.storyboard?.instantiateViewController(identifier: "recipesStepsVC") as! RecipesStepsViewController
        // VC.recipesTL(title: recipes[sender.tag] as! String)
        self.navigationController?.pushViewController(VC, animated: true)
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let VC = self.storyboard?.instantiateViewController(identifier: "recipesStepsVC") as! RecipesStepsViewController
      //  VC.recipeTitle = recipes[indexPath.row] as? String
        self.navigationController?.pushViewController(VC, animated: true)
        // deleteItemInArray(arrayValue: indexPath.row)
    }
}


