//
//  MySessionViewController.swift
//  HFTP
//
//  Created by Nan Ni on 3/15/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit

class MyCreditViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMockData()
        
        //Hide extra empty cell
        tableView.tableFooterView = UIView()
        
        tableView.register(UINib(nibName: "CreditTableViewCell", bundle: nil), forCellReuseIdentifier: "creditCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension MyCreditViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creditList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "creditCell") as! CreditTableViewCell
        
        cell.sessionName.text = creditList[indexPath.row].name
        cell.sessionCode.text = creditList[indexPath.row].code
        cell.sessionCredit.text = String(creditList[indexPath.row].credit)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}
