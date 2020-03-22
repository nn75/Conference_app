//
//  Session.swift
//  HFTP
//
//  Created by Zihui on 3/19/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import Foundation

class zSession: Codable{
    var date = "date"
    var startTime = "start"
    var endTime = "end"
    var name = "name"
    var description = "description"
    var category = "category"
    var code = "code"
    var credit : Int?
    var surveyLink = "link"
    var location = "location"
    init (_ date:String, startTime:String, endTime:String, name:String, description:String, category:String, code:String, credit:Int? = nil, surveyLink:String, location: String){
        self.date = date
        self.startTime = startTime
        self.endTime = endTime
        self.name = name
        self.description = description
        self.category = category
        self.code = code
        self.credit = credit ?? -1
        self.surveyLink = surveyLink
        self.location = location
    }
    init(){}
}
