//
//  DetailViewController.swift
//  Yelp
//
//  Created by Nguyen Chau Chieu on 6/26/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var business: Business?
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var ratingImageView: UIImageView!
    @IBOutlet var ratingCountLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var categoryLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = business?.name
        imageView.setImageWith((business?.imageURL)!)
        distanceLabel.text = "\(business!.distance!)les from here"
        ratingImageView.setImageWith((business?.ratingImageURL)!)
        ratingCountLabel.text = "\(String(describing: business!.reviewCount!))"
        addressLabel.text = business?.address
        categoryLabel.text = business?.categories
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

}
