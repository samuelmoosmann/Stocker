//
//  MeasurementUnitTableViewController.swift
//  Stocker
//
//  Created by Samuel Moosmann on 23/06/2017.
//  Copyright © 2017 Samuel Moosmann. All rights reserved.
//

import UIKit

class MeasurementUnitTableViewController: UITableViewController {

    var measurementTypes: [MeasurementType]?
    var completionHandler: ((MeasurementType?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return measurementTypes!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "measurementTypeCell", for: indexPath) as! MeasurementUnitTableViewCell
        
        // TODO: Replace with fill function
        cell.measurementType = measurementTypes?[indexPath.row]
        cell.measurementTypeLabel.text = NSLocalizedString((measurementTypes?[indexPath.row].title)!, comment: "")
        
        if let icon = measurementTypes?[indexPath.row].icon {
            cell.measurementTypeImageView.image = UIImage(data: Data(referencing: icon))
        }
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
    

}
