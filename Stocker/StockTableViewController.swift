//
//  StockTableViewController.swift
//  Stocker
//
//  Created by Samuel Moosmann on 21/06/2017.
//  Copyright © 2017 Samuel Moosmann. All rights reserved.
//

import UIKit
import CoreData
import Crashlytics

class StockTableViewController: UITableViewController {

    var items: [Item] = []
    var measurementTypes: [MeasurementType]?
    var managedContext: NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        items = fetchItems()!
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        //let entity = NSEntityDescription.entity(forEntityName: "Item", in: managedContext)!
        
        /* let item = NSManagedObject(entity: entity, insertInto: managedContext)
        
        item.setValue("Testobjekt", forKeyPath: "name")
        
        do {
            try managedContext.save()
            items.append(item)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        */
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockTableViewCell", for: indexPath) as! StockTableViewCell
        let item = items[indexPath.row]
        //cell.itemNameLabel.text = item.value(forKey: "name") as? String
        
        // FIXME: Should be set by cell with item
        cell.fill(with: item)
        
        
        cell.item = item
        print(item.objectID)
        print(item.measurementType)
        print(item.image)
        return cell
    }
    
    func fetchItems() -> [Item]? {
        var items: [Item] = []
        
        // Setup
        let fetchRequest = NSFetchRequest<Item>(entityName: "Item")
        
        do {
            items = try managedContext!.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            CLSLogv("Could not fetch. %@", getVaList([error.userInfo]))
            
        }
        
        return items
    }
    
    func createBlankItem() -> Item? {
        let entity = NSEntityDescription.entity(forEntityName: "Item", in: managedContext!)!
        let item = Item(entity: entity, insertInto: managedContext)

        item.name = NSLocalizedString("Unnamed item", comment: "")
        item.measurementType = measurementTypes?.first
        do {
            try managedContext!.save()
            items.append(item)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            CLSLogv("Could not save. %@", getVaList([error.userInfo]))
        }
        
        return item
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "itemDetailSegue":
            let stockDetailViewController = segue.destination as! StockDetailViewController
            let senderCell = sender as! StockTableViewCell
            stockDetailViewController.managedContext = managedContext
            stockDetailViewController.measurementTypes = measurementTypes
            stockDetailViewController.fill(with: senderCell.item!)
            //stockDetailViewController.item = senderCell.item
        case "createItemSegue":
            let stockDetailViewController = segue.destination as! StockDetailViewController
            stockDetailViewController.managedContext = managedContext
            stockDetailViewController.measurementTypes = measurementTypes
            //stockDetailViewController.item = createBlankItem()
            stockDetailViewController.fill(with: createBlankItem()!)
            items = fetchItems()!
            tableView.reloadData()
        default:
            break
        }
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let increaseButton = UITableViewRowAction(style: .default, title: " +1 ", handler: { action, index in
            
        })
        increaseButton.backgroundColor = UIColor(red:0.00, green:0.86, blue:0.85, alpha:1.0)
        
        let decreaseButton = UITableViewRowAction(style: .normal, title: " -1 ", handler: { action, index in
            
        })
        decreaseButton.backgroundColor = UIColor(red:0.00, green:0.63, blue:0.62, alpha:1.0)
        
        return [increaseButton, decreaseButton]
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
