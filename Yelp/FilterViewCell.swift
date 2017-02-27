//
//  FilterViewCell.swift
//  Yelp
//
//  Created by Viet Dang Ba on 2/23/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit

protocol FilterViewCellDelegate {
    func filterViewCell(filterViewCell : FilterViewCell, didChangeValue value:Bool)
}

class FilterViewCell: UITableViewCell {

    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var filterSwitch: UISwitch!
    
    @IBOutlet weak var outlineView: UIView!
    
    var delegate:FilterViewCellDelegate!
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

    @IBAction func onSwitch(_ sender: UISwitch) {
        print("is On \(sender.isOn)")
        delegate.filterViewCell(filterViewCell: self, didChangeValue: sender.isOn)
    }
}
