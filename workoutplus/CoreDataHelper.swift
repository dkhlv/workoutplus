//
//  CoreDataHelper.swift
//  workoutplus
//
//  Created by Diana Koval on 2020-04-21.
//  Copyright © 2020 Diana Koval. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataHelper {
    
    static let instance = CoreDataHelper()
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - UserModel and Image functions
    
    func saveImage(data: Data) {
        //clear data
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Image")
        do {
            let results = try managedContext.fetch(fetchRequest)
            if let resultsArray = results as? [Image] {
                for data in resultsArray {
                    managedContext.delete(data)
                }
            }
            
        } catch {
            print(error)
        }
        
        //save data
        let imageInstance = Image(context: managedContext)
        imageInstance.img = data
        do {
            try managedContext.save()
            print("Image is saved")
        } catch {
            print(error.localizedDescription)
        }
    }

    
    func fetchImage() -> [Image] {
        var fetchingImage = [Image]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Image")
        
        do {
            fetchingImage = try managedContext.fetch(fetchRequest) as! [Image]
        } catch {
            print("Error while fetching the image")
        }
        
        return fetchingImage
    }
    
    func saveUserInfo(data: String) {
        //clear data
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserModel")
        do {
            let results = try managedContext.fetch(fetchRequest)
            if let resultsArray = results as? [UserModel] {
                for data in resultsArray {
                    managedContext.delete(data)
                }
            }
            
        } catch {
            print(error)
        }
        
        // save data
        let userInstance = UserModel(context: managedContext)
        userInstance.name = data
        do {
            try managedContext.save()
            print("User name is saved")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchUserInfo() -> [UserModel] {
        var fetchingNames = [UserModel]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserModel")
        
        do {
            fetchingNames = try managedContext.fetch(fetchRequest) as! [UserModel]
        } catch {
            print("Error while fetching the name")
        }
        
        return fetchingNames
    }
    
    // MARK: - StatsModel functions
    func retrieveStatsData(key: String) -> String {
        
        var queryResult = ""
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return queryResult }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StatsModel")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                queryResult = "\(data.value(forKey: key) as! Int)"
            }
        } catch {
            print("Fail")
        }
        return queryResult
    }
        
    func fetchStatsData() {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StatsModel")
        do {
            let test = try managedContext.fetch(fetchRequest)
            if test.capacity == 0 {
                let keys = ["numWorkoutsFullBody", "numWorkoutsLegs", "numWorkoutsUpper", "numWorkoutsYoga", "numWorkoutsTotal"]
                for key in keys {
                    self.saveStatsData(value: 0, key: key)
                }
            }
        } catch {
            print(error)
        }
    }
        
    func saveStatsData(value: Int, key: String){
        
        // clear
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StatsModel")
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            if let resultsArray = results as? [NSManagedObject] {
                for statsData in resultsArray {
                    managedContext.delete(statsData)
                }
            }
        } catch {
            print(error)
        }
    
        //save
        let stats = StatsModel(context: managedContext)
        stats.setValue(value, forKey: key)
        
        do {
            try managedContext.save()
        } catch {
           print("Failed to save data")
        }
    }
    
    func updateStatsData(key: String){

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StatsModel")
        do {
            let test = try managedContext.fetch(fetchRequest)
                let objectUpdate = test[0] as! NSManagedObject
                var value = objectUpdate.value(forKey: key) as! Int
                   value += 1
                objectUpdate.setValue(value, forKey: key)
                do{
                    try managedContext.save()
                }
                catch
                {
                    print(error)
                }
        } catch {
            print(error)
        }

    }
    
}
    
