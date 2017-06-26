//
//  SwitchTableViewCell.swift
//  Yelp
//
//  Created by Nguyen Chau Chieu on 6/24/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit

protocol SwitchTableViewCellDelegate {
    func updateSwitch(switchCell: SwitchTableViewCell, value: Bool) -> Void
}
class SwitchTableViewCell: UITableViewCell {
    
    @IBOutlet var switchLabel: UILabel!
    @IBOutlet var switchButton: UISwitch!
    
    var delegate: SwitchTableViewCellDelegate!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func onSwitch(_ sender: UISwitch) {
        delegate.updateSwitch(switchCell: self, value: sender.isOn)
    }

}
