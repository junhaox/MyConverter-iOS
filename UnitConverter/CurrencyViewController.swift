//
//  CurrencyViewController.swift
//  UnitConverter
//
//  Created by Junhao Xie on 12/30/16.
//  Copyright © 2016 Junhao Xie. All rights reserved.
//

import UIKit
import FirebaseDatabase

class CurrencyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var currImage: UIImageView!
    @IBOutlet weak var currName: UILabel!
    @IBOutlet weak var currUnit: UILabel!
    @IBOutlet weak var currValue: UITextField!
    
    var ref: FIRDatabaseReference!
    
    var currList = [cellData]()
    var currNum = 1.0
    var jsonCurrency = [String: AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currValue.resignFirstResponder()
        currValue.addTarget(self, action: #selector(CurrencyViewController.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        currValue.keyboardType = .decimalPad
        
        currName.text = "USD"
        currUnit.text = "United States Dollar"
        currImage.image = UIImage(named: currName.text!)
        
        updateJson(base: currName.text!)
        
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "currencyCell", for: indexPath) as! CurrencyTableViewCell
        
        cell.currencyName?.text = currList[indexPath.row].name
        cell.currencyUnit?.text = currList[indexPath.row].unit
        if let forcedValue = self.jsonCurrency[currList[indexPath.row].name] as? Double {
            cell.currencyValue?.text = "\(round(forcedValue * currNum * 100) / 100)"
        }
        else {
            cell.currencyValue?.text = ""
        }
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
        
        updateJson(base: currName.text!)
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        textField.becomeFirstResponder()
        if textField.text == "" || textField.text == "0" {
            currNum = 0.0
            currValue.text = "0"
        }
            
        else {
            if ((textField.text?[(textField.text?.startIndex)!])! == "0") && (textField.text?[(textField.text?.index(after: (textField.text?.startIndex)!))!] != ".") {
                textField.text?.remove(at: (textField.text?.startIndex)!)
            }
            currNum = Double(textField.text!)!
        }
        self.tableView.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(string == "," || string == "." ){
            let countdots = (textField.text?.components(separatedBy: ".").count)! - 1
            
            if countdots > 0 && (string == "." || string == "," )
            {
                return false
            }
        }
        
        return true
    }
    
    public func updateJson(base: String) {
        let url = "http://api.fixer.io/latest?base=" + base
        
        let urlRequest = URL(string: url)
        
        URLSession.shared.dataTask(with: urlRequest!, completionHandler: {
            (data, response, error) in
            if error != nil {
                print(error.debugDescription)
            }
            else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
                    self.jsonCurrency = json["rates"] as! [String : AnyObject]
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                catch let err{
                    print(err)
                }
            }
        }).resume()
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
        let remove = UITableViewRowAction(style: .normal, title: "Remove") { (action, indexPath) in
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
