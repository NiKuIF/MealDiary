//
//  CustomCell.swift
//  MealDiary
//
//  Created by admin on 20/08/16.
//  Copyright © 2016 Stefan Papst. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    
    
    @IBOutlet weak var name: UILabel!
    //@IBOutlet weak var images: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
