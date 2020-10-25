//
//  GroceryItemsTableViewCell.swift
//  Recipes-App
//
//  Created by venkata kalyan pasupuleti on 10/13/20.
//  Copyright © 2020 quiz. All rights reserved.
//

import UIKit

class GroceryItemsTableViewCell: UITableViewCell {
    @IBOutlet weak var groceryItems: UILabel!
    @IBOutlet weak var selectionButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
