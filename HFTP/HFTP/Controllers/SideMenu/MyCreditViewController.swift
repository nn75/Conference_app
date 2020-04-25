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
    @IBOutlet weak var sumNumber: PaddingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        sumNumber.text = H.getCreditSum()
        
        tableView.register(UINib(nibName: K.cellName.creditTableViewCell, bundle: nil), forCellReuseIdentifier: K.identifiers.cellID)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    func configureUI() {
        //Resize the cell height
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50.0
    }
    
}

extension MyCreditViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creditList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.identifiers.cellID) as! CreditTableViewCell
        
        cell.sessionName.text = creditList[indexPath.row].name
        cell.sessionCode.text = creditList[indexPath.row].code
        cell.sessionCredit.text = String(creditList[indexPath.row].credit)
        
        return cell
    }

}
