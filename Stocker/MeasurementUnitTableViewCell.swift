//
//  MeasurementUnitTableViewCell.swift
//  Stocker
//
//  Created by Samuel Moosmann on 23/06/2017.
//  Copyright © 2017 Samuel Moosmann. All rights reserved.
//

import UIKit

class MeasurementUnitTableViewCell: UITableViewCell {

    var measurementType: MeasurementType?
    @IBOutlet weak var measurementTypeImageView: UIImageView!
    @IBOutlet weak var measurementTypeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
