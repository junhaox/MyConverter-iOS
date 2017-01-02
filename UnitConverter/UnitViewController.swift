//
//  UnitViewController.swift
//  UnitConverter
//
//  Created by Junhao Xie on 12/30/16.
//  Copyright © 2016 Junhao Xie. All rights reserved.
//

import UIKit
import FirebaseDatabase

struct unitData {
    let name: String!
    let unit: String!
}

class UnitViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var currName: UILabel!
    @IBOutlet weak var currValue: UILabel!
    @IBOutlet weak var currUnit: UILabel!
    
    var ref: FIRDatabaseReference!
    
    var currList = [unitData]()
    
    var currNum: Double!
    var currDimen: String!
    var currMeasurement: NSMeasurement!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        
        ref.child("Unit").child("Length").observe(.value, with: {
            snapshot in
            for child in snapshot.children {
                let data: unitData = unitData(name: (child as! FIRDataSnapshot).key, unit: (child as! FIRDataSnapshot).value as! String)
                self.currList.append(data)
                self.tableView.reloadData()
            }
        })
        currName.text = "meters"
        currUnit.text = "m"
        currValue.text = "1.0"
        
        currNum = 1.0
        currDimen = "Length"
        currMeasurement = NSMeasurement(doubleValue: currNum, unit: UnitLength.meters)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currList.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "unitCell", for: indexPath) as! UnitTableViewCell
        
        cell.nameLabel.text = currList[indexPath.row].name
        cell.unitLabel.text = currList[indexPath.row].unit
        cell.valueLabel.text = "\(round(currMeasurement.converting(to: UnitLength.feet).value * 100) / 100)"
        
        return cell
    }
    
    public func detectDimension(dimension: String, measurement: NSMeasurement) {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
