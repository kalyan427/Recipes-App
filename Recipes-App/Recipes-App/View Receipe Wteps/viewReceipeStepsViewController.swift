//
//  viewReceipeStepsViewController.swift
//  Recipes-App
//
//  Created by venkata kalyan pasupuleti on 10/9/20.
//  Copyright © 2020 quiz. All rights reserved.
//

import UIKit
import TagListView

class viewReceipeStepsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,TagListViewDelegate {
    var allSteps = [Any]()
    @IBOutlet weak var viewStepsTblView: UITableView!
    @IBOutlet weak var viewStepsTagListView: TagListView!
    var showAllIngredients = [Any]()
    @IBOutlet weak var viewTagListViewHeight: NSLayoutConstraint!
    var receipeTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for item in showAllIngredients {
            var tempItem = item
            viewStepsTagListView.addTag(tempItem as! String)
            viewStepsTagListView.textFont = UIFont.systemFont(ofSize: 14)
            viewStepsTagListView.tagBackgroundColor = UIColor.init(red: 12/255, green: 114/255, blue: 211/255, alpha: 1)
            viewStepsTagListView.cornerRadius = 12
            viewStepsTagListView.paddingX = 10
            viewStepsTagListView.paddingY = 13
        }
        viewTagListViewHeight.constant = self.viewStepsTagListView.intrinsicContentSize.height
    }
    
    func getReceipeTitle(title: String) {
        receipeTitle = title
    }
    
    func getSteps(array: Array<Any>) {
        allSteps = array
    }
    
    func viewIngredients(ingredientsList: Array<Any>) {
        showAllIngredients = ingredientsList
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allSteps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "viewStepsCell") as! AllStepsTableViewCell
        cell.viewStepsLabel.text = allSteps[indexPath.row] as! String
        cell.stepCount.text = String(indexPath.row + 1) + "."
        return cell
    }
}
