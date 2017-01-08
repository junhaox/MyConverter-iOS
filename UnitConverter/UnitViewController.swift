//
//  UnitViewController.swift
//  UnitConverter
//
//  Created by Junhao Xie on 12/30/16.
//  Copyright © 2016 Junhao Xie. All rights reserved.
//

import UIKit
import FirebaseDatabase

class UnitViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var currName: UILabel!
    @IBOutlet weak var currUnit: UILabel!
    @IBOutlet weak var currValue: UITextField!
    
    
    var ref: FIRDatabaseReference!
    
    var currList = [cellData]()
    
    var currNum = 1.0
    var currDimen = "Length"
    var currMeasurement: NSMeasurement!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currValue.delegate = self
        
        currNum = 1.0
        currValue.text = "1.0"
        
        currValue.resignFirstResponder()
        currValue.addTarget(self, action: #selector(CurrencyViewController.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        currValue.keyboardType = .decimalPad
        
        currList = []
        
        ref = FIRDatabase.database().reference()
        
        ref.child("Unit").child(currDimen).observe(.value, with: {
            snapshot in
            for child in snapshot.children {
                let data = cellData(name: (child as! FIRDataSnapshot).key, unit: (child as! FIRDataSnapshot).value as! String)
                self.currList.append(data)
                self.tableView.reloadData()
            }
        })
        
        currMeasurement = updateHead(dimension: currDimen, nameLabel: currName, unitLabel: currUnit)
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
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "unitCell", for: indexPath) as! UnitTableViewCell
        
        cell.nameLabel.text = currList[indexPath.row].name
        cell.unitLabel.text = currList[indexPath.row].unit
        updateValue(dimension: currDimen, unit: currList[indexPath.row].name, cellLabel: cell.valueLabel);
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tempName = currList[indexPath.row].name
        let tempUnit = currList[indexPath.row].unit
        
        currList[indexPath.row] = cellData(name: currName.text, unit: currUnit.text)
        
        currName.text = tempName
        currUnit.text = tempUnit

        currMeasurement = updateMeasurement(dimension: currDimen, unit: tempName!)
        
        self.tableView.reloadData()
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        textField.becomeFirstResponder()
        if textField.text == "" || textField.text == "0" {
            currNum = 0.0
            currValue.text = "0"
            currMeasurement = updateMeasurement(dimension: currDimen, unit: currName.text!)
        }
            
        else {
            if ((textField.text?[(textField.text?.startIndex)!])! == "0") && (textField.text?[(textField.text?.index(after: (textField.text?.startIndex)!))!] != ".") {
                textField.text?.remove(at: (textField.text?.startIndex)!)
            }
            currNum = Double(textField.text!)!
            currMeasurement = updateMeasurement(dimension: currDimen, unit: currName.text!)
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
    
    public func updateMeasurement(dimension: String, unit: String) -> NSMeasurement {
        switch dimension {
        case "Length":
            if unit == "meters" {
                return NSMeasurement(doubleValue: currNum, unit: UnitLength.meters)
            }
            else if unit == "centimeters" {
                return NSMeasurement(doubleValue: currNum, unit: UnitLength.centimeters)
            }
            else if unit == "feet" {
                return NSMeasurement(doubleValue: currNum, unit: UnitLength.feet)
            }
            else if unit == "inches" {
                return NSMeasurement(doubleValue: currNum, unit: UnitLength.inches)
            }
            else if unit == "kilometers" {
                return NSMeasurement(doubleValue: currNum, unit: UnitLength.kilometers)
            }
            else if unit == "miles" {
                return NSMeasurement(doubleValue: currNum, unit: UnitLength.miles)
            }
            else if unit == "millimeters" {
                return NSMeasurement(doubleValue: currNum, unit: UnitLength.millimeters)
            }
            break
        
        case "Area":
            if unit == "squareMeters" {
                return NSMeasurement(doubleValue: currNum, unit: UnitArea.squareMeters)
            }
            else if unit == "squareCentimeters" {
                return NSMeasurement(doubleValue: currNum, unit: UnitArea.squareCentimeters)
            }
            else if unit == "squareFeet" {
                return NSMeasurement(doubleValue: currNum, unit: UnitArea.squareFeet)
            }
            else if unit == "squareInches" {
                return NSMeasurement(doubleValue: currNum, unit: UnitArea.squareInches)
            }
            else if unit == "squareKilometers" {
                return NSMeasurement(doubleValue: currNum, unit: UnitArea.squareKilometers)
            }
            else if unit == "squareMiles" {
                return NSMeasurement(doubleValue: currNum, unit: UnitArea.squareMiles)
            }
            else if unit == "squareMillimeters" {
                return NSMeasurement(doubleValue: currNum, unit: UnitArea.squareMillimeters)
            }
            break
            
        case "Mass":
            if unit == "grams" {
                return NSMeasurement(doubleValue: currNum, unit: UnitMass.grams)
            }
            else if unit == "kilograms" {
                return NSMeasurement(doubleValue: currNum, unit: UnitMass.kilograms)
            }
            else if unit == "metricTons" {
                return NSMeasurement(doubleValue: currNum, unit: UnitMass.metricTons)
            }
            else if unit == "ounces" {
                return NSMeasurement(doubleValue: currNum, unit: UnitMass.ounces)
            }
            else if unit == "pounds" {
                return NSMeasurement(doubleValue: currNum, unit: UnitMass.pounds)
            }
            break
            
        case "Angle":
            if unit == "degrees" {
                return NSMeasurement(doubleValue: currNum, unit: UnitAngle.degrees)
            }
            else if unit == "radians" {
                return NSMeasurement(doubleValue: currNum, unit: UnitAngle.radians)
            }
            break
        
        case "Temperature":
            if unit == "celsius" {
                return NSMeasurement(doubleValue: currNum, unit: UnitTemperature.celsius)
            }
            else if unit == "fahrenheit" {
                return NSMeasurement(doubleValue: currNum, unit: UnitTemperature.fahrenheit)
            }
            break
            
        case "Energy":
            if unit == "calories" {
                return NSMeasurement(doubleValue: currNum, unit: UnitEnergy.calories)
            }
            else if unit == "joules" {
                return NSMeasurement(doubleValue: currNum, unit: UnitEnergy.joules)
            }
            else if unit == "kilowattHours" {
                return NSMeasurement(doubleValue: currNum, unit: UnitEnergy.kilowattHours)
            }
            break
            
        case "Speed":
            if unit == "kilometersPerHour" {
                return NSMeasurement(doubleValue: currNum, unit: UnitSpeed.kilometersPerHour)
            }
            else if unit == "metersPerSecond" {
                return NSMeasurement(doubleValue: currNum, unit: UnitSpeed.metersPerSecond)
            }
            else if unit == "milesPerHour" {
                return NSMeasurement(doubleValue: currNum, unit: UnitSpeed.milesPerHour)
            }
            break
            
        case "Power":
            if unit == "horsepower" {
                return NSMeasurement(doubleValue: currNum, unit: UnitPower.horsepower)
            }
            else if unit == "kilowatts" {
                return NSMeasurement(doubleValue: currNum, unit: UnitPower.kilowatts)
            }
            else if unit == "watts" {
                return NSMeasurement(doubleValue: currNum, unit: UnitPower.watts)
            }
            break
            
        case "Volume":
            if unit == "cubicFeet" {
                return NSMeasurement(doubleValue: currNum, unit: UnitVolume.cubicFeet)
            }
            else if unit == "cubicInches" {
                return NSMeasurement(doubleValue: currNum, unit: UnitVolume.cubicInches)
            }
            else if unit == "cubicKilometers" {
                return NSMeasurement(doubleValue: currNum, unit: UnitVolume.cubicKilometers)
            }
            else if unit == "cubicMeters" {
                return NSMeasurement(doubleValue: currNum, unit: UnitVolume.cubicMeters)
            }
            else if unit == "cubicMiles" {
                return NSMeasurement(doubleValue: currNum, unit: UnitVolume.cubicMiles)
            }
            else if unit == "fluidOunces" {
                return NSMeasurement(doubleValue: currNum, unit: UnitVolume.fluidOunces)
            }
            else if unit == "cubicMillimeters" {
                return NSMeasurement(doubleValue: currNum, unit: UnitVolume.cubicMillimeters)
            }
            else if unit == "gallons" {
                return NSMeasurement(doubleValue: currNum, unit: UnitVolume.gallons)
            }
            break
            
        default:
            break
        }
        return NSMeasurement(doubleValue: currNum, unit: UnitLength.miles)
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
        
        case "Area":
            if unit == "squareMeters" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitArea.squareMeters).value * 100) / 100)"
            }
            else if unit == "squareCentimeters" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitArea.squareCentimeters).value * 100) / 100)"
            }
            else if unit == "squareFeet" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitArea.squareFeet).value * 100) / 100)"
            }
            else if unit == "squareInches" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitArea.squareInches).value * 100) / 100)"
            }
            else if unit == "squareKilometers" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitArea.squareKilometers).value * 100) / 100)"
            }
            else if unit == "squareMiles" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitArea.squareMiles).value * 100) / 100)"
            }
            else if unit == "squareMillimeters" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitArea.squareMillimeters).value * 100) / 100)"
            }
            break
            
        case "Mass":
            if unit == "grams" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitMass.grams).value * 100) / 100)"
            }
            else if unit == "kilograms" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitMass.kilograms).value * 100) / 100)"
            }
            else if unit == "metricTons" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitMass.metricTons).value * 100) / 100)"
            }
            else if unit == "ounces" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitMass.ounces).value * 100) / 100)"
            }
            else if unit == "pounds" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitMass.pounds).value * 100) / 100)"
            }
            break
            
        case "Angle":
            if unit == "degrees" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitAngle.degrees).value * 100) / 100)"
            }
            else if unit == "radians" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitAngle.radians).value * 100) / 100)"
            }
            break
            
        case "Area":
            if unit == "squareMeters" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitArea.squareMeters).value * 100) / 100)"
            }
            else if unit == "squareCentimeters" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitArea.squareCentimeters).value * 100) / 100)"
            }
            else if unit == "squareFeet" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitArea.squareFeet).value * 100) / 100)"
            }
            else if unit == "squareInches" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitArea.squareInches).value * 100) / 100)"
            }
            else if unit == "squareKilometers" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitArea.squareKilometers).value * 100) / 100)"
            }
            else if unit == "squareMiles" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitArea.squareMiles).value * 100) / 100)"
            }
            else if unit == "squareMillimeters" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitArea.squareMillimeters).value * 100) / 100)"
            }
            break
            
        case "Temperature":
            if unit == "celsius" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitTemperature.celsius).value * 100) / 100)"
            }
            else if unit == "fahrenheit" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitTemperature.fahrenheit).value * 100) / 100)"
            }
            break
            
        case "Energy":
            if unit == "calories" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitEnergy.calories).value * 100) / 100)"
            }
            else if unit == "joules" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitEnergy.joules).value * 100) / 100)"
            }
            else if unit == "kilowattHours" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitEnergy.kilowattHours).value * 100) / 100)"
            }
            break
            
        case "Speed":
            if unit == "kilometersPerHour" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitSpeed.kilometersPerHour).value * 100) / 100)"
            }
            else if unit == "metersPerSecond" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitSpeed.metersPerSecond).value * 100) / 100)"
            }
            else if unit == "milesPerHour" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitSpeed.milesPerHour).value * 100) / 100)"
            }
            break
            
        case "Power":
            if unit == "horsepower" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitPower.horsepower).value * 100) / 100)"
            }
            else if unit == "kilowatts" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitPower.kilowatts).value * 100) / 100)"
            }
            else if unit == "watts" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitPower.watts).value * 100) / 100)"
            }
            break
            
        case "Volume":
            if unit == "cubicFeet" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitVolume.cubicFeet).value * 100) / 100)"
            }
            else if unit == "cubicInches" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitVolume.cubicInches).value * 100) / 100)"
            }
            else if unit == "cubicKilometers" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitVolume.cubicKilometers).value * 100) / 100)"
            }
            else if unit == "cubicMeters" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitVolume.cubicMeters).value * 100) / 100)"
            }
            else if unit == "cubicMiles" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitVolume.cubicMiles).value * 100) / 100)"
            }
            else if unit == "fluidOunces" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitVolume.fluidOunces).value * 100) / 100)"
            }
            else if unit == "cubicMillimeters" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitVolume.cubicMillimeters).value * 100) / 100)"
            }
            else if unit == "gallons" {
                cellLabel.text = "\(round(self.currMeasurement.converting(to: UnitVolume.gallons).value * 100) / 100)"
            }
            break
            
        default:
            break
        }
    }
    
    public func updateHead(dimension: String, nameLabel: UILabel, unitLabel: UILabel) -> NSMeasurement {
        switch dimension {
        case "Length":
            nameLabel.text = "miles"
            unitLabel.text = "mi"
            return NSMeasurement(doubleValue: 1.0, unit: UnitLength.miles)
            
        case "Area":
            nameLabel.text = "squareMeters"
            unitLabel.text = "m²"
            return NSMeasurement(doubleValue: 1.0, unit: UnitArea.squareMeters)
            
        case "Mass":
            nameLabel.text = "kilograms"
            unitLabel.text = "kg"
            return NSMeasurement(doubleValue: 1.0, unit: UnitMass.kilograms)
        
        case "Angle":
            nameLabel.text = "degrees"
            unitLabel.text = "°"
            return NSMeasurement(doubleValue: 1.0, unit: UnitAngle.degrees)
            
        case "Energy":
            nameLabel.text = "calories"
            unitLabel.text = "cal"
            return NSMeasurement(doubleValue: 1.0, unit: UnitEnergy.calories)
            
        case "Power":
            nameLabel.text = "horsepower"
            unitLabel.text = "hp"
            return NSMeasurement(doubleValue: 1.0, unit: UnitPower.horsepower)
            
        case "Speed":
            nameLabel.text = "milesPerHour"
            unitLabel.text = "mph"
            return NSMeasurement(doubleValue: 1.0, unit: UnitSpeed.milesPerHour)
            
        case "Temperature":
            nameLabel.text = "celsius"
            unitLabel.text = "°C"
            return NSMeasurement(doubleValue: 1.0, unit: UnitTemperature.celsius)
            
        case "Volume":
            nameLabel.text = "cubicMeters"
            unitLabel.text = "m³"
            return NSMeasurement(doubleValue: 1.0, unit: UnitVolume.cubicMeters)
            
        default:
            break
        }
        return NSMeasurement(doubleValue: 1.0, unit: UnitLength.miles)
    }
    
    @IBAction func unwindToUnit(segue: UIStoryboardSegue) {
        if segue.identifier == "backToUnitSegue" {
            if let seg = segue.source as? ChooseUnitTableViewController {
                self.ref = seg.ref
                self.currDimen = seg.currDimen
            }
            self.viewDidLoad()
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
