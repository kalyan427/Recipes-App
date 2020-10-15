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
    var filteredReceipe = [Any]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Recipes"
        self.titleTextField.delegate = self
        self.filteredReceipe = DataManager().getAllReceipes()
        titleTextField.layer.cornerRadius = 20
        titleTextField.layer.borderWidth = 1
        titleTextField.layer.borderColor = UIColor(red: 233/255, green: 234/255, blue: 245/255, alpha: 1).cgColor
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
        filteredReceipe.remove(at: arrayValue)
        tableView.reloadData()
    }
    
    @objc func addSteps(tag: Int) {
        let receipeSteps = self.storyboard?.instantiateViewController(identifier: "recipesStepsVC") as! RecipesStepsViewController
        receipeSteps.getRecipe(item: self.filteredReceipe[tag] as! Receipe)
        self.navigationController?.pushViewController(receipeSteps, animated: true)
    }
    
    @objc func deletebuttonClicked(tag: Int) {
        let alert = UIAlertController(title: "Alert", message: "You are deleting title of Recipe", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            self.deleteItemInArray(arrayValue: tag)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func viewReceipeSteps(tag: Int) {
        let receipsView = self.storyboard?.instantiateViewController(identifier: "viewStepsVC") as! viewReceipeStepsViewController
          receipsView.getRecipe(item: self.filteredReceipe[tag] as! Receipe)
        self.navigationController?.pushViewController(receipsView, animated: true)
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
        let receipsView = self.storyboard?.instantiateViewController(identifier: "viewStepsVC") as! viewReceipeStepsViewController
        receipsView.getRecipe(item: self.filteredReceipe[indexPath.row] as! Receipe)
        self.navigationController?.pushViewController(receipsView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Warning", message: "You are deleting Title of Receipe", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.default, handler: { (action) in
                
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.destructive, handler: { (action) in
                
            }))
        }
    }
}


