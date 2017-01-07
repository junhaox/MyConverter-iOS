//
//  ChooseUnitTableViewController.swift
//  UnitConverter
//
//  Created by Junhao Xie on 1/5/17.
//  Copyright © 2017 Junhao Xie. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ChooseUnitTableViewController: UITableViewController {
    
    var ref: FIRDatabaseReference!
    var fullList = [String]()
    var currDimen: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref.child("Unit").observe(.value, with: {
            snapshot in
            for child in snapshot.children {
                self.fullList.append((child as! FIRDataSnapshot).key)
                self.tableView.reloadData()
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fullList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chooseUnitCell", for: indexPath) as! ChooseUnitTableViewCell
        
        cell.dimenName.text = fullList[indexPath.row]
        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.currDimen = fullList[indexPath.row]
        
        self.performSegue(withIdentifier: "backToUnitSegue", sender: Any?.self)
    }
}
