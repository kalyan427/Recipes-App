//
//  AppDelegate.swift
//  Recipes-App
//
//  Created by venkata kalyan pasupuleti on 8/25/20.
//  Copyright © 2020 quiz. All rights reserved.
//

import UIKit
import CoreData
import GoogleMobileAds
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        IQKeyboardManager.shared.enable = true
        return true
    }
    
    // MARK: - Core Data Saving support
       ////*********** Core data compatibility*******************/////
       
       
       lazy var applicationDocumentsDirectory: URL = {
           // The directory the application uses to store the Core Data store file. This code uses a directory named "com.cadiridris.coreDataTemplate" in the application's documents Application Support directory.
           let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
           return urls[urls.count-1]
       }()
       
       lazy var managedObjectModel: NSManagedObjectModel = {
           // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
           let modelURL = Bundle.main.url(forResource: "Recipes_App", withExtension: "momd")!
           return NSManagedObjectModel(contentsOf: modelURL)!
       }()
       
       lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
           // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
           // Create the coordinator and store
           let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
           let url = self.applicationDocumentsDirectory.appendingPathComponent("Recipes_App" + ".sqlite")
           print(url)
           var failureReason = "There was an error creating or loading the application's saved data."
           do {
               try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
           } catch {
               // Report any error we got.
               var dict = [String: AnyObject]()
               dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
               dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
               
               dict[NSUnderlyingErrorKey] = error as NSError
               let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
               // Replace this with code to handle the error appropriately.
               // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
               NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
               abort()
           }
           
           return coordinator
       }()
       
       lazy var managedObjectContext: NSManagedObjectContext = {
           // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
           let coordinator = self.persistentStoreCoordinator
           var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
           managedObjectContext.persistentStoreCoordinator = coordinator
           return managedObjectContext
       }()
       
       // MARK: - Core Data Saving support
       
       func saveContext () {
           if managedObjectContext.hasChanges {
               do {
                   try managedObjectContext.save()
               } catch {
                   // Replace this implementation with code to handle the error appropriately.
                   // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                   let nserror = error as NSError
                   NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                   abort()
               }
           }
       }
       
       ////*********** Core data compatibility*******************/////＀
}

