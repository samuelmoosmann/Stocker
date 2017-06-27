//
//  StockDetailViewController.swift
//  Stocker
//
//  Created by Samuel Moosmann on 21/06/2017.
//  Copyright © 2017 Samuel Moosmann. All rights reserved.
//

import UIKit
import CoreData
import Crashlytics

class StockDetailViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var stockMeasurementFieldToolbar: UIToolbar!
    @IBOutlet weak var fieldToolbarDoneButton: UIBarButtonItem!
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    @IBOutlet weak var itemNameTextField: DisguisedTextField!
    
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet var itemImageGestureRecognizer: UITapGestureRecognizer!
    
    @IBOutlet weak var stockMeasurementTypeCell: UITableViewCell!
    @IBOutlet weak var stockMeasurementUnitLabel: UILabel!
    @IBOutlet weak var stockMeasurementField: UITextField!
    
    let imagePickerController = UIImagePickerController()
    
    var measurementType: MeasurementType?
    
    var managedContext: NSManagedObjectContext?
    var item: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Reversing hidden navigation bar from shopping list
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        // Image Selector Preparations
        itemImageView.isUserInteractionEnabled = true
        itemImageGestureRecognizer.addTarget(self, action: #selector(imagePickerTouched))
        
        
        // Adding toolbar for editing stock value
        stockMeasurementField.inputAccessoryView = stockMeasurementFieldToolbar!
        
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // Filling
        
        if let itemImage = item?.image {
            itemImageView.image = UIImage(data: Data(referencing: itemImage))
        }
        
        itemNameTextField.text = item?.name
        editButton.title = NSLocalizedString("Edit", comment: "")
        stockMeasurementTypeCell.detailTextLabel?.text = item?.measurementType
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        print(item?.name)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        if editButton.title == NSLocalizedString("Edit", comment: "") {
            editButton.title = NSLocalizedString("Done", comment: "")
            itemNameTextField.editable = true
        }
        else {
            editButton.title = NSLocalizedString("Edit", comment: "")
            itemNameTextField.editable = false
        }
        
        
    }
    
    // MARK: Segue Handling
    
    @IBAction func unwindToDetail(storyboardSegue: UIStoryboardSegue){
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "measurementUnitSegue" {
            let measurementUnitTableViewController = segue.destination as! MeasurementUnitTableViewController
            measurementUnitTableViewController.completionHandler = {(c1) in
                self.measurementType = c1
                print(self.item?.measurementType)
                print(c1?.title as String!)
                self.item?.measurementType = c1?.title
                print(self.item?.measurementType)
                self.stockMeasurementTypeCell.detailTextLabel?.text = c1?.title
                self.save()
                
            }
        }
    }
    
    func fill(with item: Item){
        self.item = item

    }

    func imagePickerTouched(){
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    // MARK: Toolbar Actions
    @IBAction func toolbarDoneButtonPressed(_ sender: Any) {
        stockMeasurementField.resignFirstResponder()
    }
    
    
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        itemImageView.image = image
        item?.image = NSData(data: UIImageJPEGRepresentation(image, 1)!)
        
        save()
    }

    func save() {
        do {
            try managedContext!.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            CLSLogv("Could not save. %@", getVaList([error.userInfo]))
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
