//
//  SliderViewCell.swift
//  Yelp
//
//  Created by Viet Dang Ba on 2/26/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit


protocol SliderViewCellDelegate {
    func sliderViewCell(sliderViewCell: SliderViewCell, didChangeValue value:Float)
}
class SliderViewCell: UITableViewCell {

    var delegate:SliderViewCellDelegate!
    
    @IBOutlet weak var outlineView: UIView!
    @IBOutlet weak var filterLabel: UILabel!
    
    @IBOutlet weak var distanceSlider: UISlider!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        outlineView.layer.borderWidth = 1
        outlineView.layer.borderColor = UIColor.lightGray.cgColor
        
        if(distanceSlider.value < 0.1){
            distanceLabel.text = "Any"
        } else {
            distanceLabel.text =  String(format: "%.2f miles", distanceSlider.value)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onDistanceChange(_ sender: UISlider) {
        if(sender.value < 0.1){
             distanceLabel.text = "Any"
        } else {
            distanceLabel.text =  String(format: "%.2f miles", sender.value)
        }
        delegate.sliderViewCell(sliderViewCell: self, didChangeValue: sender.value)
        
    }
}
