//
//  MockData.swift
//  HFTP
//
//  Created by ny38 on 3/17/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import Foundation

var peopleList: [People] = []
var speakerList : [Speaker] = []
var attendeeList : [Attendee] = []
var creditList: [Session] = []
var sessionDic: [String: Session] = [:]
var sessionAttendeeDic: [String: [String]] = [:]
var speakersDic: [String: Speaker] = [:]
var usersDic: [String: Attendee] = [:]
var agendaDic: [String: [String]] = [:]

var sessionOne: Session = Session(n: "HFTP GLOBAL UPDATE", co: "MSAR01", cr: 1.2)
var sessionTwo: Session = Session(n: "WHAT IS A CONTROLLER", co: "MSAR02", cr: 1.2)

var globalUsrId = "1"
var globalIsLoggedIn = false

func loadData() {
    speakerList = Array(speakersDic.values)
    fetchData.getListofAllAttendees()
    creditList.append(sessionOne)
    creditList.append(sessionTwo)
    agendaIds = Array(agendaDic.keys).sorted(by: <)
    
    if globalIsLoggedIn{
        myAgenda = usersDic[globalUsrId]!.sessions
    }
    
    let sessionIds = Array(sessionDic.keys).sorted(by: <)
    
    for id in sessionIds{
        sessionDic[id]!.attendee = sessionAttendeeDic[id]!
    }
}


