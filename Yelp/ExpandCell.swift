//
//  ExpandCell.swift
//  Yelp
//
//  Created by Viet Dang Ba on 2/27/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit

class ExpandCell: UITableViewCell {

    @IBOutlet weak var outlineView: UIView!
    @IBOutlet weak var expandLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        outlineView.layer.borderWidth = 1
        outlineView.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
