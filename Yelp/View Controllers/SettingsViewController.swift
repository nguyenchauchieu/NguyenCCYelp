//
//  SettingsViewController.swift
//  Yelp
//
//  Created by Nguyen Chau Chieu on 6/24/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit

protocol SettingViewControllerDelegate {
    func applyFilter(filter: BusinessSearchSetting) -> Void
}

class SettingsViewController: UIViewController {
    
    @IBOutlet var settingsTableView: UITableView!
    
    var filterSettings = BusinessSearchSetting()
    
    var switchStates = [Int: Bool]()
    var dealOffer = false
    
    var isDistanceCollapse = true
    var isSortCollapse = true
    var currentDistanceIndex = 2
    var currentSortIndex = 0
    var isCategoryCollapse = false
    
    var delegate: SettingViewControllerDelegate!
    
    override func viewDidLoad() {
        filterSettings.resetFilterSetting()
        super.viewDidLoad()
        
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        
        settingsTableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "CellHeader")
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func onCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSearch(_ sender: Any) {
        filterSettings.resetFilterSetting()
        for (row, isSelected) in switchStates {
            if isSelected {
                filterSettings.categories?.append(Constants.CATEGORIES[row]["code"]!)
            }
        }
        delegate.applyFilter(filter: filterSettings)
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource, SwitchTableViewCellDelegate, DealOfferTableViewCellDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return Constants.DISTANCE.count
        case 2:
            return Constants.SORTS.count
        default:
            return Constants.CATEGORIES.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = settingsTableView.dequeueReusableCell(withIdentifier: "DealOfferCell") as! DealOfferTableViewCell
            cell.switchLabel.text = "Offering a Deal"
            cell.switchButton.isOn = dealOffer
            cell.delegate = self
            return cell
        case 1:
            let cell = settingsTableView.dequeueReusableCell(withIdentifier: "DropDownCell") as! DropDownTableViewCell
            
            if isDistanceCollapse {
                if indexPath.row == 0 {
                    cell.dropDownLabel.text = "\(String(describing: Constants.DISTANCE[currentDistanceIndex]["name"]!))"
                } else {
                    cell.dropDownLabel.text = "\(String(describing: Constants.DISTANCE[indexPath.row]["name"]!))"
                }
            } else {
                cell.dropDownLabel.text = "\(String(describing: Constants.DISTANCE[indexPath.row]["name"]!))"
            }
            cell.dropDownImageView.image = UIImage(named: "arrow_down_icon")
            return cell
        case 2:
            let cell = settingsTableView.dequeueReusableCell(withIdentifier: "DropDownCell") as! DropDownTableViewCell
            if isSortCollapse {
                if indexPath.row == 0 {
                    cell.dropDownLabel.text = "\(String(describing: Constants.SORTS[currentSortIndex]["name"]!))"
                } else {
                    cell.dropDownLabel.text = "\(String(describing: Constants.SORTS[indexPath.row]["name"]!))"
                }
            } else {
                cell.dropDownLabel.text = "\(String(describing: Constants.SORTS[indexPath.row]["name"]!))"
            }
            cell.dropDownImageView.image = UIImage(named: "arrow_down_icon")
            return cell
        default:
            let cell = settingsTableView.dequeueReusableCell(withIdentifier: "SwitchCell") as! SwitchTableViewCell
            let label = Constants.CATEGORIES[indexPath.row]["name"]!
            cell.switchLabel.text = "\(label)"
            cell.delegate = self
            cell.switchButton.isOn = switchStates[indexPath.row] ?? false
            return cell
        }
    }
    
    func updateSwitch(switchCell: SwitchTableViewCell, value: Bool) {
        let indexPath = settingsTableView.indexPath(for: switchCell)
        switchStates[(indexPath?.row)!] = value
    }
    
    func updateDealOfferSwitch(switchCell: DealOfferTableViewCell, value: Bool) {
        dealOffer = value
        filterSettings.deal = value
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            if isDistanceCollapse {
                isDistanceCollapse = false
                currentDistanceIndex = indexPath.row
                let distance = Double(Constants.DISTANCE[indexPath.row]["value"]!)
                filterSettings.distance = Int(distance! * Constants.DISTANCE_TO_METER_RATIO)
                reloadSection(indexPath: indexPath)
            } else {
                isDistanceCollapse = true
                currentDistanceIndex = indexPath.row
                let distance = Double(Constants.DISTANCE[indexPath.row]["value"]!)
                filterSettings.distance = Int(distance! * Constants.DISTANCE_TO_METER_RATIO)
                reloadSection(indexPath: indexPath)
            }
        case 2:
            if isSortCollapse {
                isSortCollapse = false
                currentSortIndex = indexPath.row
                filterSettings.sort = Int(Constants.SORTS[indexPath.row]["value"]!)
                reloadSection(indexPath: indexPath)
            } else {
                isSortCollapse = true
                currentSortIndex = indexPath.row
                filterSettings.sort = Int(Constants.SORTS[indexPath.row]["value"]!)
                reloadSection(indexPath: indexPath)
            }
        case 3: break
        default: break
        }
    }
    
    func reloadSection(indexPath: IndexPath) -> Void {
        let sectionIndex = IndexSet(integer: indexPath.section)
        settingsTableView.reloadSections(sectionIndex, with: .none)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = settingsTableView.dequeueReusableHeaderFooterView(withIdentifier: "CellHeader")!
        header.textLabel?.text = Constants.SECTION_HEADER_LABEL[section]
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat?
                switch indexPath.section {
                case 0:
                    height = 44
                case 1:
                    if isDistanceCollapse && indexPath.row == 0{
                        height = 44
                    }
                    if isDistanceCollapse && indexPath.row > 0 {
                        height = 0
                    }
                    if !isDistanceCollapse {
                        height = 44
                    }
                case 2:
                    if isSortCollapse && indexPath.row == 0{
                        height = 44
                    }
                    if isSortCollapse && indexPath.row > 0 {
                        height = 0
                    }
                    if !isSortCollapse {
                        height = 44
                    }
                default:
                    if isCategoryCollapse && indexPath.row <= 2 {
                        height = 44
                    }
                    if isCategoryCollapse && indexPath.row > 2 {
                        height = 0
                    }
                    if !isCategoryCollapse {
                        height = 44
                    }
                }
                return height ?? 0
//        return 44
    }
}
