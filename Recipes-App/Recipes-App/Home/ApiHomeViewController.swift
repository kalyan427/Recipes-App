//
//  ApiHomeViewController.swift
//  Recipes-App
//
//  Created by kalyan  on 12/21/20.
//  Copyright © 2020 quiz. All rights reserved.
//

import UIKit

class ApiHomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var networkCall = NetworkApiCall() //self
    var recipeTitles: Array<Dictionary<String, Any>> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        networkCall.delegate = self
        callRecipeUrl(networkUrl: "https://valetplz-api.uc.r.appspot.com/_ah/api/valetPlz/v1/getContentManagementDataAll")
    }
    
    func callRecipeUrl(networkUrl: String) {
        networkCall.callAPI(urlString: networkUrl)
    }
}

//MARK: - TableView Functions.

extension ApiHomeViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "APIHome") as! ApiHomeTableViewCell
        if let recipeName = recipeTitles[indexPath.row]["name"] as? String {
            cell.titleRecipeLabel.text = recipeName
        }
        return cell
    }
}

//MARK: - ApiCalling Delegate

extension ApiHomeViewController: apiCallingDelegate {
    func receivedData(data Content: Data) {
        let jsonData = try? JSONSerialization.jsonObject(with: Content, options: .mutableLeaves)
        guard let recipeData = jsonData as? Dictionary<String, Any> else { return }
        print(recipeData)
        guard let recipeItems = recipeData["data"] as? Array<Dictionary<String,Any>> else { return }
        recipeTitles = recipeItems
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}



