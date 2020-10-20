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
    
    var selectedReceipe:Receipe?
    var recipeSteps = [Steps]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.selectedReceipe?.title
        let recipeSteps = DataManager().getReceipeSteps(id: Int(self.selectedReceipe!.id))
        let ingredients = DataManager().getReceipeIngredients(id: Int(self.selectedReceipe!.id))
        for items in recipeSteps {
            allSteps.append(items.steps!)
        }
        for items in ingredients{
            showAllIngredients.append(items.steps!)
        }
        
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
    
     func getRecipe (item: Receipe) {
           selectedReceipe = item
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (allSteps.count == 0) {
            let noDataView = UILabel(frame: CGRect(x: 0, y: 0, width: viewStepsTblView.bounds.size.width, height: viewStepsTblView.bounds.size.height))
            noDataView.text = "No Data Available"
            noDataView.textColor = UIColor.black
            noDataView.textAlignment = .center
            viewStepsTblView.backgroundView = noDataView
            viewStepsTblView.separatorStyle = .none
        }
        return allSteps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "viewStepsCell") as! AllStepsTableViewCell
        cell.viewStepsLabel.text = allSteps[indexPath.row] as! String
        cell.stepCount.text = String(indexPath.row + 1) + "."
        return cell
    }
}
