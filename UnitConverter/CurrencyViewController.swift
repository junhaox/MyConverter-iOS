//
//  CurrencyViewController.swift
//  UnitConverter
//
//  Created by Junhao Xie on 12/30/16.
//  Copyright © 2016 Junhao Xie. All rights reserved.
//

import UIKit
import FirebaseDatabase

struct cellData {
    let name: String!
    let unit: String!
}

class CurrencyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var currImage: UIImageView!
    @IBOutlet weak var currName: UILabel!
    @IBOutlet weak var currValue: UILabel!
    @IBOutlet weak var currUnit: UILabel!
    
    var ref: FIRDatabaseReference!
    
    var currList = [cellData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        
        ref.child("Currency").observe(.value, with: {
            snapshot in
            for child in snapshot.children {
                let data = cellData(name: (child as! FIRDataSnapshot).key, unit: (child as! FIRDataSnapshot).value as! String)
                self.currList.append(data)
                self.tableView.reloadData()
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
            
        cell.imageName.image = UIImage(named: currList[indexPath.row].name)
        cell.currencyName?.text = currList[indexPath.row].name
        cell.currencyUnit?.text = currList[indexPath.row].unit
        cell.currencyValue?.text = "1.0"
        
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
