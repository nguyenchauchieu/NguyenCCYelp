//
//  BusinessSearchSettings.swift
//  Yelp
//
//  Created by Nguyen Chau Chieu on 6/23/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import Foundation

class BusinessSearchSetting {
    var searchString: String?
    var sort: Int?
    var distance: Int?
    var categories: [String]?
    var deal: Bool?
    
    init() {
        self.searchString = ""
        self.sort = 0
        self.distance = 0
        self.deal = false
        self.categories = []
    }
    
    func resetFilterSetting() -> Void {
        self.searchString = ""
        self.sort = 0
        self.distance = 0
        self.deal = false
        self.categories = []
    }
}
