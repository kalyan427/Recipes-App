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
    var item1 = ["item": "Mutton","Ingredients":["Mutton", "Tamrind", "Garlic", "Onions", "Tamto", "Mirchi", "Water","Mutton", "Tamrind", "Garlic", "Onions", "Tamto", "Mirchi", "Water","Mutton", "Tamrind", "Garlic", "Onions", "Tamto", "Mirchi", "Water","Mutton", "Tamrind", "Garlic", "Onions", "Tamto", "Mirchi", "Water"], "Steps": ["Hot water","lamb pieces","Heat for 30 mins"]] as [String : Any]
    var item2 = ["item": "Shrimp", "Ingredients":["Shrimp", "Tamrind", "Garlic", "Onions", "Tamto", "Mirchi", "Water"],"Steps": ["cold Water","Shrimp","Heat for 1 hour"]] as [String : Any]
    var item3 = ["item": "Mushroom", "Ingredients":["Mushroom", "Tamrind", "Garlic", "Onions", "Tamto", "Mirchi", "Water"], "Steps": ["cold Water","mushroom","Heat for 2 hour"]] as [String : Any]
    var receipers = [[String:Any]]()
    var filteredReceipe = [Any]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.receipers.append(item0)
        self.receipers.append(item1)
        self.receipers.append(item2)
        self.receipers.append(item3)
        self.title = "Recipes"
        self.titleTextField.delegate = self
        self.filteredReceipe = DataManager().getAllReceipes()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.titleTextField.endEditing(true)
        return true
    }
    
    @IBAction func addTitleButton(_ sender: UIButton) {
        if let textTitle = titleTextField.text {
            DataManager().saveReceipe(Title: textTitle)
            self.filteredReceipe = DataManager().getAllReceipes()
            tableView.reloadData()
            self.titleTextField.text = nil
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
            self.viewReceipeSteps(tag: clickedCell)
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler: { (UIAlertAction) in
            
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    func deleteItemInArray(arrayValue: Int) {
        //receipers.remove(at: arrayValue)
        filteredReceipe.remove(at: arrayValue)
        tableView.reloadData()
    }
    
    @objc func addSteps(tag: Int) {
        let VC = self.storyboard?.instantiateViewController(identifier: "recipesStepsVC") as! RecipesStepsViewController
        VC.getRecipesTL(title: receipers[tag]["item"] as! String)
        VC.getIngredients(ingredients: receipers[tag]["Ingredients"] as! Array<Any>)
        VC.getSteps(allSteps: receipers[tag]["Steps"] as! Array<Any>)
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @objc func deletebuttonClicked(tag: Int) {
        let alert = UIAlertController(title: "Alert", message: "You are deleting title of Recipe", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            self.deleteItemInArray(arrayValue: tag)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func viewReceipeSteps(tag: Int) {
        let VC = self.storyboard?.instantiateViewController(identifier: "viewStepsVC") as! viewReceipeStepsViewController
        VC.getReceipeTitle(title: receipers[tag]["item"] as! String)
        VC.viewIngredients(ingredientsList: receipers[tag]["Ingredients"] as! Array<Any>)
        VC.getSteps(array: receipers[tag]["Steps"] as! Array<Any>)
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        titleTextField.text = ""
    }
}

extension ViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredReceipe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! RecipeTitleTableViewCell
        cell.btnMore.addTarget(self, action: #selector(moreButtonClicked(sender:)), for: .touchUpInside)
        cell.btnMore.tag = indexPath.row
        let receipeItem = self.filteredReceipe[indexPath.row] as! Receipe
        cell.recipeTitle.text = receipeItem.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let VC = self.storyboard?.instantiateViewController(identifier: "recipesStepsVC") as! RecipesStepsViewController
        VC.getRecipesTL(title: receipers[indexPath.row]["item"] as! String )
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Warning", message: "You are deleting Title of Receipe", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive, handler: { (action) in
                
            }))
        }
    }
}


