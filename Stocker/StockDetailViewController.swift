//
//  StockDetailViewController.swift
//  Stocker
//
//  Created by Samuel Moosmann on 21/06/2017.
//  Copyright © 2017 Samuel Moosmann. All rights reserved.
//

import UIKit

class StockDetailViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var stockMeasurementFieldToolbar: UIToolbar!
    @IBOutlet weak var fieldToolbarDoneButton: UIBarButtonItem!
    
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet var itemImageGestureRecognizer: UITapGestureRecognizer!
    
    @IBOutlet weak var stockMeasurementTypeLabel: UITableViewCell!
    @IBOutlet weak var stockMeasurementUnitLabel: UILabel!
    @IBOutlet weak var stockMeasurementField: UITextField!
    
    let imagePickerController = UIImagePickerController()
    
    var measurementType: MeasurementType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Reversing hidden navigation bar from shopping list
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        // Image Selector Preparations
        itemImageView.isUserInteractionEnabled = true
        itemImageGestureRecognizer.addTarget(self, action: #selector(imagePickerTouched))
        
        
        // Adding toolbar for editing stock value
        stockMeasurementField.inputAccessoryView = stockMeasurementFieldToolbar!
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Segue Handling
    
    @IBAction func unwindToDetail(storyboardSegue: UIStoryboardSegue){
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "measurementUnitSegue" {
            let measurementUnitTableViewController = segue.destination as! MeasurementUnitTableViewController
            measurementUnitTableViewController.completionHandler = {(c1) in
                self.measurementType = c1
                self.stockMeasurementTypeLabel.detailTextLabel?.text = c1?.title
                
            }
        }
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
        itemImageView.image = info[UIImagePickerControllerOriginalImage] as! UIImage
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
