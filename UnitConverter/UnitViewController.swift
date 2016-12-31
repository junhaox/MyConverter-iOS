//
//  UnitViewController.swift
//  UnitConverter
//
//  Created by Junhao Xie on 12/30/16.
//  Copyright © 2016 Junhao Xie. All rights reserved.
//

import UIKit

class UnitViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var unitName = [String]()
    var unitValue = [String]()
    var unitUnit = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        unitName = ["cilometers", "meters", "kilometers", "miles"]
        unitValue = ["1000", "10", "0.01", "0.016"]
        unitUnit = ["cm", "m", "km", "mi"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return unitName.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "unitCell", for: indexPath) as! UnitTableViewCell
        
        cell.nameLabel?.text = unitName[indexPath.row]
        cell.valueLabel?.text = unitValue[indexPath.row]
        cell.unitLabel?.text = unitUnit[indexPath.row]
        
        return cell
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
