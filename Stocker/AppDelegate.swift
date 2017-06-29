//
//  AppDelegate.swift
//  Stocker
//
//  Created by Samuel Moosmann on 21/06/2017.
//  Copyright © 2017 Samuel Moosmann. All rights reserved.
//

import UIKit
import CoreData
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Fabric.with([Crashlytics.self])
        let rootViewController = window?.rootViewController as! UITabBarController
        let splitViewController = rootViewController.viewControllers?.first as! UISplitViewController
        let navigationController = splitViewController.viewControllers.first as! UINavigationController
        let stockTableViewController = navigationController.viewControllers.first as! StockTableViewController
        stockTableViewController.managedContext = persistentContainer.viewContext
        
        // Initially setup available measurement types
        
        var measurementTypes: [MeasurementType] = []
        
        // Setup
        let managedContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<MeasurementType>(entityName: "MeasurementType")
        let entity = NSEntityDescription.entity(forEntityName: "MeasurementType", in: persistentContainer.viewContext)
        do {
            // Count existing measurement types
            let measurementTypesCount = try persistentContainer.viewContext.count(for: fetchRequest)
            if measurementTypesCount == 0 {
                let unitMassType = MeasurementType(entity: entity!, insertInto: managedContext)
                unitMassType.title = "Mass"
                unitMassType.type = "unitMass"
                unitMassType.icon = NSData(data: UIImagePNGRepresentation(UIImage(named: "MeasurementTypeMassIcon")!)!)
                let unitLengthType = MeasurementType(entity: entity!, insertInto: managedContext)
                unitLengthType.title = "Length"
                unitLengthType.type = "unitLength"
                unitLengthType.icon = NSData(data: UIImagePNGRepresentation(UIImage(named: "MeasurementTypeLengthIcon")!)!)
                let unitVolumeType = MeasurementType(entity: entity!, insertInto: managedContext)
                unitVolumeType.title = "Volume"
                unitVolumeType.type = "unitVolume"
                unitVolumeType.icon = NSData(data: UIImagePNGRepresentation(UIImage(named: "MeasurementTypeVolumeIcon")!)!)
                
                try managedContext.save()
            }
            // Fetch measurement types
            measurementTypes = try managedContext.fetch(fetchRequest)
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            CLSLogv("Could not fetch. %@", getVaList([error.userInfo]))
            
        }
        
        stockTableViewController.measurementTypes = measurementTypes

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
       
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Stocker")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

