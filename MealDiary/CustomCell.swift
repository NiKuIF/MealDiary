//
//  CustomCell.swift
//  MealDiary
//
//  Created by admin on 11/09/16.
//  Copyright © 2016 Stefan Papst. All rights reserved.
//

import Foundation
import UIKit

class CustomCell : UITableViewCell{
    
    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var rating: UIProgressView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}