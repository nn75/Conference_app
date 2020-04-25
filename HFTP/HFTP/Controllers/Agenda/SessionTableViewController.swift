//
//  SessionTableViewController.swift
//  HFTP
//
//  Created by Zihui on 3/19/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit

// the page showing a list of sessions of a certain day
class SessionTableViewController: UITableViewController {
    
    @IBOutlet var sessionTable: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var selectedSessionId  = ""
    
    var filteredSessions : [Session] = []
    
    var currentSessions : [Session] = []
    
    var currentSeesionIds : [String] = []
    
    var currentDate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sessionTable.dataSource = self
        self.sessionTable.delegate = self
        setUpSearchController()
        self.sessionTable.register(UINib(nibName: K.cellName.sessionTableViewCell, bundle: nil), forCellReuseIdentifier: K.identifiers.cellID)
        
        loadSessions()
    }
    
    // sort the current sessions
    func loadSessions(){
        currentSeesionIds = currentSeesionIds.sorted(by: { sessionDic[$0]!.startTime < sessionDic[$1]!.startTime })
        for id in currentSeesionIds{
            currentSessions.append(sessionDic[id]!)
        }
    }
    
}

// MARK: - Table view data source
extension SessionTableViewController{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return isFiltered ? filteredSessions.count : currentSessions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sessionTable.dequeueReusableCell(withIdentifier: K.identifiers.cellID, for: indexPath) as! SessionTableViewCell
        let displayedSession = isFiltered ? filteredSessions[indexPath.row] : currentSessions[indexPath.row]
        cell.sessionTitle.text = displayedSession.name
        cell.sessionType.text = displayedSession.category
        cell.sessionTime.text = "\(displayedSession.startTime) - \(displayedSession.endTime)"
        cell.sessionLocation.text = displayedSession.location
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSession = isFiltered ? filteredSessions[indexPath.row] : currentSessions[indexPath.row]
        self.selectedSessionId = sessionDic.allKeys(forValue: selectedSession)[0]
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: K.identifiers.sessionInfoSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! SessionInfoTableViewController
        destination.thisSessionId = self.selectedSessionId
    }
}


// MARK: - SearchController
extension SessionTableViewController: UISearchBarDelegate, UISearchResultsUpdating{
    
    func setUpSearchController(){
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        
        sessionTable.tableHeaderView = searchController.searchBar
        searchController.searchBar.setAgendaSearchBarStyle()
        
        definesPresentationContext = true
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let input = searchController.searchBar.text {
            filterSessions(by:input)
        }
        self.sessionTable.reloadData()
    }
    
    func dismissSearch() {
        searchController.dismiss(animated: false, completion: nil)
    }
    
    func filterSessions(by input: String) {
        filteredSessions = currentSessions.filter{ (s: Session) -> Bool in return s.category.lowercased().contains(input.lowercased()) || s.date.lowercased().contains(input.lowercased())
            || s.name.lowercased().contains(input.lowercased())
            || s.location.lowercased().contains(input.lowercased())
            || s.startTime.lowercased().contains(input.lowercased())
            ||  s.endTime .lowercased().contains(input.lowercased())
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
