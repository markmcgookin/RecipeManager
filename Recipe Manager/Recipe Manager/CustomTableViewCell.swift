//
//  CustomTableViewCell.swift
//  Recipe Manager
//
//  Created by Mark McGookin on 24/05/2015.
//  Copyright (c) 2015 Mark McGookin. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    var CellRecipe:Recipe?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
