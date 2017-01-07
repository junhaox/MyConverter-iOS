//
//  CurrencyViewController.swift
//  UnitConverter
//
//  Created by Junhao Xie on 12/30/16.
//  Copyright © 2016 Junhao Xie. All rights reserved.
//

import UIKit
import FirebaseDatabase

class CurrencyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var currImage: UIImageView!
    @IBOutlet weak var currName: UILabel!
    @IBOutlet weak var currValue: UILabel!
    @IBOutlet weak var currUnit: UILabel!
    
    var ref: FIRDatabaseReference!
    
    var currList = [cellData]()
    var currNum = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currName.text = "USD"
        currValue.text = "1.0"
        currUnit.text = "United States Dollar"
        currImage.image = UIImage(named: currName.text!)
        
        ref = FIRDatabase.database().reference()
        
        ref.child("Currency").observe(.value, with: {
            snapshot in
            for child in snapshot.children {
                if (child as! FIRDataSnapshot).key != self.currName.text {
                    let data = cellData(name: (child as! FIRDataSnapshot).key, unit: (child as! FIRDataSnapshot).value as! String)
                    self.currList.append(data)
                    self.tableView.reloadData()
                }
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "currencyCell", for: indexPath) as! CurrencyTableViewCell
            
        cell.currencyName?.text = currList[indexPath.row].name
        cell.currencyUnit?.text = currList[indexPath.row].unit
        cell.currencyValue?.text = "1.0"
        cell.imageName.image = UIImage(named: cell.currencyName.text!)
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tempName = currList[indexPath.row].name
        let tempUnit = currList[indexPath.row].unit
        
        currList[indexPath.row] = cellData(name: currName.text, unit: currUnit.text)
        
        currName.text = tempName
        currUnit.text = tempUnit
        currImage.image = UIImage(named: currName.text!)
        
        self.tableView.reloadData()
    }
    
    @IBAction func unwindToCurrency(segue: UIStoryboardSegue) {
        if segue.identifier == "backToCurrencySegue" {
            if let seg = segue.source as? ChooseCurrencyTableViewController {
                self.ref = seg.ref
                self.currList = seg.currList
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chooseCurrencySegue" {
            let seg = segue.destination as! ChooseCurrencyTableViewController
            seg.ref = self.ref
            seg.currList = self.currList
        }
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let remove = UITableViewRowAction(style: .normal, title: "Remove") { action, indexPath in
            self.currList.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        
        remove.backgroundColor = UIColor.red
        
        return [remove]
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
}
