//
//  MyAgendaTableViewController.swift
//  HFTP
//
//  Created by Zihui on 3/19/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit

class MyAgendaTableViewController: UITableViewController {

    @IBOutlet var myAgendaTable: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    var selectedSessionId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myAgendaTable.dataSource = self
        self.myAgendaTable.delegate = self
        setUpSearchController()
        self.myAgendaTable.register(UINib(nibName: "SessionTableViewCell", bundle: nil), forCellReuseIdentifier: K.identifiers.cellID)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myAgenda.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myAgendaTable.dequeueReusableCell(withIdentifier: K.identifiers.cellID, for: indexPath) as! SessionTableViewCell
        cell.sessionTitle.text = sessionDic[myAgenda[indexPath.row]]!.name
        cell.sessionType.text = sessionDic[myAgenda[indexPath.row]]!.category
        cell.sessionTime.text = "\(sessionDic[myAgenda[indexPath.row]]!.startTime) - \(sessionDic[myAgenda[indexPath.row]]!.endTime)"
        cell.sessionLocation.text = sessionDic[myAgenda[indexPath.row]]!.location
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedSessionId = myAgenda[indexPath.row]
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: K.identifiers.showMySessionInfo, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          let destination = segue.destination as! SessionInfoTableViewController
          destination.thisSessionId = self.selectedSessionId
      }
    
    // MARK: - Row Editing
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
          return true
      }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
    
    //delete data from data source and table
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
            for i in 0..<sessionDic[myAgenda[indexPath.row]]!.attendee.count{
                if sessionDic[myAgenda[indexPath.row]]!.attendee[i] == globalUsrId{
                    sessionDic[myAgenda[indexPath.row]]!.attendee.remove(at: i)
                }
            }
            updateData.updateAttendee(session_id: myAgenda[indexPath.row],  user_id: sessionDic[myAgenda[indexPath.row]]!.attendee)
            updateData.updateUser(userId: globalUsrId, fieldName: "session", value: myAgenda)
            myAgenda.remove(at: indexPath.row)
            tableView.reloadData()
        }
     }
    
    
    
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
extension MyAgendaTableViewController: UISearchBarDelegate, UISearchResultsUpdating{
    
    func setUpSearchController(){
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = true
        
        myAgendaTable.tableHeaderView = searchController.searchBar
        searchController.searchBar.tintColor = UIColor(named: K.colors.hftpDarkBlue)
        searchController.searchBar.sizeToFit()
        searchController.searchBar.placeholder = K.texts.searchAgenda
        searchController.searchBar.barTintColor = UIColor.white
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
}
