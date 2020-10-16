//
//  GroceryListViewController.swift
//  Recipes-App
//
//  Created by venkata kalyan pasupuleti on 10/13/20.
//  Copyright © 2020 quiz. All rights reserved.
//

import UIKit

class GroceryListViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var groceryTableView: UITableView!
    @IBOutlet weak var addGroceryItemsTextField: UITextField!
    @IBOutlet weak var addGroceryItem: UIButton!
    var groceryList = [Any]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groceryTableView.delegate = self
        addGroceryItemsTextField.delegate = self
        addGroceryItemsTextField.layer.cornerRadius = 25
        addGroceryItemsTextField.layer.borderWidth = 1
        addGroceryItemsTextField.layer.borderColor = UIColor(red: 233/255, green: 234/255, blue: 245/255, alpha: 1).cgColor
        addGroceryItem.layer.cornerRadius = 35/2
        addGroceryItem.layer.masksToBounds = true
        addGroceryItem.layer.shadowColor = UIColor.black.cgColor
        addGroceryItem.layer.shadowOpacity = 0.8
        addGroceryItem.layer.shadowRadius = 3.0
        addGroceryItem.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.title = "SHOPPING LIST"
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addGroceryItemsTextField.endEditing(true)
        addGroceryItemsTextField.text = ""
        return true
    }
    
    @IBAction func addItemTapped(_ sender: UIButton) {
        if addGroceryItemsTextField.text?.count != 0 {
            groceryList.append(addGroceryItemsTextField.text)
            groceryTableView.reloadData()
            addGroceryItemsTextField.text = nil
        }
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
