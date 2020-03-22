//
//  MockData.swift
//  HFTP
//
//  Created by ny38 on 3/17/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import Foundation

var speakerList : [Speaker] = []
var attendeeList : [Attendee] = []
var creditList: [Session] = []

var speakerOne: Speaker = Speaker(f:"Jack",l:"Jones")
var speakerTwo: Speaker = Speaker(f: "Miranda", l: "West")

var attendeeOne: Attendee = Attendee(f: "A", l: "A")
var attendeeTwo: Attendee = Attendee(f: "B", l: "B")


var sessionOne: Session = Session(n: "HFTP GLOBAL UPDATE", co: "MSAR01", cr: 1.2)
var sessionTwo: Session = Session(n: "WHAT IS A CONTROLLER", co: "MSAR02", cr: 1.2)

func loadMockData() {
    
    speakerList = []
    attendeeList = []
    creditList = []
    
    speakerList.append(speakerOne)
    speakerList.append(speakerTwo)
    
    attendeeList.append(attendeeOne)
    attendeeList.append(attendeeTwo)
    
    creditList.append(sessionOne)
    creditList.append(sessionTwo)
    
    //fetchDatafrom Firebase
    fetchCollectionData("speakers")
}

