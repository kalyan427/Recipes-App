//
//  ViewController.swift
//  Recipes-App
//
//  Created by venkata kalyan pasupuleti on 8/25/20.
//  Copyright © 2020 quiz. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var addTitle: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var adView: GADBannerView!
    var filteredReceipe = [Any]()
    var tempArray = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLatestData()
        self.title = "Recipes"
        self.titleTextField.delegate = self
     
        titleTextField.layer.cornerRadius = 20
        titleTextField.layer.borderWidth = 1
        titleTextField.layer.borderColor = UIColor(red: 233/255, green: 234/255, blue: 245/255, alpha: 1).cgColor
        adView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        adView.rootViewController = self
        adView.load(GADRequest())
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
        let alert = UIAlertController(title: "Select Option", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Add Steps", style: .default, handler: { (UIAlertAction) in
            self.addSteps(tag: clickedCell)
        }))
        
        alert.addAction(UIAlertAction(title: "View Steps", style: .default, handler: { (UIAlertAction) in
            //self.deletebuttonClicked(tag: clickedCell)
            self.viewReceipeSteps(tag: clickedCell)
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler: { (UIAlertAction) in
            
        }))
        
        if let popoverController = alert.popoverPresentationController {
            popoverController.barButtonItem = sender as? UIBarButtonItem
        }
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    // MARK: Custom Items
    
    func deleteItemInArray(arrayValue: Int) {
        if let selecttedItem = self.filteredReceipe[arrayValue] as? Receipe{
            DataManager().deleteItem(id: Int(selecttedItem.id))
            filteredReceipe.remove(at: arrayValue)
            tableView.reloadData()
        }
    }
    
    @objc func addSteps(tag: Int) {
        let receipeSteps = self.storyboard?.instantiateViewController(withIdentifier: "recipesStepsVC") as! RecipesStepsViewController
                   receipeSteps.getRecipe(item: self.filteredReceipe[tag] as! Receipe)
                   self.navigationController?.pushViewController(receipeSteps, animated: true)
        
    }
    
    @objc func deletebuttonClicked(tag: Int) {
        self.deleteItemInArray(arrayValue: tag)
    }
    
    @objc func viewReceipeSteps(tag: Int) {
        if #available(iOS 13.0, *) {
            let receipsView = self.storyboard?.instantiateViewController(identifier: "viewStepsVC") as! viewReceipeStepsViewController
            receipsView.getRecipe(item: self.filteredReceipe[tag] as! Receipe)
            self.navigationController?.pushViewController(receipsView, animated: true)
        } else {
            let receipsView = self.storyboard?.instantiateViewController(withIdentifier: "viewStepsVC") as! viewReceipeStepsViewController
            receipsView.getRecipe(item: self.filteredReceipe[tag] as! Receipe)
            self.navigationController?.pushViewController(receipsView, animated: true)
        }
        
    }
    
    func filter(searchText: String) {
        self.filteredReceipe = self.tempArray.filter { (dict) -> Bool in
            let dict1 :Receipe = dict as! Receipe;
            let string = dict1.title
            return string!.lowercased().contains(searchText.lowercased())
            
        }
        tableView.reloadData()
    }
    
}

// MARK: - TableView delegate

extension ViewController: UITableViewDataSource,UITableViewDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        titleTextField.text = ""
    }
    
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
        if #available(iOS 13.0, *) {
            let receipsView = self.storyboard?.instantiateViewController(identifier: "viewStepsVC") as! viewReceipeStepsViewController
            receipsView.getRecipe(item: self.filteredReceipe[indexPath.row] as! Receipe)
            self.navigationController?.pushViewController(receipsView, animated: true)
        } else {
            let receipsView = self.storyboard?.instantiateViewController(withIdentifier: "viewStepsVC") as! viewReceipeStepsViewController
            receipsView.getRecipe(item: self.filteredReceipe[indexPath.row] as! Receipe)
            self.navigationController?.pushViewController(receipsView, animated: true)
        }
        
    }
    
    func getLatestData() {
        self.filteredReceipe = DataManager().getAllReceipes()
        self.tempArray = self.filteredReceipe
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Warning", message: "You are deleting Title of Receipe", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive, handler: { (action) in
                self.deletebuttonClicked(tag: indexPath.row)
                
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { (action) in
                
            }))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
}


// MARK: - Search bar delegate
extension ViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchBar.text?.count == 0){
            self.filteredReceipe = self.tempArray
            tableView.reloadData()
        }else{
            self.filter(searchText: searchBar.text!)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        searchBar.endEditing(true)
        getLatestData()
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}


