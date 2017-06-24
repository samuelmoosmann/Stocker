//
//  MeasurementUnitTableViewController.swift
//  Stocker
//
//  Created by Samuel Moosmann on 23/06/2017.
//  Copyright © 2017 Samuel Moosmann. All rights reserved.
//

import UIKit

class MeasurementUnitTableViewController: UITableViewController {

    var measurementTypes: [MeasurementType] = []
    var completionHandler: ((MeasurementType?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        measurementTypes.append(MeasurementType(unit: "UnitMass", title: NSLocalizedString("unitMass", comment: ""), iconImage: UIImage(named: "MeasurementTypeMassIcon")!))
        measurementTypes.append(MeasurementType(unit: "UnitLength", title: NSLocalizedString("unitLength", comment: ""), iconImage: UIImage(named: "MeasurementTypeLengthIcon")!))
        measurementTypes.append(MeasurementType(unit: "UnitVolume", title: NSLocalizedString("unitVolume", comment: ""), iconImage: UIImage(named: "MeasurementTypeVolumeIcon")!))
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return measurementTypes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "measurementTypeCell", for: indexPath) as! MeasurementUnitTableViewCell
        cell.measurementType = measurementTypes[indexPath.row]
        cell.measurementTypeLabel.text = measurementTypes[indexPath.row].title
        cell.measurementTypeImageView.image = measurementTypes[indexPath.row].iconImage
        return cell
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindToDetail" {
            let tableViewCell = sender as! MeasurementUnitTableViewCell
            completionHandler?(tableViewCell.measurementType!)
            
        }
    }
    
    
    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
