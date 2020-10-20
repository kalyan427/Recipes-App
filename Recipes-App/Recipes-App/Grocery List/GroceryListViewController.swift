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
            groceryList.append(addGroceryItemsTextField.text)
            groceryTableView.reloadData()
            addGroceryItemsTextField.text = nil
        }
    }
    
    @IBAction func itemSelected(_ sender: UIButton) {
        if sender.currentImage == UIImage(named: "notfilled.png") {
            sender.setImage(UIImage(named: "filled.png"), for: .normal)
        } else {
            sender.setImage(UIImage(named: "notfilled.png"), for: .normal)
        }
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
