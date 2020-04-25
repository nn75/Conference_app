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
    var sessions : [Session] = []
    init(_ title:String, sessions: [Session]){
        self.title = title
        self.sessions = sessions
    }
    init(){}
}


var agendaList : [Agenda] = []

var myAgenda : [String] = []

var agendaIds : [String] = []
