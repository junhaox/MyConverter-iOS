//
//  CurrencyViewController.swift
//  UnitConverter
//
//  Created by Junhao Xie on 12/30/16.
//  Copyright © 2016 Junhao Xie. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController {

    @IBOutlet var currencyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*var currencyName = ["CNY", "USD", "SKW", "HKD"]
    var currencyText = ["Chinese Yuan", "US Dollor", "South Korean Won", "Hong Kong Dollar"]
    var currencyNum = ["6.92", "1.0", "1129.3", "9.54"]


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return currencyName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.currencyTableView.dequeueReusableCell(withIdentifier: "currencyCell", for: indexPath) as! CurrencyTableViewCell
        
        // Configure the cell...
        cell.name?.text = currencyName[indexPath.row]
        cell.unit?.text = currencyText[indexPath.row]
        cell.value?.text = currencyNum[indexPath.row]
        
        return cell
    }*/

}
