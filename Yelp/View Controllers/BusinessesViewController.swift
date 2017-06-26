//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Chau Vo on 10/17/16.
//  Copyright © 2016 CoderSchool. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController {
    
    var businesses: [Business]!
    @IBOutlet var businessTableView: UITableView!
    
    var filterSetting = BusinessSearchSetting()
    
    var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self
        
        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        businessTableView.delegate = self
        businessTableView.dataSource = self
        businessTableView.estimatedRowHeight = 100
        businessTableView.rowHeight = UITableViewAutomaticDimension
        
        doSearch(searchSettings: filterSetting)
        
    }
    
    func doSearch(searchSettings: BusinessSearchSetting) -> Void {
        Business.search(with: filterSetting.searchString!, sort: filterSetting.sort!, categories: filterSetting.categories!, radius: filterSetting.distance!, deals: filterSetting.deal!, completion: { (businesses: [Business]?, error: Error?) in
            if let businesses = businesses {
                self.businesses = businesses
                
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                    print(business.imageURL!)
                    print(business.ratingImageURL!)
                    self.businessTableView.reloadData()
                }
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let navigationController = segue.destination as! UINavigationController
//        let settingController = navigationController.viewControllers.first as! SettingsViewController
//        settingController.delegate = self
        let detailController = segue.destination as! DetailViewController
        let indexPath = businessTableView.indexPathForSelectedRow!
        detailController.business = businesses[indexPath.row]
    }
}

extension BusinessesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses != nil {
            return businesses.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = businessTableView.dequeueReusableCell(withIdentifier: "BusinessCell") as! BusinessTableViewCell
        
        cell.restaurantImageView.setImageWith(businesses[indexPath.row].imageURL!)
        cell.restaurantNameLabel.text = businesses[indexPath.row].name
        cell.distanceLabel.text = businesses[indexPath.row].distance
        cell.qualityImageView.setImageWith(businesses[indexPath.row].ratingImageURL!)
        cell.numberOfReviewLabel.text = "\(String(describing: businesses[indexPath.row].reviewCount!))"
        cell.addressLabel.text = businesses[indexPath.row].address
        cell.categoryLabel.text = businesses[indexPath.row].categories
        
        return cell
    }
    
}

extension BusinessesViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        filterSetting.searchString = searchBar.text
        doSearch(searchSettings: filterSetting)
        searchBar.resignFirstResponder()
    }
    
}

extension BusinessesViewController: SettingViewControllerDelegate {
    func applyFilter(filter: BusinessSearchSetting) {
        filterSetting = filter
        filterSetting.searchString = searchBar.text
        doSearch(searchSettings: filterSetting)
    }
}
