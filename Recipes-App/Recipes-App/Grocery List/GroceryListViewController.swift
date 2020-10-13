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
    @IBOutlet weak var addGroceryItem: UIButton!
    var groceryList = [Any]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groceryTableView.delegate = self
        addGroceryItem.layer.cornerRadius = 30
    }
    
    @IBAction func addItemTapped(_ sender: UIButton) {
        groceryList.append(addGroceryItemsTextField.text)
        groceryTableView.reloadData()
        addGroceryItemsTextField.text = nil
    }
    
    @IBAction func itemSelected(_ sender: UIButton) {
        //var selected = sender.currentImage
       // print(selected)
        if sender.currentImage == UIImage(named: "notfilled.png") {
            sender.setImage(UIImage(named: "filled.png"), for: .normal)
        } else {
            sender.setImage(UIImage(named: "notfilled.png"), for: .normal)
        }
    }
}

extension GroceryListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceryList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = groceryTableView.dequeueReusableCell(withIdentifier: "groceryCell") as! GroceryItemsTableViewCell
        cell.groceryItems.text = groceryList[indexPath.row] as! String
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.groceryList.remove(at: indexPath.row)
            groceryTableView.reloadData()
        }
    }
}
