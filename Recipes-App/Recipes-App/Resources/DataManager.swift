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
    
    func getAllGroceries() ->Array<Any>{
        //create a fetch request, telling it about the entity
        let fetchRequest: NSFetchRequest<Groceries> = Groceries.fetchRequest()
        var searchResults:Array<Any>=[]
        do {
            //go get the results
            searchResults = try getContext().fetch(fetchRequest)
        } catch {
            //debugPrint("Error with request: \(error)")
        }
        return searchResults
    }
    
    
    
    func getUniqueID()->Int{
        
        let randomNumber = Int.random(in: 0..<20000000)
        
        //create a fetch request, telling it about the entity
        let fetchRequest: NSFetchRequest<Receipe> = Receipe.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "id=='\(randomNumber)'")
        
        var searchResults:Array<Any>=[]
        do {
            //go get the results
            searchResults = try getContext().fetch(fetchRequest)
        } catch {
            debugPrint("Error with request: \(error)")
        }
        let items = searchResults as! Array<Receipe>
        
        if(items.count != 0){
            _ = getUniqueID()
        }
        return randomNumber
    }
    
    func saveReceipe(Title: String){
        let context = self.getContext()
        let entity =  NSEntityDescription.entity(forEntityName: "Receipe", in: context)
        let chantingHolder = NSManagedObject(entity: entity!, insertInto: context)
        chantingHolder.setValue(Title, forKey: "title")
        chantingHolder.setValue(getUniqueID() , forKey: "id")
        do {
            try context.save()
            debugPrint("saved!")
        } catch let error as NSError  {
            debugPrint("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
    }
    
    func saveReceipeSteps(Steps: String, id: Int){
        let context = self.getContext()
        let entity =  NSEntityDescription.entity(forEntityName: "Steps", in: context)
        let chantingHolder = NSManagedObject(entity: entity!, insertInto: context)
        chantingHolder.setValue(Steps, forKey: "steps")
        chantingHolder.setValue(id , forKey: "id")
        do {
            try context.save()
            debugPrint("saved!")
        } catch let error as NSError  {
            debugPrint("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
    }
    
    func saveReceipeIngredients(Ingredients: String, id: Int){
        let context = self.getContext()
        let entity =  NSEntityDescription.entity(forEntityName: "Ingredients", in: context)
        let chantingHolder = NSManagedObject(entity: entity!, insertInto: context)
        chantingHolder.setValue(Ingredients, forKey: "steps")
        chantingHolder.setValue(id , forKey: "id")
        do {
            try context.save()
            debugPrint("saved!")
        } catch let error as NSError  {
            debugPrint("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
    }
    
    func setGrocerieWithSelected(id: Int, isSelected: Bool){
        let fetchRequest: NSFetchRequest<Groceries> = Groceries.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "id=='\(id)'")
        
        var searchResults:Array<Any>=[]
        do {
            //go get the results
            searchResults = try getContext().fetch(fetchRequest)
            
            for items in searchResults{
                if let items = items as? Groceries{
                      items.setValue(isSelected , forKey: "isSelected")
                }
                
            }
            saveInDatabase()
        } catch {
        }
    }
    
    func getReceipeSteps(id: Int)->Array<Steps>{
        let fetchRequest: NSFetchRequest<Steps> = Steps.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "id=='\(id)'")
        
        var searchResults:Array<Any>=[]
        do {
            //go get the results
            searchResults = try getContext().fetch(fetchRequest)
        } catch {
            debugPrint("Error with request: \(error)")
        }
        return searchResults as! Array<Steps>
    }
    
    func getReceipeIngredients(id: Int)->Array<Ingredients>{
        let fetchRequest: NSFetchRequest<Ingredients> = Ingredients.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "id=='\(id)'")
        
        var searchResults:Array<Any>=[]
        do {
            //go get the results
            searchResults = try getContext().fetch(fetchRequest)
        } catch {
            debugPrint("Error with request: \(error)")
        }
        return searchResults as! Array<Ingredients>
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
    
    func saveGroceriesSteps(isSelected:Bool, Steps: String){
        let context = self.getContext()
        let entity =  NSEntityDescription.entity(forEntityName: "Groceries", in: context)
        let groceries = NSManagedObject(entity: entity!, insertInto: context)
        groceries.setValue(Steps, forKey: "items")
        groceries.setValue(getUniqueID() , forKey: "id")
        groceries.setValue(isSelected, forKey: "isSelected")
        do {
            try context.save()
            debugPrint("saved!")
        } catch let error as NSError  {
            debugPrint("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
    }
    
    
    func getGroceriesStepsWith(id: Int)->Array<Groceries>{
        let fetchRequest: NSFetchRequest<Groceries> = Groceries.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "id=='\(id)'")
        var searchResults:Array<Any>=[]
        do {
            searchResults = try getContext().fetch(fetchRequest)
        } catch {
            debugPrint("Error with request: \(error)")
        }
        return searchResults as! Array<Groceries>
    }
    
    func deleteSteps() {
        let context = self.getContext()
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Steps")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
    func deleteIngredients() {
        let context = self.getContext()
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Ingredients")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
    func deleteStepsWithID(id: Int){
        let context = self.getContext()
        let fetchRequest: NSFetchRequest<Steps> = Steps.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "id==\(id)")
        let objects = try! context.fetch(fetchRequest)
        for obj in objects {
            context.delete(obj)
        }
        
        do {
            try context.save() // <- remember to put this :)
        } catch {
            // Do something... fatalerror
        }
    }
    
    func deleteGroceriesWithListID(id: Int)->Bool{
        let context = self.getContext()
        let fetchRequest: NSFetchRequest<Groceries> = Groceries.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "id==\(id)")
        let objects = try! context.fetch(fetchRequest)
        for obj in objects {
            context.delete(obj)
        }
        
        do {
            try context.save()
            return true// <- remember to put this :)
        } catch {
            return false
        }
    }
    
    func deleteIngredientID(id: Int){
        let context = self.getContext()
        let fetchRequest: NSFetchRequest<Ingredients> = Ingredients.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "id==\(id)")
        let objects = try! context.fetch(fetchRequest)
        for obj in objects {
            context.delete(obj)
        }
        
        do {
            try context.save() // <- remember to put this :)
        } catch {
            // Do something... fatalerror
        }
    }
    
    func deleteReceipeSteps(id: Int){
        let context = self.getContext()
        let fetchRequest: NSFetchRequest<Steps> = Steps.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "id==\(id)")
        let objects = try! context.fetch(fetchRequest)
        for obj in objects {
            context.delete(obj)
        }
        
        do {
            try context.save() // <- remember to put this :)
        } catch {
            // Do something... fatalerror
        }
    }
    
    func deleteReceipe(id: Int){
        let context = self.getContext()
        let fetchRequest: NSFetchRequest<Receipe> = Receipe.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "id==\(id)")
        let objects = try! context.fetch(fetchRequest)
        for obj in objects {
            context.delete(obj)
        }
        
        do {
            try context.save() // <- remember to put this :)
        } catch {
            // Do something... fatalerror
        }
    }
    
    func deleteItem(id: Int){
        self.deleteReceipe(id: id)
        self.deleteReceipeSteps(id: id)
        self.deleteIngredientID(id: id)
    }
}
