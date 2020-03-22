//
//  Agenda.swift
//  HFTP
//
//  Created by Zihui on 3/19/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import Foundation

class Agenda{
    var title = "title"
    var sessions : [zSession] = []
    init(_ title:String, sessions: [zSession]){
        self.title = title
        self.sessions = sessions
    }
    init(){}
}

var session11 : zSession = zSession()
var session12 : zSession = zSession("2020-2-2", startTime:"00:00", endTime:"12:30", name:"Mobile APP", description:"Duke Course: ECE564", category:"Tech", code:"", credit:0, surveyLink:"www.google.com", location:"Hudson")

var session21 : zSession = zSession()
var session22 : zSession = zSession("2020-2-4", startTime:"01:00", endTime:"11:30", name:"Software Engineering", description:"Duke Course: ECE651", category:"Tech", code:"", credit:0, surveyLink:"www.google.com", location:"Hudson")


var agenda1 : Agenda = Agenda("day1", sessions: [session11, session12])
var agenda2 : Agenda = Agenda("day2", sessions: [session21, session22])

var agendaList : [Agenda] = [agenda1, agenda2]

var myAgenda : [zSession] = []
