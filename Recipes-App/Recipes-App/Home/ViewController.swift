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
  
    var item0 = ["item": "Chicken","Ingredients":["chicken", "Tamrind", "Garlic", "Onions", "Tamto", "Mirchi", "Water"], "Steps": ["CookRice","Add Water","Heat 45 Mins"]] as [String : Any]
    var item1 = ["item": "Mutton","Ingredients":["Mutton", "Tamrind", "Garlic", "Onions", "Tamto", "Mirchi", "Water"], "Steps": ["Hot water","lamb pieces","Heat for 30 mins"]] as [String : Any]
    var item2 = ["item": "Shrimp", "Ingredients":["Shrimp", "Tamrind", "Garlic", "Onions", "Tamto", "Mirchi", "Water"],"Steps": ["cold Water","Shrimp","Heat for 1 hour"]] as [String : Any]
    var item3 = ["item": "Mushroom", "Ingredients":["Mushroom", "Tamrind", "Garlic", "Onions", "Tamto", "Mirchi", "Water"], "Steps": ["cold Water","mushroom","Heat for 2 hour"]] as [String : Any]
    var receipers = [[String:Any]]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.receipers.append(item0)
        self.receipers.append(item1)
        self.receipers.append(item2)
        self.receipers.append(item3)
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
            receipers.append(newRecipe)
            tableView.reloadData()
        }
    }
    
    @objc func moreButtonClicked(sender: UIButton) {
        let clickedCell = sender.tag
        let alert = UIAlertController(title: "Select Option", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Add Steps", style: .default, handler: { (UIAlertAction) in
            self.addSteps(tag: clickedCell)
        }))
        
        alert.addAction(UIAlertAction(title: "View Steps", style: .default, handler: { (UIAlertAction) in
            //self.deletebuttonClicked(tag: clickedCell)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler: { (UIAlertAction) in
            
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    func deleteItemInArray(arrayValue: Int) {
        receipers.remove(at: arrayValue)
        tableView.reloadData()
    }
    
    @objc func addSteps(tag: Int) {
        let VC = self.storyboard?.instantiateViewController(identifier: "recipesStepsVC") as! RecipesStepsViewController
       // VC.getIngredients(ingredients: receipers[tag]["Ingredients"] as! Array<Any>)
        VC.getIngredients(ingredients: receipers[tag]["Steps"] as! Array<Any>)
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @objc func deletebuttonClicked(tag: Int) {
        let alert = UIAlertController(title: "Alert", message: "You are deleting title of Recipe", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            self.deleteItemInArray(arrayValue: tag)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func viewReceipeSteps(sender: UIButton) {
        let VC = self.storyboard?.instantiateViewController(identifier: "viewReceipeStepsVC") as! ViewReceipeStepsTableViewController
        VC.getSteps(array: receipers[sender.tag]["Steps"] as! [String])
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        titleTextField.text = ""
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
        cell.recipeTitle.text = receipers[indexPath.row]["item"] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let VC = self.storyboard?.instantiateViewController(identifier: "recipesStepsVC") as! RecipesStepsViewController
        VC.recipesTL(title: receipers[indexPath.row]["item"] as! String )
        self.navigationController?.pushViewController(VC, animated: true)
    }
}


