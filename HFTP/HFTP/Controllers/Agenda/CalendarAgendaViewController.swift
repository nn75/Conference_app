//
//  CalendarAgendaViewController.swift
//  HFTP
//
//  Created by Zihui on 4/10/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit
import CalendarKit
import DateToolsSwift

// this data struct stores information of each event
struct MyEvent {
    var name: String
    var startTime: String
    var duration: Int
    var sessionId = ""

    public init(name: String, startTime: String, duration:Int) {
        self.name = name
        self.startTime = startTime
        self.duration = duration
    }
}

// display the agenda in calendar mode
class CalendarAgendaViewController: DayViewController {
    
    var currentSeesionIds : [String] = []
    var currentDate: String = ""
    var selectedSessionId = ""
    
    var myEvents: [MyEvent] = []
    
    var generatedEvents = [EventDescriptor]()
    var alreadyGeneratedSet = Set<Date>()
    
    var colors = [UIColor.blue,
                  UIColor.yellow,
                  UIColor.green,
                  UIColor.red]
    
    
    lazy var customCalendar: Calendar = {
        let customNSCalendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!
        customNSCalendar.timeZone = .current
        let calendar = customNSCalendar as Calendar
        return calendar
    }()
    
    override func loadView() {
        calendar = customCalendar
        dayView = DayView(calendar: calendar)
        view = dayView
    }
    
    // move the calendar to the selected date
    override func viewDidAppear(_ animated: Bool) {
        if let dateJT = Date().setDate("\(currentDate) 00:00") {
            dayView.state?.move(to: dateJT)
        } else {
            // error
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCalendarUI()

        loadEvent()
        
        //Scoll to the first event of that day
        dayView.autoScrollToFirstEvent = true
        
        reloadData()
    }
    
    func setupCalendarUI() {
        var style: CalendarStyle!
        style = StyleGenerator.defaultStyle()
        updateStyle(style)
    }
    
    // transfer date
    func loadEvent(){
        var startTime = ""
        var duration : Int = 0
        var tempEvent : MyEvent
        for id in currentSeesionIds{
            startTime = String("\(sessionDic[id]!.date.replacingOccurrences(of: "-", with: "/", options: .literal, range: nil)) \(sessionDic[id]!.startTime)")
            duration = durationCal(sessionDic[id]!.startTime, end: sessionDic[id]!.endTime)
            tempEvent = MyEvent(name:sessionDic[id]!.name, startTime: startTime, duration: duration)
            tempEvent.sessionId = id
            myEvents.append(tempEvent)
        }
    }
    
    func durationCal(_ start: String, end: String) -> Int{
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let time1 = formatter.date(from: start)!
        let time2 = formatter.date(from: end)!
        let elapsedTime = time2.timeIntervalSince(time1)
        return Int(elapsedTime/60)
    }
    
    // MARK: EventDataSource
    
    
   override func eventsForDate(_ date: Date) -> [EventDescriptor] {
        var events = [Event]()
        
        for myEvent in myEvents {
            
            let workingDate = Date().setDate(myEvent.startTime)!
            let datePeriod = TimePeriod(beginning: workingDate, chunk: TimeChunk.dateComponents(minutes: myEvent.duration))
            
            let event = Event()
            event.startDate = datePeriod.beginning!
            event.endDate = datePeriod.end!
            
            let timezone = dayView.calendar.timeZone
            
            let timeInfo = "\(datePeriod.beginning!.format(with: "HH:mm", timeZone: timezone)) - \(datePeriod.end!.format(with: "HH:mm", timeZone: timezone))"
            
            event.text = myEvent.name + "\n" + timeInfo
            event.color = colors[Int(arc4random_uniform(UInt32(colors.count)))]
            event.userInfo = myEvent.sessionId
            
            events.append(event)
            
            
        }
        return events
    }
    
    private func textColorForEventInDarkTheme(baseColor: UIColor) -> UIColor {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        baseColor.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return UIColor(hue: h, saturation: s * 0.3, brightness: b, alpha: a)
    }
    
    // MARK: DayViewDelegate
    
    private var createdEvent: EventDescriptor?
    
    override func dayViewDidSelectEventView(_ eventView: EventView) {
        guard let descriptor = eventView.descriptor as? Event else {
            return
        }
        selectedSessionId = descriptor.userInfo! as! String
        self.performSegue(withIdentifier: K.identifiers.showCalendarDetail, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! SessionInfoTableViewController
        destination.thisSessionId = self.selectedSessionId
    }
    
    override func dayView(dayView: DayView, willMoveTo date: Date) {
    }
}

