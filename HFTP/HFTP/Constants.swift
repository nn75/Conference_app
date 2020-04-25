//
//  Constants.swift
//  HFTP
//
//  Created by ny38 on 3/17/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import Foundation


struct K {
    // Texts
    struct texts{
        static var searchSpeaker = "Search for speakers"
        static var searchAttendee = "Search for attendees"
        static var searchAgenda = "Search"
    }
    
    // Identifiers
    struct identifiers{
        static var speakerTVCSegue = "SpeakerTVCSegue"
        static var attendeeTVCSegue = "AttendeeTVCSegue"
        static var agendaTVCSegue = "AgendaTVCSegue"
        static var sessionTVCSegue = "SessionTVCSegue"
        static var sessionInfoSegue = "SessionInfoSegue"
        static var menuSegue = "MenuSegue"
        static var speakerInfoSegue = "SpeakerInfoSegue"
        static var attendeeInfoSegue = "AttendeeInfoSegue"
        static var unwindFromUserOneSegue = "unwindFromUserOneSegue"
        static var unwindFromUserTwoSegue = "unwindFromUserTwoSegue"
        static var cellID = "cellIdentifier"
        
        static var changeNameSegue = "changeNameSegue"
        static var changeCompanySegue = "changeCompanySegue"
        static var changeJobSegue = "changeJobSegue"
        static var changePhoneSegue = "changePhoneSegue"
        static var changeEmailSegue = "changeEmailSegue"
        static var changeLinkedInSegue = "changeLinkedInSegue"
        static var changeFacebookSegue = "changeFacebookSegue"
        static var changeInstagramSegue = "changeInstagramSegue"
        static var showMemberIDSegue = "showMemberIDSegue"
        static var settingsSegue="settingsSegue"
        static var creditsSegue = "creditsSegue"
        static var showSessionSpeaker = "showSessionSpeaker"
        static var showSessionAttendee = "showSessionAttendee"
        static var showSessionAttendeeDetail = "showSessionAttendeeDetail"
        static var showMySessionInfo = "showMySessionInfo"
        static var showCalendarDetail = "showCalendarDetail"
        static var showMyCalendarDetail = "showMyCalendarDetail"
        static var calendarSessionTVCSegue = "calendarSessionTVCSegue"
        static var unwindeLoggedInSegue = "unwindeLoggedInSegue"
    }
    
    // Titles
    struct titles{
        static var speakerTVTitle = "Speakers"
        static var attendeeTVTitle = "Attendees"
        static var agendaTitle = "Agenda"
        static var name="Name"
        static var email="Email"
        static var jobTitle="Job Title"
        static var company="Company"
        static var phoneNumber = "Phone Number"
        static var linkedIn = "LinkedIn"
        static var facebook = "Facebook"
        static var instagram = "Instagram"
        static var memberID = "Member ID"
        static var introTitle = "Introduction"
        static var btnShowCalendar = "Show Calendar"
        static var btnShowTable = "Show Table"
        static var btnAddCalendar = "Add to Calendar"
        static var btnRemoveCalendar = "Remove From Calendar"
    }
    
    // Colors
    struct colors {
        static var hftpDarkBlue = "HftpDarkBlue"
    }
    
    // Cell Name
    struct cellName {
        //TableView Cell
        static var agendaTableViewCell = "AgendaTableViewCell"
        static var peopleTableViewCell = "PeopleTableViewCell"
        static var creditTableViewCell = "CreditTableViewCell"
        static var sessionTableViewCell = "SessionTableViewCell"
        
        //CollectionView Cell
        static var sessionInfoCollectionViewCell = "SessionInfoCollectionViewCell"
    }
    
    //Image Name
    struct imageName {
        static var tableBackground = "TableBackground"
        static var defaultPhoto = "DefaultPhoto"
    }

}


