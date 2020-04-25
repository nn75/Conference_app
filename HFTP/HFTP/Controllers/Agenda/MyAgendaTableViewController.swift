//
//  MyAgendaTableViewController.swift
//  HFTP
//
//  Created by Zihui on 3/19/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit

// the page to display my agenda in table mode
class MyAgendaTableViewController: UITableViewController {

    @IBOutlet var myAgendaTable: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var selectedSessionId = ""
    
    var currentDate = ""
    
    var displayList : [String] = []
    
    var currentSessions :[Session] = []
    
    var filteredSessions : [Session] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myAgendaTable.dataSource = self
        self.myAgendaTable.delegate = self

        setUpSearchController()
        self.myAgendaTable.register(UINib(nibName: K.cellName.sessionTableViewCell, bundle: nil), forCellReuseIdentifier: K.identifiers.cellID)
        pickSessionByDay()

    }
    
    // find all sessions in my agenda of that day
    func pickSessionByDay(){
        displayList = []
        currentSessions = []
        for id in myAgenda{
            if(sessionDic[id]!.date == currentDate){
                displayList.append(id)
            }
        }
        displayList = displayList.sorted(by: { sessionDic[$0]!.startTime < sessionDic[$1]!.startTime })
        for id in displayList{
            currentSessions.append(sessionDic[id]!)
        }
    }

    // show alert when the user is not login
    override func viewDidAppear(_ animated: Bool) {
        if(!globalIsLoggedIn){
            // show warning msg
            self.popupAlert(title: "Please Login", message: "Login to view your agenda", actionTitles: ["OK"], actions: [{action1 in}])
            return
        }
        pickSessionByDay()
        self.tableView.reloadData()
    }
}

// MARK: - Table view data source
extension MyAgendaTableViewController{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return  isFiltered ? filteredSessions.count : currentSessions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myAgendaTable.dequeueReusableCell(withIdentifier: K.identifiers.cellID, for: indexPath) as! SessionTableViewCell
        let tempSession = isFiltered ? filteredSessions[indexPath.row] : currentSessions[indexPath.row]
        cell.sessionTitle.text = tempSession.name
        cell.sessionType.text = tempSession.category
        cell.sessionTime.text = "\(tempSession.startTime) - \(tempSession.endTime)"
        cell.sessionLocation.text = tempSession.location
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSession = isFiltered ? filteredSessions[indexPath.row] : currentSessions[indexPath.row]
        self.selectedSessionId = sessionDic.allKeys(forValue: selectedSession)[0]
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: K.identifiers.showMySessionInfo, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          let destination = segue.destination as! SessionInfoTableViewController
          destination.thisSessionId = self.selectedSessionId
      }
    
    // Row Editing
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
          return !isFiltered
      }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
    
    //delete data from data source and table
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
            for i in 0..<sessionDic[displayList[indexPath.row]]!.attendee.count{
                if sessionDic[displayList[indexPath.row]]!.attendee[i] == globalUsrId{
                    sessionDic[displayList[indexPath.row]]!.attendee.remove(at: i)
                    break
                }
            }
            
            for j in 0..<myAgenda.count{
                if (myAgenda[j] == displayList[indexPath.row]){
                    myAgenda.remove(at: j)
                    break
                }
            }
            
            updateData.updateAttendee(session_id: displayList[indexPath.row],  user_id: sessionDic[displayList[indexPath.row]]!.attendee)
            updateData.updateUser(userId: globalUsrId, fieldName: "session", value: myAgenda)
            displayList.remove(at: indexPath.row)
            currentSessions.remove(at: indexPath.row)
            usersDic[globalUsrId]!.sessions = myAgenda
            tableView.reloadData()
        }
     }
}


// SearchController
extension MyAgendaTableViewController: UISearchBarDelegate, UISearchResultsUpdating{
    
    func setUpSearchController(){
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        
        myAgendaTable.tableHeaderView = searchController.searchBar
        searchController.searchBar.setAgendaSearchBarStyle()
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let input = searchController.searchBar.text {
            filterSessions(by:input)
        }
        self.myAgendaTable.reloadData()
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
