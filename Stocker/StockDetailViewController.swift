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
import Charts

class StockDetailViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, ChartViewDelegate {
    
    @IBOutlet var barChartView: HorizontalBarChartView!
    
    // MARK: Injected Data
    var managedContext: NSManagedObjectContext?
    var item: Item?
    var measurementTypes: [MeasurementType]?
    
    // MARK: State data, to be deleted
    var measurementType: MeasurementType?
    
    
    // MARK: UI Variables
    @IBOutlet var stockMeasurementFieldToolbar: UIToolbar!
    @IBOutlet weak var fieldToolbarDoneButton: UIBarButtonItem!
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    @IBOutlet weak var itemNameTextField: DisguisedTextField!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet      var itemImageGestureRecognizer: UITapGestureRecognizer!
    
    @IBOutlet weak var stockMeasurementTypeCell: UITableViewCell!
    @IBOutlet weak var stockMeasurementUnitLabel: UILabel!
    @IBOutlet weak var stockMeasurementField: UITextField!
    
    @IBOutlet weak var stockLowerThresholdTextField: UITextField!
    @IBOutlet weak var stockUpToTextField: UITextField!
    
    
    
    let imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Reversing hidden navigation bar from shopping list
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        // Image Selector Preparations
        itemImageView.isUserInteractionEnabled = true
        itemImageGestureRecognizer.addTarget(self, action: #selector(imagePickerTouched))
        
        
        // Adding toolbar for editing stock value
        stockMeasurementField.inputAccessoryView = stockMeasurementFieldToolbar!
        stockUpToTextField.inputAccessoryView = stockMeasurementFieldToolbar!
        stockLowerThresholdTextField.inputAccessoryView = stockMeasurementFieldToolbar!
        
        
        // Filling
        if let itemImage = item?.image {
            itemImageView.image = UIImage(data: Data(referencing: itemImage))
        }
        
        itemNameTextField.text = item?.name
        editButton.title = NSLocalizedString("Edit", comment: "")
        stockMeasurementTypeCell.detailTextLabel?.text = NSLocalizedString((item?.measurementType?.title)!, comment: "")
        
        // Graph Detail
        barChartView.delegate = self
        //let barChartData = [BarChartDataEntry(x: 1, y: Double((item?.stock?.value)!))]
        
    }
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        if editButton.title == NSLocalizedString("Edit", comment: "") {
            editButton.title = NSLocalizedString("Done", comment: "")
            itemNameTextField.editable = true
            itemNameTextField.becomeFirstResponder()
        }
        else {
            editButton.title = NSLocalizedString("Edit", comment: "")
            itemNameTextField.editable = false
            itemNameTextField.resignFirstResponder()
            item?.name = itemNameTextField.text
            save()
        }
        
        
    }
    
    // MARK: Segue Handling
    
    @IBAction func unwindToDetail(storyboardSegue: UIStoryboardSegue){
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "measurementUnitSegue" {
            let measurementUnitTableViewController = segue.destination as! MeasurementUnitTableViewController
            measurementUnitTableViewController.measurementTypes = measurementTypes!
            measurementUnitTableViewController.completionHandler = {(retrievedMeasurementType) in
                self.measurementType = retrievedMeasurementType
                self.item?.measurementType = retrievedMeasurementType
                self.stockMeasurementTypeCell.detailTextLabel?.text = NSLocalizedString((retrievedMeasurementType?.title)!, comment: "")
                self.save()
            }
        }
    }
    
    func fill(with item: Item){
        self.item = item

    }

    func imagePickerTouched(){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cameraAlertAction = UIAlertAction(title: NSLocalizedString("Take Photo", comment: ""), style: .default, handler: {(action) in
            self.imagePickerController.delegate = self
            self.imagePickerController.sourceType = .camera
            
            self.present(self.imagePickerController, animated: true, completion: nil)
            
        })
        alertController.addAction(cameraAlertAction)
        let choosePhotoAlertAction = UIAlertAction(title: NSLocalizedString("Choose Photo", comment: ""), style: .default, handler: {(action) in
            self.imagePickerController.delegate = self
            self.imagePickerController.sourceType = .photoLibrary
            
            self.present(self.imagePickerController, animated: true, completion: nil)
        })
        alertController.addAction(choosePhotoAlertAction)
        let cancelAlertAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: {(action) in
            self.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(cancelAlertAction)
        present(alertController, animated: true, completion: nil)
        
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
