//
//  DisguisedTextField.swift
//  Stocker
//
//  Created by Samuel Moosmann on 27/06/2017.
//  Copyright © 2017 Samuel Moosmann. All rights reserved.
//

import UIKit

class DisguisedTextField: UITextField {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    private var isEditable: Bool = false
    var editable: Bool {
        get {
            return self.isEditable
        }
        set(editable) {
            if editable {
                isEditable = true
                borderStyle = .roundedRect
                isUserInteractionEnabled = true
            }
            else {
                isEditable = false
                borderStyle = .none
                isUserInteractionEnabled = false
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        editable = false
    }
    
    

}
