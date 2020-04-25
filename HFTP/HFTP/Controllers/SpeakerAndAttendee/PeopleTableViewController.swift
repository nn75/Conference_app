//
//  PeopleTableViewController.swift
//  HFTP
//
//  Created by ny38 on 3/17/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit

class PeopleTableViewController: UITableViewController {
    
    @IBOutlet var peopleTableView: UITableView!
    
    var selectedRow = 0
    var isSpeaker : Bool = true
    
    var speakerOrAttendeeList : [People] = []
    var filteredResult : [People] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up navigaion bar and table view
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        self.peopleTableView.backgroundView = UIImageView(image: UIImage(named: K.imageName.tableBackground))
        self.peopleTableView.dataSource = self
        self.peopleTableView.delegate = self
        self.peopleTableView.register(UINib(nibName: K.cellName.peopleTableViewCell, bundle: nil), forCellReuseIdentifier: K.identifiers.cellID)
    
        setUpSearchController()
        
        if(!isSpeaker) {
            self.tableView.refreshControl = UIRefreshControl()
            self.tableView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl(_:)), for: .valueChanged)
        }

    }

    // MARK: - Delegate methods

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltered {
            return filteredResult.count
        }
        return speakerOrAttendeeList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = peopleTableView.dequeueReusableCell(withIdentifier: K.identifiers.cellID, for: indexPath) as! PeopleTableViewCell
        if isFiltered {
            cell.fullName.text = filteredResult[indexPath.row].fullName
            cell.title.text = filteredResult[indexPath.row].company
            if(filteredResult[indexPath.row].avator.isEmpty) {
                cell.avatorView.image = UIImage(named: K.imageName.defaultPhoto) //Future design
            } else {
                cell.avatorView.image = fetchData.stringToImage(filteredResult[indexPath.row].avator)
            }
                
        } else {
            cell.fullName.text = speakerOrAttendeeList[indexPath.row].fullName
            cell.title.text = speakerOrAttendeeList[indexPath.row].company
            if(speakerOrAttendeeList[indexPath.row].avator.isEmpty) {
                cell.avatorView.image = UIImage(named: K.imageName.defaultPhoto) //Future design
            } else {
                cell.avatorView.image = fetchData.stringToImage(speakerOrAttendeeList[indexPath.row].avator)
            }
            
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRow = indexPath.row
        if isSpeaker {
            self.performSegue(withIdentifier: K.identifiers.speakerInfoSegue, sender: self)
        } else {
            self.performSegue(withIdentifier: K.identifiers.attendeeInfoSegue, sender: self)
        }
        self.tableView.deselectRow(at: indexPath, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.identifiers.speakerInfoSegue {
            if let destination = segue.destination as? SpeakerInfoViewController {
                if isFiltered {
                    destination.mySpeaker = filteredResult[selectedRow] as! Speaker
                } else {
                    destination.mySpeaker = speakerOrAttendeeList[selectedRow] as! Speaker
                }
            }
        } else if segue.identifier == K.identifiers.attendeeInfoSegue {
            if let destination = segue.destination as? AttendeeInfoTableViewController {
                if isFiltered {
                    destination.myAttendee = filteredResult[selectedRow] as! Attendee
                } else {
                    destination.myAttendee = speakerOrAttendeeList[selectedRow] as! Attendee
                }
            }
        }
    }
    //MARK: RefreshController
    @objc func handleRefreshControl(_ sender: Any) {
        group.enter()
        fetchData.fetchAttendeeData()
        group.enter()
        fetchData.fetchUsereData()
        group.notify(queue: .main) {
            fetchData.getListofAllAttendees()
            self.speakerOrAttendeeList = attendeeList
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }

}


// MARK: - SearchController
extension PeopleTableViewController: UISearchBarDelegate, UISearchResultsUpdating{
    
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
        self.peopleTableView.reloadData()
    }
    
    func filterPeople(by searchText : String) {
        filteredResult = isSpeaker ?  speakerList : attendeeList
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
    
}
