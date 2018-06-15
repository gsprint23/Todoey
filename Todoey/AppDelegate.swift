//
//  AppDelegate.swift
//  Todoey
//
//  Created by Gina Sprint on 6/13/18.
//  Copyright © 2018 Gina Sprint. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // gets called when app gets loaded up, first thing that happens
        // happens before viewDidLoad() in initial ViewController
        //print("Did finish launching with options")
        
        // get a path to data
        //print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
        // /Users/sprint/Library/Developer/CoreSimulator/Devices/7EEE0D3A-96ED-4FC4-A940-4FDB3D7E44AE/data/Containers/Data/Application/F0ACD87D-3623-4F0B-B0B1-B2B885E7462F/Documents
        // the last UID is the app's sandbox (the directory that has documents)
        // go to /Library/Preferences and will see the the plist
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel") // has to match .xcdatamodeld
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
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

