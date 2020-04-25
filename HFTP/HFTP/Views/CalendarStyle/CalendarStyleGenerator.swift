//
//  CalendarStyleGenerator.swift
//  HFTP
//
//  Created by Nan Ni on 4/8/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import CalendarKit
import UIKit

/**
 Set the style of calendar
 */

struct StyleGenerator {
  static func defaultStyle() -> CalendarStyle {
    let black = UIColor.white
    let darkGray = UIColor(white: 0.15, alpha: 1)
    let lightGray = UIColor.lightGray
    let white = UIColor.gray

    var selector = DaySelectorStyle()
    selector.activeTextColor = black
    selector.inactiveTextColor = white
    selector.selectedBackgroundColor = white

    var daySymbols = DaySymbolsStyle()
    daySymbols.weekDayColor = white
    daySymbols.weekendColor = lightGray

    var swipeLabel = SwipeLabelStyle()
    swipeLabel.textColor = white

    var header = DayHeaderStyle()
    header.daySelector = selector
    header.daySymbols = daySymbols
    header.swipeLabel = swipeLabel
    header.backgroundColor = black

    var timeline = TimelineStyle()
    timeline.verticalInset = CGFloat(50)
    timeline.verticalDiff = CGFloat(100)
    timeline.lineColor = lightGray
    timeline.timeColor = lightGray
    timeline.backgroundColor = black
    timeline.allDayStyle.backgroundColor = darkGray
    timeline.allDayStyle.allDayColor = white

    var style = CalendarStyle()
    style.header = header
    style.timeline = timeline

    return style
  }
}

