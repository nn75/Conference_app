//
//  HelperFunctions.swift
//  HFTP
//
//  Created by ny38 on 3/28/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//


import Foundation
import UIKit

class H {
    
    static func getCreditSum() -> String {
        var sum = 0.0
        for credit in creditList {
            sum += Double(credit.credit)
        }
        return (String(sum))
    }
    
    // MARK: SOCIAL MEDIA LINKS
    static func linkedinAction(username:String) {  // instgram
        let appURL = URL(string: "linkedin://profile/\(username)")
        let webURL = URL(string: "https://linkedin.com/in/\(username)")
        callApplication(a:appURL ?? URL(string: "linkedin://profile/none")!, w:webURL ?? URL(string: "https://linkedin.com/in/none")!)
    }
    
    static func instgramAction(username:String) {  // instgram
        let appURL = URL(string: "instagram://user?username=\(username)")
        let webURL = URL(string: "https://instagram.com/\(username)")
        callApplication(a:appURL ?? URL(string: "instagram://user?username=none")!, w:webURL ?? URL(string: "https://instagram.com/none")!)
    }
    
    static func facebookAction(username:String) {  // facebook
        let appURL = URL(string: "fb://profile/\(username)")
        let webURL = URL(string: "https://facebook.com/\(username)")
        self.callApplication(a:appURL ?? URL(string: "fb://profile/none")! , w:webURL ?? URL(string: "https://facebook.com/none")!)
    }
    
    static func callApplication(a appURL:URL, w webURL: URL) {
        let application = UIApplication.shared
        if application.canOpenURL(appURL) {
            application.open(appURL)
        } else {
            // if the app is not installed, open URL inside Safari
            application.open(webURL)
        }
    }
}
