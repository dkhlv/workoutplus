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
    
    //source https://medium.com/better-programming/how-to-save-an-image-to-core-data-with-swift-a1105ae2cf04
    func saveImage(data: Data) {
        let imageInstance = Image(context: managedContext)
        imageInstance.img = data
        do {
            try managedContext.save()
            print("Image is saved")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //source https://medium.com/better-programming/how-to-save-an-image-to-core-data-with-swift-a1105ae2cf04
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
    
}
    
