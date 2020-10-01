//
//  RecipeTitleTableViewCell.swift
//  Recipes-App
//
//  Created by venkata kalyan pasupuleti on 9/4/20.
//  Copyright © 2020 quiz. All rights reserved.
//

import UIKit

class RecipeTitleTableViewCell: UITableViewCell {
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var btnMore: UIButton!
    @IBOutlet weak var receipeImageView: UIImageView!
    
    @IBOutlet weak var deleteOutlet: UIButton!
    @IBOutlet weak var addSteps: UIButton!
    @IBOutlet weak var viewSteps: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        receipeImageView.layer.masksToBounds = true
        receipeImageView.layer.cornerRadius = receipeImageView.frame.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
