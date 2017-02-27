//
//  PlainViewCell.swift
//  Yelp
//
//  Created by Viet Dang Ba on 2/26/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit

class PlainViewCell: UITableViewCell {

    @IBOutlet weak var outlineView: UIView!
    @IBOutlet weak var filterLabel: UILabel!
    
    
    @IBOutlet weak var iconImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        outlineView.layer.borderWidth = 1
        outlineView.layer.borderColor = UIColor.lightGray.cgColor
        
        
        //self.iconImage.image = nil

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
