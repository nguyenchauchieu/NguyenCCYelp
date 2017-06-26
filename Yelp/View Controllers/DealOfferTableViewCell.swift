//
//  DealOfferTableViewCell.swift
//  Yelp
//
//  Created by Nguyen Chau Chieu on 6/25/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit

protocol DealOfferTableViewCellDelegate {
    func updateDealOfferSwitch(switchCell: DealOfferTableViewCell, value: Bool) -> Void
}
class DealOfferTableViewCell: UITableViewCell {
    
    @IBOutlet var switchLabel: UILabel!
    @IBOutlet var switchButton: UISwitch!
    
    var delegate: DealOfferTableViewCellDelegate!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onSwitch(_ sender: UISwitch) {
        delegate.updateDealOfferSwitch(switchCell: self, value: sender.isOn)
    }

}
