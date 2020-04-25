//
//  RoundImageView.swift
//  HFTP
//
//  Created by Nan Ni on 3/24/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit


/**
 Custom round ImageView:
 set to round and set border
*/


class RoundBorderImageView: UIImageView {
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.height / 2
        self.layer.masksToBounds = true
    }
}
