//
//  UnitViewController.swift
//  UnitConverter
//
//  Created by Junhao Xie on 12/30/16.
//  Copyright © 2016 Junhao Xie. All rights reserved.
//

import UIKit
import FirebaseDatabase

class UnitViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var currName: UILabel!
    @IBOutlet weak var currValue: UILabel!
    @IBOutlet weak var currUnit: UILabel!
    
    var ref: FIRDatabaseReference!
    
    var currList = [cellData]()
    
    var currNum: Double!
    var currDimen = "Length"
    var currMeasurement: NSMeasurement!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        
        ref.child("Unit").child(currDimen).observe(.value, with: {
            snapshot in
            for child in snapshot.children {
                let data = cellData(name: (child as! FIRDataSnapshot).key, unit: (child as! FIRDataSnapshot).value as! String)
                self.currList.append(data)
                self.tableView.reloadData()
            }
        })
        currName.text = "miles"
        currUnit.text = "mi"
        currValue.text = "1.0"
        
        currNum = 1.0
        currMeasurement = NSMeasurement(doubleValue: currNum, unit: UnitLength.miles)
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
        updateValue(dimension: currDimen, unit: currList[indexPath.row].name, cellLabel: cell.valueLabel);
        
        return cell
    }
    
    public func updateValue(dimension: String, unit: String, cellLabel: UILabel) {
        switch dimension {
        case "Length":
            if unit == "meters" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitLength.meters).value * 100) / 100)"
            }
            else if unit == "centimeters" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitLength.centimeters).value * 100) / 100)"
            }
            else if unit == "feet" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitLength.feet).value * 100) / 100)"
            }
            else if unit == "inches" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitLength.inches).value * 100) / 100)"
            }
            else if unit == "kilometers" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitLength.kilometers).value * 100) / 100)"
            }
            else if unit == "miles" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitLength.miles).value * 100) / 100)"
            }
            else if unit == "millimeters" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitLength.millimeters).value * 100) / 100)"
            }
            break
            
        default:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chooseUnitSegue" {
            let seg = segue.destination as! ChooseUnitTableViewController
            seg.ref = self.ref
        }
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
