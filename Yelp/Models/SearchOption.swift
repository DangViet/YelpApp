//
//  SearchOption.swift
//  Yelp
//
//  Created by Viet Dang Ba on 2/26/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit

class SearchOption: NSObject {
    var sort: YelpSortMode?
    var offset: Int?
    var categories: [String]!
    var distance: Float?
    var deals: Bool?
    
    override init(){
        categories = [String]()
    }
}
