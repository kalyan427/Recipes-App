//
//  DataManager.swift
//  Recipes-App
//
//  Created by Harish Kuramsetty on 10/12/20.
//  Copyright © 2020 quiz. All rights reserved.
//

import UIKit
import CoreData
class DataManager: NSObject {

    func getContext () -> NSManagedObjectContext {
           let appDelegate = UIApplication.shared.delegate as! AppDelegate
           //return appDelegate.persistentContainer.viewContext
           return appDelegate.managedObjectContext
       }
    
    func getAllReceipes() ->Array<Any>{
        //create a fetch request, telling it about the entity
        let fetchRequest: NSFetchRequest<Receipe> = Receipe.fetchRequest()
        var searchResults:Array<Any>=[]
        do {
            //go get the results
            searchResults = try getContext().fetch(fetchRequest)
        } catch {
            //debugPrint("Error with request: \(error)")
        }
        return searchResults
    }
    
    
    func saveReceipe(Title: String){
         let context = self.getContext()
        let entity =  NSEntityDescription.entity(forEntityName: "Receipe", in: context)
        let chantingHolder = NSManagedObject(entity: entity!, insertInto: context)
        chantingHolder.setValue(Title, forKey: "title")
        do {
            try context.save()
            debugPrint("saved!")
        } catch let error as NSError  {
            debugPrint("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
    }
    
    func saveInDatabase()  {
         let context = getContext()
         
         do {
             try context.save()
         } catch let error as NSError  {
             debugPrint("Could not save \(error), \(error.userInfo)")
         } catch {
             
         }
     }
}
