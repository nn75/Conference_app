//
//  Extensions.swift
//  HFTP
//
//  Created by Nan Ni on 3/16/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit


extension UIView {
    public func addShadow(cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.9
    }
}

extension UIImageView {
    public func round() {
        self.layer.cornerRadius = self.bounds.width / 2
        self.clipsToBounds = true
    }
}

