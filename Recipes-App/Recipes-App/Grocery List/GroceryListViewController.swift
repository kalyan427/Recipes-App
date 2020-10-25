//
//  GroceryListViewController.swift
//  Recipes-App
//
//  Created by venkata kalyan pasupuleti on 10/13/20.
//  Copyright © 2020 quiz. All rights reserved.
//

import UIKit
import GoogleMobileAds

class GroceryListViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var groceryTableView: UITableView!
    @IBOutlet weak var addGroceryItemsTextField: UITextField!
    @IBOutlet weak var addGroceryItem: UIButton!
    @IBOutlet weak var adView: GADBannerView!
    @IBOutlet weak var groceryView: UIView!
    var groceryList = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshScreen()
        groceryTableView.delegate = self
        addGroceryItemsTextField.delegate = self
        groceryView.layer.cornerRadius = 25
        groceryView.layer.borderWidth = 1
        groceryView.layer.borderColor = UIColor(red: 220/255, green: 234/255, blue: 220/255, alpha: 1).cgColor
        addGroceryItem.layer.cornerRadius = 30/2
        addGroceryItem.layer.masksToBounds = true
        addGroceryItem.layer.shadowColor = UIColor.black.cgColor
        addGroceryItem.layer.shadowOpacity = 0.8
        addGroceryItem.layer.shadowRadius = 3.0
        addGroceryItem.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.title = "SHOPPING LIST"
        
        // Google Ads.
        adView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        adView.rootViewController = self
        adView.load(GADRequest())
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addGroceryItemsTextField.endEditing(true)
        addGroceryItemsTextField.text = ""
        return true
    }
    
    @IBAction func addItemTapped(_ sender: UIButton) {
        if addGroceryItemsTextField.text?.count != 0 {
            
            DataManager().saveGroceriesSteps(isSelected: false, Steps: addGroceryItemsTextField.text!)
            self.groceryList = DataManager().getAllGroceries()
            groceryTableView.reloadData()
            addGroceryItemsTextField.text = nil
        }
    }
    
  @objc  func itemSelected(_ sender: UIButton) {
        let indexPathRow = sender.tag
        if let item = self.groceryList[indexPathRow] as? Groceries {
            if(item.isSelected){
                DataManager().setGrocerieWithSelected(id: Int(item.id), isSelected: false)
            }else{
                DataManager().setGrocerieWithSelected(id: Int(item.id), isSelected: true)
            }
        }
        refreshScreen()
    }
    
    func refreshScreen() {
        self.groceryList = DataManager().getAllGroceries()
        groceryTableView.reloadData()
    }
}


extension GroceryListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (groceryList.count != 0) {
            groceryTableView.backgroundView = nil
        } else {
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: groceryTableView.bounds.size.width, height: groceryTableView.bounds.size.height))
            noDataLabel.text = "No Data Available"
            noDataLabel.textColor = UIColor.black
            noDataLabel.textAlignment = .center
            groceryTableView.backgroundView = noDataLabel
            groceryTableView.separatorStyle = .none
        }
        return groceryList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = groceryTableView.dequeueReusableCell(withIdentifier: "groceryCell") as! GroceryItemsTableViewCell
        
        cell.selectionButton.addTarget(self, action: #selector(itemSelected(_:)), for: .touchUpInside)
        cell.selectionButton.tag = indexPath.row
        
        if let items = self.groceryList[indexPath.row] as? Groceries{
            cell.groceryItems.text = items.items
            if(items.isSelected){
                cell.selectionButton.setImage(UIImage(named: "filled.png"), for: .normal)
            }else{
                cell.selectionButton.setImage(UIImage(named: "notfilled.png"), for: .normal)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            if let items = self.groceryList[indexPath.row] as? Groceries{
                if(DataManager().deleteGroceriesWithListID(id: Int(items.id))){
                    self.groceryList.remove(at: indexPath.row)
                    groceryTableView.reloadData()
                }
            }
        }
    }
}
