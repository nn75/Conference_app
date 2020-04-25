//
//  SessionAttendeeTableViewController.swift
//  HFTP
//
//  Created by Zihui on 3/26/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit

// the list of attendee of a session
class SessionAttendeeTableViewController: UITableViewController {
    
    @IBOutlet var sessionAttendeeTableView: UITableView!
    var currentSession = Session()
    let searchController = UISearchController(searchResultsController: nil)
    var selectedAttendee = Attendee()
    var filteredResult : [Attendee] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sessionAttendeeTableView.backgroundView = UIImageView(image: UIImage(named: K.imageName.tableBackground))
        
        self.tableView.register(UINib(nibName: K.cellName.peopleTableViewCell, bundle: nil), forCellReuseIdentifier: K.identifiers.cellID)
        setUpSearchController()
        self.tableView.refreshControl = UIRefreshControl()
        // update data when pull down to refresh
        self.tableView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
}

// MARK: - Table view data source
extension SessionAttendeeTableViewController{
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return isFiltered ? filteredResult.count : currentSession.attendee.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.identifiers.cellID, for: indexPath) as! PeopleTableViewCell
        let thisAttendee = isFiltered ? filteredResult[indexPath.row] : usersDic[currentSession.attendee[indexPath.row]]!
        cell.fullName.text = thisAttendee.fullName
        cell.title.text = thisAttendee.company
        if(thisAttendee.avator.isEmpty){
            cell.avatorView.image = UIImage(named: K.imageName.defaultPhoto) //Future design
        } else{
            cell.avatorView.image = fetchData.stringToImage(thisAttendee.avator)
        }
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedAttendee = usersDic[currentSession.attendee[indexPath.row]]!
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: K.identifiers.showSessionAttendeeDetail, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! AttendeeInfoTableViewController
        destination.myAttendee = self.selectedAttendee
    }
}

// MARK: - SearchController
extension SessionAttendeeTableViewController: UISearchBarDelegate, UISearchResultsUpdating{
    
    func setUpSearchController(){        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = true
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        
        searchController.searchBar.setPeopleSearchBarStyle()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let input = searchController.searchBar.text {
            filterPeople(by:input)
        }
        self.sessionAttendeeTableView.reloadData()
    }
    
    func filterPeople(by searchText : String) {
        filteredResult = []
        for attendee_id in currentSession.attendee {
            filteredResult.append(usersDic[attendee_id]!)
        }
        filteredResult = filteredResult.filter { (s : People) -> Bool in
            return s.fullName.lowercased().contains(searchText.lowercased()) ||
                        s.company.lowercased().contains(searchText.lowercased())
        }
    }
    
    var isFiltered: Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!isSearchBarEmpty || searchBarScopeIsFiltering)
    }
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    @objc func handleRefreshControl() {
        group.enter()
        fetchData.fetchAttendeeData()
        group.notify(queue: .main) {
            fetchData.getListofAllAttendees()
            let sessionIds = Array(sessionDic.keys).sorted(by: <)
            for id in sessionIds{
                sessionDic[id]!.attendee = sessionAttendeeDic[id]!
            }
            
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
}
