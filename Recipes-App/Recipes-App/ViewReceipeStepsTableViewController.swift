//
//  ViewReceipeStepsTableViewController.swift
//  Recipes-App
//
//  Created by venkata kalyan pasupuleti on 9/15/20.
//  Copyright © 2020 quiz. All rights reserved.
//

import UIKit

class ViewReceipeStepsTableViewController: UITableViewController {
    @IBOutlet var AllStepsVCTbl: UITableView!
    var allSteps = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func getSteps(array: [String]) {
        self.allSteps = array
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allSteps.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllCell")
        cell?.textLabel?.text = allSteps[indexPath.row]
        return cell!
    }
}
