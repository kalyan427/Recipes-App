//
//  RecipesStepsViewController.swift
//  Recipes-App
//
//  Created by venkata kalyan pasupuleti on 8/30/20.
//  Copyright © 2020 quiz. All rights reserved.
//

import UIKit
import TagListView

class RecipesStepsViewController: UIViewController,UITextFieldDelegate, TagListViewDelegate {
    @IBOutlet weak var stepsTF: UITextField!
    @IBOutlet weak var addStepsTF: UITextField!
    var recipeTitle: String?    
    var steps = [Any]()
    @IBOutlet weak var stepsTblView: UITableView!
    @IBOutlet weak var tagListView: TagListView!
    var listAllIngredients = [Any]()

    var receipeData = [String:Any]()
    @IBOutlet weak var tagListViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.recipeTitle
        self.stepsTF.delegate = self
        tagListView.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTapped))
        for item in listAllIngredients {
            var tempItem = item
            tagListView.addTag(tempItem as! String)
            tagListView.textFont = UIFont.systemFont(ofSize: 14)
            tagListView.tagBackgroundColor = UIColor.init(red: 12/255, green: 114/255, blue: 211/255, alpha: 1)
            tagListView.cornerRadius = 12
            tagListView.paddingX = 10
            tagListView.paddingY = 13
            tagListView.enableRemoveButton = true
        }
        tagListViewHeight.constant = self.tagListView.intrinsicContentSize.height
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.stepsTF.endEditing(true)
        return true
    }
    
    @objc func saveTapped() {
        
    }
    
    func getRecipesTL(title: String) {
        self.recipeTitle = title
    }
    
    @IBAction func addStepsButton(_ sender: UIButton) {
        steps.append(addStepsTF.text!)
        stepsTblView.reloadData()
        addStepsTF.text = nil
    }
    
    @IBAction func addIngredients(_ sender: UIButton) {
        tagListView.textFont = UIFont.systemFont(ofSize: 14)
        tagListView.tagBackgroundColor = UIColor.init(red: 12/255, green: 114/255, blue: 211/255, alpha: 1)
        tagListView.cornerRadius = 12
        tagListView.paddingX = 10
        tagListView.paddingY = 13
        tagListView.enableRemoveButton = true
        if let emptyCheck = stepsTF.text {
            if (emptyCheck.count == 0) {
            }
            else {
                tagListView.addTag(stepsTF.text!)
                tagListViewHeight.constant = self.tagListView.intrinsicContentSize.height
                stepsTF.text = nil
            }
        }
    }
    
    func getIngredients (ingredients: Array<Any>) {
        listAllIngredients = ingredients
    }
    
    func  getSteps (allSteps: Array<Any>) {
        steps = allSteps
    }
    
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag pressed: \(title), \(sender)")
        tagListView.removeTag(title)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        stepsTF.text = ""
     //   addStepsTF.text = ""   Ask Harish
    }
}

extension RecipesStepsViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return steps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell") as! TextInputTableViewCell
        cell.recipeStepsLabel.text = steps[indexPath.row] as! String
       // cell.recipeStepsLabel.text = listAllSteps[indexPath.row] as? String
        cell.stepsNumber.text = String(indexPath.row + 1) + "."
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 70
//    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let alert = UIAlertController(title: "Alert", message: "You are deleting title of Recipe", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
                self.steps.remove(at: indexPath.row)
                tableView.reloadData()
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
