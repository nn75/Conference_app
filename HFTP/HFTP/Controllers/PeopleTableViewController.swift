//
//  PeopleTableViewController.swift
//  HFTP
//
//  Created by ny38 on 3/17/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit

class PeopleTableViewController: UITableViewController {
    
    @IBOutlet var peopleTableView: UITableView!   // the tableView
    
    var selectedRow = 0
    var isSpeaker : Bool = true
    var filteredSpeaker : [Speaker] = []
    var filteredAttendee : [Attendee] = []
    
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.peopleTableView.dataSource = self
        self.peopleTableView.delegate = self
    
        loadMockData()
        setUpSearchController()
        
    }

    // MARK: - Delegate methods

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltered {
            return isSpeaker ? filteredSpeaker.count : filteredAttendee.count
        }
        return isSpeaker ? speakerList.count : attendeeList.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = peopleTableView.dequeueReusableCell(withIdentifier: K.identifiers.cellID, for: indexPath) as! PeopleTableViewCell
        if isFiltered {
            if isSpeaker {
                cell.fullName = filteredSpeaker[indexPath.row].fullName
            } else {
                cell.fullName = filteredAttendee[indexPath.row].fullName
            }
        } else {
            if isSpeaker {
                cell.fullName = speakerList[indexPath.row].fullName
            } else {
                cell.fullName = attendeeList[indexPath.row].fullName
            }
        }
        
        cell.setUpCell()
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
                destination.mySpeaker = speakerList[selectedRow]
            }
        } else if segue.identifier == K.identifiers.attendeeInfoSegue {
            if let destination = segue.destination as? AttendeeInfoViewController {
                destination.myAttendee = attendeeList[selectedRow]
            }
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
        searchController.searchBar.sizeToFit()
        searchController.searchBar.placeholder = isSpeaker ? K.texts.searchSpeaker : K.texts.searchAttendee
        searchController.searchBar.barTintColor = UIColor.clear
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let input = searchController.searchBar.text {
            filterPeople(by:input)
        }
        self.peopleTableView.reloadData()
    }
    
    func filterPeople(by searchText : String) {
        if isSpeaker {
            filteredSpeaker = speakerList
            filteredSpeaker = filteredSpeaker.filter { (s : Speaker) -> Bool in
                return s.firstName.lowercased().contains(searchText.lowercased()) ||
                        s.lastName.lowercased().contains(searchText.lowercased())
            }
        } else { // isAttendee
            filteredAttendee = attendeeList
            filteredAttendee = filteredAttendee.filter { (a : Attendee) -> Bool in
                return a.firstName.lowercased().contains(searchText.lowercased()) ||
                        a.lastName.lowercased().contains(searchText.lowercased())
            }
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
