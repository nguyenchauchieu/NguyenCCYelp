//
//  DropDownTableViewCell.swift
//  Yelp
//
//  Created by Nguyen Chau Chieu on 6/24/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit

class DropDownTableViewCell: UITableViewCell {
    
    @IBOutlet var dropDownLabel: UILabel!
    @IBOutlet var dropDownImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
