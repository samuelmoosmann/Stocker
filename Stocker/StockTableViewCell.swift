//
//  StockTableViewCell.swift
//  Stocker
//
//  Created by Samuel Moosmann on 21/06/2017.
//  Copyright © 2017 Samuel Moosmann. All rights reserved.
//

import UIKit

class StockTableViewCell: UITableViewCell {

    @IBOutlet weak var itemNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
