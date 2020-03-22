//
//  Session.swift
//  HFTP
//
//  Created by Nan Ni on 3/19/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import Foundation


class Session {
    var name: String = ""
    var code:String = ""
    var credit: Double = 0.0

    init(n name: String, co code: String, cr credit: Double) {
        self.name = name
        self.code = code
        self.credit = credit
    }
    
    init() {}
}
