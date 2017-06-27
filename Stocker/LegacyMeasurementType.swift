//
//  MeasurementType.swift
//  Stocker
//
//  Created by Samuel Moosmann on 24/06/2017.
//  Copyright © 2017 Samuel Moosmann. All rights reserved.
//

import Foundation
import UIKit

class LegacyMeasurementType {
    // FIXME: Change to generics, or any other more generic approach
    let unit: String
    let title: String
    let iconImage: UIImage
    
    init(unit: String, title: String, iconImage: UIImage) {
        self.unit = unit
        self.title = title
        self.iconImage = iconImage
        
    }
    
}
