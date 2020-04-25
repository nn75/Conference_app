//
//  AgendaTableTableViewController.swift
//  HFTP
//
//  Created by Zihui on 3/19/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit

// the page showing a list of conference date
class AgendaTableTableViewController: UITableViewController {

    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredAgendaId : [String] = []
    var selectedSessions : [String] = []
    var selectedDate = ""
    var isCalendarMode = false
    
    @IBOutlet var agendaTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.agendaTable.dataSource = self
        self.agendaTable.delegate = self
        
        setUpSearchController()
        setUpModeSwitch()
        
        self.agendaTable.register(UINib(nibName: K.cellName.agendaTableViewCell, bundle: nil), forCellReuseIdentifier: K.identifiers.cellID)
    }
    
    // initialize the mode switch button
    func setUpModeSwitch(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: K.titles.btnShowCalendar, style: .plain, target: self, action: #selector(modeSwitchTapped))
    }
    
    // action when tap the mode switch button
    @objc func modeSwitchTapped(){
        if(!isCalendarMode){
            self.navigationItem.rightBarButtonItem?.title = K.titles.btnShowTable
            isCalendarMode = true
        }else{
            self.navigationItem.rightBarButtonItem?.title = K.titles.btnShowCalendar
            isCalendarMode = false
        }
    }
}

// MARK: - Table view data source
extension AgendaTableTableViewController{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
           // #warning Incomplete implementation, return the number of sections
           return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return isFiltered ? filteredAgendaId.count : agendaIds.count
    }

       
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = agendaTable.dequeueReusableCell(withIdentifier: K.identifiers.cellID, for: indexPath) as! AgendaTableViewCell
        cell.agendaDayTitle.text = isFiltered ? filteredAgendaId[indexPath.row] : agendaIds[indexPath.row]
        // Configure the cell...
        // cell.setUpCell()
        return cell
    }
    
    // jump to different VC in different view mode
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedSessions = isFiltered ? agendaDic[filteredAgendaId[indexPath.row]]! : agendaDic[agendaIds[indexPath.row]]!
        self.selectedDate = isFiltered ? filteredAgendaId[indexPath.row] : agendaIds[indexPath.row]
        self.tableView.deselectRow(at: indexPath, animated: true)
        if(!isCalendarMode){
            self.performSegue(withIdentifier: K.identifiers.sessionTVCSegue, sender: self)
        } else{
            self.performSegue(withIdentifier: K.identifiers.calendarSessionTVCSegue, sender: self)
        }
    }
    
    // pass the session and date info
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! UITabBarController
        if(!isCalendarMode){
            destination.navigationItem.title = selectedDate
            let sessionView = destination.viewControllers![0] as! SessionTableViewController
            sessionView.currentSeesionIds = self.selectedSessions
            sessionView.currentDate = selectedDate
            let mySessionView = destination.viewControllers![1] as! MyAgendaTableViewController
            mySessionView.currentDate = selectedDate
        } else{
            let calendarView = destination.viewControllers![0] as! CalendarAgendaViewController
            for id in agendaIds{
                calendarView.currentSeesionIds += agendaDic[id]!
            }
            calendarView.currentDate = selectedDate.replacingOccurrences(of: "-", with: "/", options: .literal, range: nil)
            let myCalendarView = destination.viewControllers![1] as! MyCalendarViewController
            myCalendarView.currentSeesionIds = myAgenda
            myCalendarView.currentDate = calendarView.currentDate
        }
    }
}




// MARK: - SearchController
extension AgendaTableTableViewController: UISearchBarDelegate, UISearchResultsUpdating{
    
    func setUpSearchController(){
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        
        agendaTable.tableHeaderView = searchController.searchBar
        searchController.searchBar.setAgendaSearchBarStyle()
        
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let input = searchController.searchBar.text {
            filterAgenda(by:input)
        }
        self.agendaTable.reloadData()
    }
    
    func filterAgenda(by input:String){
        filteredAgendaId = agendaIds.filter { (id: String) -> Bool in return id.lowercased().contains(input.lowercased())
        }
    }
    
    var isFiltered: Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!isSearchBarEmpty || searchBarScopeIsFiltering)
    }
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    
}
