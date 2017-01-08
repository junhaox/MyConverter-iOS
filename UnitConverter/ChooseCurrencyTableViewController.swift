//
//  ChooseCurrencyTableViewController.swift
//  UnitConverter
//
//  Created by Junhao Xie on 1/2/17.
//  Copyright © 2017 Junhao Xie. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ChooseCurrencyTableViewController: UITableViewController {

    var ref: FIRDatabaseReference!
    
    var fullList = [cellData]()
    var currList = [cellData]()
    var currList2 = [String]()
    var currName: String!
    var alert: UIAlertController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for data in currList {
            currList2.append(data.name)
        }
        currList2.append(currName)
        
        alert = UIAlertController(title: "This currency has already been added", message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        ref.child("Currency").observe(.value, with: {
            snapshot in
            for child in snapshot.children {
                let data = cellData(name: (child as! FIRDataSnapshot).key, unit: (child as! FIRDataSnapshot).value as! String)
                self.fullList.append(data)
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"chooseCurrencyCell", for: indexPath) as! ChooseCurrencyTableViewCell
        
        cell.chooseCurrencyName.text = fullList[indexPath.row].name
        cell.chooseCurrencyUnit.text = fullList[indexPath.row].unit
        cell.chooseImage.image = UIImage(named: cell.chooseCurrencyName.text!)

        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newData = fullList[indexPath.row]
        var isAdded = false
        for data in currList2 {
            if newData.name == data {
                isAdded = true
                self.present(alert, animated: true, completion: nil)
                break
            }
        }
        if !isAdded {
            currList.append(newData)
            self.performSegue(withIdentifier: "backToCurrencySegue", sender: Any?.self)
        }
    }

}
