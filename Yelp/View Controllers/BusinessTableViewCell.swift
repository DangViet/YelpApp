//
//  BusinessTableViewCell.swift
//  Yelp
//
//  Created by Viet Dang Ba on 2/22/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit
import AFNetworking

class BusinessTableViewCell: UITableViewCell {

    @IBOutlet weak var businessImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var reviewImage: UIImageView!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    
    var business:Business!{
        didSet {
    
            nameLabel.text = business.name
            distanceLabel.text = business.distance
            reviewLabel.text = (business.reviewCount?.stringValue)! + " reviews"
            addressLabel.text = business.address
            categoriesLabel.text = business.categories
            
            businessImage.image = nil
            if(business.imageURL != nil){
                businessImage.setImageWith(business.imageURL!)
            }
            reviewImage.image = nil
            reviewImage.setImageWith(business.ratingImageURL!)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
