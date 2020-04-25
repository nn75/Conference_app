//
//  Session.swift
//  HFTP
//
//  Created by Zihui on 3/19/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import Foundation

class Session: Codable,Equatable{
    var date = "date"
    var startTime = "start"
    var endTime = "end"
    var name = "name"
    var description = "description"
    var category = "category"
    var code = "code"
    var credit : Double = 0.0
    var surveyLink = "link"
    var location = "location"
    var attendee : [String] = []
    var speaker : [String] = []
    
    init (d date:String, s startTime:String, e endTime:String, n name:String, d description:String, c category:String, co code:String, cr credit:Double, su surveyLink:String, l location: String, spe speaker: [String]){
        self.date = date
        self.startTime = startTime
        self.endTime = endTime
        self.name = name
        self.description = description
        self.category = category
        self.code = code
        self.credit = credit
        self.surveyLink = surveyLink
        self.location = location
        self.speaker = speaker
    }
    
    init(n name: String, co code: String, cr credit: Double) {
        self.name = name
        self.code = code
        self.credit = credit
    }
    
    init(){}
}
