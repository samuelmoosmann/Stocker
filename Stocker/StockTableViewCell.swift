//
//  StockTableViewCell.swift
//  Stocker
//
//  Created by Samuel Moosmann on 21/06/2017.
//  Copyright © 2017 Samuel Moosmann. All rights reserved.
//

import UIKit

class StockTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var measurementTypeIcon: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var infoIcon: UIImageView!
    
    var item: Item?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fill(with item: Item){
        self.item = item
        itemNameLabel.text = item.name
        measurementTypeIcon.image = UIImage(data: Data(referencing: (item.measurementType?.icon)!))
        if let itemImage = item.image {
            itemImageView.image = UIImage(data: Data(referencing: itemImage))
        }
        else {
            itemImageView.image = UIImage(named: "ItemImagePlaceholder")
        }
        if let stockValue = item.stock?.value {
            stockLabel.text = "\(stockValue)"
        }
        else {
            infoLabel.isHidden = false
            infoIcon.isHidden = false
            infoLabel.text = NSLocalizedString("Stock empty", comment: "")
        }
    }

}
