//
//  SessionTableViewController.swift
//  HFTP
//
//  Created by Zihui on 3/19/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit

class SessionTableViewController: UITableViewController {

    @IBOutlet var sessionTable: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var selectedSessionId  = ""
    
    var currentSessions : [Session] = []
    
    var currentSeesionIds : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sessionTable.dataSource = self
        self.sessionTable.delegate = self
        setUpSearchController()
        self.sessionTable.register(UINib(nibName: "SessionTableViewCell", bundle: nil), forCellReuseIdentifier: K.identifiers.cellID)
        
        loadSessions()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    func loadSessions(){
        for id in currentSeesionIds{
            currentSessions.append(sessionDic[id]!)
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return currentSessions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sessionTable.dequeueReusableCell(withIdentifier: K.identifiers.cellID, for: indexPath) as! SessionTableViewCell
        cell.sessionTitle.text = currentSessions[indexPath.row].name
        cell.sessionType.text = currentSessions[indexPath.row].category
        cell.sessionTime.text = "\(currentSessions[indexPath.row].startTime) - \(currentSessions[indexPath.row].endTime)"
        cell.sessionLocation.text = currentSessions[indexPath.row].location
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedSessionId = currentSeesionIds[indexPath.row]
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: K.identifiers.sessionInfoSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! SessionInfoTableViewController
        destination.thisSessionId = self.selectedSessionId
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


// SearchController
extension SessionTableViewController: UISearchBarDelegate, UISearchResultsUpdating{
    
    func setUpSearchController(){
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = true
        
        sessionTable.tableHeaderView = searchController.searchBar
        searchController.searchBar.tintColor = UIColor(named: K.colors.hftpDarkBlue)
        searchController.searchBar.sizeToFit()
        searchController.searchBar.placeholder = K.texts.searchAgenda
        searchController.searchBar.barTintColor = UIColor.white
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
}
