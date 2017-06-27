//
//  StockTableImageView.swift
//  Stocker
//
//  Created by Samuel Moosmann on 27/06/2017.
//  Copyright © 2017 Samuel Moosmann. All rights reserved.
//

import UIKit

class StockTableImageView: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */


   
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5
        layer.masksToBounds = true
    }
    
}
