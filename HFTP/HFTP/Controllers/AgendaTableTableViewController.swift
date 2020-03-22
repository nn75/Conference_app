//
//  AgendaTableTableViewController.swift
//  HFTP
//
//  Created by Zihui on 3/19/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit

class AgendaTableTableViewController: UITableViewController {

    let searchController = UISearchController(searchResultsController: nil)
    
    var selectedSessions : [zSession] = []
    
    @IBOutlet var agendaTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.agendaTable.dataSource = self
        self.agendaTable.delegate = self
        setUpSearchController()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return agendaList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = agendaTable.dequeueReusableCell(withIdentifier: K.identifiers.cellID, for: indexPath) as! AgendaTableViewCell
        cell.title = agendaList[indexPath.row].title
        // Configure the cell...
        cell.setUpCell()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedSessions = agendaList[indexPath.row].sessions
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: K.identifiers.sessionTVCSegue, sender: self)
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! UITabBarController
        let sessionView =  destination.viewControllers![0] as! SessionTableViewController
        sessionView.currentSessions = self.selectedSessions
    }

}


// SearchController
extension AgendaTableTableViewController: UISearchBarDelegate, UISearchResultsUpdating{
    
    func setUpSearchController(){
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.sizeToFit()
        searchController.searchBar.placeholder = K.texts.searchAgenda
        searchController.searchBar.barTintColor = UIColor.clear
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
}
