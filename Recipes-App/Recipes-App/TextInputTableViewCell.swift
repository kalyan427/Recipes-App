//
//  TextInputTableViewCell.swift
//  Recipes-App
//
//  Created by venkata kalyan pasupuleti on 8/25/20.
//  Copyright © 2020 quiz. All rights reserved.
//

import UIKit

class TextInputTableViewCell: UITableViewCell {

    @IBOutlet weak var cellTextField: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
