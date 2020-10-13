//
//  GroceryListViewController.swift
//  Recipes-App
//
//  Created by venkata kalyan pasupuleti on 10/13/20.
//  Copyright © 2020 quiz. All rights reserved.
//

import UIKit

class GroceryListViewController: UIViewController {
    @IBOutlet weak var groceryTableView: UITableView!
    @IBOutlet weak var addGroceryItemsTextField: UITextField!
    var groceryList = [Any]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGroceryItemsTextField.layer.cornerRadius = 100
        addGroceryItemsTextField.layer.borderColor = UIColor.red.cgColor
    }
    
    @IBAction func addItemTapped(_ sender: UIButton) {
        groceryList.append(addGroceryItemsTextField.text)
        groceryTableView.reloadData()
        addGroceryItemsTextField.text = nil
    }
    
    @IBAction func itemSelected(_ sender: UIButton) {
        var selected = UIColor.systemBlue
        print(selected)
        if sender.currentTitleColor == selected {
            sender.setTitleColor(UIColor.systemRed, for: .normal)
           // sender.currentTitleColor = UIColor.red
        } else {
            sender.setTitleColor(UIColor.systemBlue, for: .normal)
            //sender.currentTitleColor = UIColor.systemBlue
        }
        //groceryTableView.reloadData()
    }
    
}

extension GroceryListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = groceryTableView.dequeueReusableCell(withIdentifier: "groceryCell") as! GroceryItemsTableViewCell
        cell.groceryItems.text = groceryList[indexPath.row] as! String
        return cell
    }
    
    
}
