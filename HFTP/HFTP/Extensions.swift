//
//  Extensions.swift
//  HFTP
//
//  Created by Nan Ni on 3/16/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit
import DateToolsSwift

extension Date {
    public func setDate(_ dateString:String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter.date(from: dateString)
    }
}


extension TimeChunk {
    static func dateComponents(seconds: Int = 0,
                               minutes: Int = 0,
                               hours: Int = 0,
                               days: Int = 0,
                               weeks: Int = 0,
                               months: Int = 0,
                               years: Int = 0) -> TimeChunk {
        return TimeChunk(seconds: seconds,
                         minutes: minutes,
                         hours: hours,
                         days: days,
                         weeks: weeks,
                         months: months,
                         years: years)
    }
    
}


extension UIViewController {
    func popupAlert(title: String?, message: String?, actionTitles:[String?], actions:[((UIAlertAction) -> Void)?]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, title) in actionTitles.enumerated() {
            let action = UIAlertAction(title: title, style: .default, handler: actions[index])
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: nil)
    }
}

extension UISearchBar {
    func setAgendaSearchBarStyle() {
        self.tintColor = UIColor(named: K.colors.hftpDarkBlue)
        self.sizeToFit()
        self.placeholder = K.texts.searchAgenda
        self.barTintColor = UIColor.systemGroupedBackground
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemGroupedBackground.cgColor
    }
    
    func setPeopleSearchBarStyle() {
        self.tintColor = UIColor.white
        self.sizeToFit()
        self.barTintColor = UIColor.white
        self.layer.borderWidth = 0
        
        if let textField = self.value(forKey: "searchField") as? UITextField,
            let iconView = textField.leftView as? UIImageView {

            textField.backgroundColor = UIColor.white
            textField.textColor = UIColor(named: K.colors.hftpDarkBlue)
            
            iconView.image = iconView.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            iconView.tintColor = UIColor(named: K.colors.hftpDarkBlue)
        }
    }
}

extension Dictionary where Value: Equatable {
    func allKeys(forValue val: Value) -> [Key] {
        return self.filter { $1 == val }.map { $0.0 }
    }
}

extension Session {
    static func == (lhs: Session, rhs: Session) -> Bool {
        return lhs.name == rhs.name
    }
}

