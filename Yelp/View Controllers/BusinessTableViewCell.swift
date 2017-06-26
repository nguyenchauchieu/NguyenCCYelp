//
//  BusinessTableViewCell.swift
//  Yelp
//
//  Created by Nguyen Chau Chieu on 6/21/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit

class BusinessTableViewCell: UITableViewCell {
    
    @IBOutlet var restaurantImageView: UIImageView!
    @IBOutlet var restaurantNameLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var qualityImageView: UIImageView!
    @IBOutlet var numberOfReviewLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var categoryLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
