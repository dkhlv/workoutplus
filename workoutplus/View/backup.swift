////
////  ViewController.swift
////  Data Application
////
////  Created by Diana Koval on 2020-04-08.
////  Copyright © 2020 Diana Koval. All rights reserved.
////
//
//import UIKit
//import CoreData
//
//class ViewController: UIViewController {
//    
//    var books: [Book]?
//    var numWorkouts = 0
//
//    @IBOutlet var textFields: [UITextField]!
//    @IBOutlet weak var button: UIButton!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        self.loadFromCoreData()
////        self.saveStatsData()
//        
//        NotificationCenter.default.addObserver(self, selector: #selector(self.saveToCoreData), name: UIApplication.willResignActiveNotification, object: nil)
//        
//        NotificationCenter.default.addObserver(self, selector: #selector(self.saveStatsData), name: UIApplication.willResignActiveNotification, object: nil)
//    }
//    
//    @IBAction func buttonPressed(_ sender: UIButton) {
//        retrieveStatsData()
//    }
//    
//    
//    @IBAction func updateButtonPressed(_ sender: UIButton) {
//        
//        updateStatsData()
//    }
//    
//    @IBAction func addBooksPressed(_ sender: UIBarButtonItem) {
//        
//        let title = textFields[0].text ?? ""
//        let author = textFields[1].text ?? ""
//        let pages = Int(textFields[2].text ?? "0") ?? 0
//        let year = Int(textFields[2].text ?? "0") ?? 0
//        
//        let book = Book(title: title, author: author, pages: pages, year: year)
//        self.books?.append(book)
//        
//        for textField in textFields {
//            textField.text = ""
//        }
//    }
//
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let dest = segue.destination as? BooksTableViewController {
//            dest.books = books
//        }
//    }
//    
//    @objc func saveStatsData(){
//        clearStatsData()
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        let managedContext = appDelegate.persistentContainer.viewContext
//        let statsEntity = NSEntityDescription.entity(forEntityName: "StatsModel", in: managedContext)!
//        let stats = NSManagedObject(entity: statsEntity, insertInto: managedContext)
//        stats.setValue(numWorkouts, forKey: "number")
//        
//        do {
//            try managedContext.save()
//        } catch {
//           print("Failed to save data")
//        }
//    }
//    
//    func retrieveStatsData(){
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        let managedContext = appDelegate.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StatsModel")
//        
//        do {
//            let result = try managedContext.fetch(fetchRequest)
//            for data in result as! [NSManagedObject] {
//                print(data.value(forKey: "number") as! Int)
//            }
//        } catch {
//            print("Fail")
//        }
//    }
//    
//    func updateStatsData(){
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        let managedContext = appDelegate.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StatsModel")
//         do
//         {
//             let test = try managedContext.fetch(fetchRequest)
//    
//                 let objectUpdate = test[0] as! NSManagedObject
//                 var value = objectUpdate.value(forKey: "number") as! Int
//                    value += 1
//                 objectUpdate.setValue(value, forKey: "number")
//                 do{
//                     try managedContext.save()
//                 }
//                 catch
//                 {
//                     print(error)
//                 }
//             }
//         catch
//         {
//             print(error)
//         }
//
//    }
//    
//    func clearStatsData(){
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//            return
//            
//        }
//        let managedContext = appDelegate.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StatsModel")
//        
//        do {
//            let results = try managedContext.fetch(fetchRequest)
//            if let resultsArray = results as? [NSManagedObject] {
//                for statsData in resultsArray {
//                    managedContext.delete(statsData)
//                }
//            }
//            
//        } catch {
//            print(error)
//        }
//        
//    }
//
//    
//    func loadFromCoreData(){
//        self.books = [Book]()
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//            return
//            
//        }
//        let managedContext = appDelegate.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BookModel")
//        
//        do {
//            let results = try managedContext.fetch(fetchRequest)
//            if let resultsArray = results as? [NSManagedObject] {
//                for bookData in resultsArray {
//                    let title = bookData.value(forKey: "title") as? String ?? ""
//                    let author = bookData.value(forKey: "author") as? String ?? ""
//                    let pages = bookData.value(forKey: "pages") as? Int ?? 0
//                    let year = bookData.value(forKey: "year") as? Int ?? 0
//                    let book  = Book(title: title, author: author, pages: pages, year: year)
//                    self.books?.append(book)
//                }
//            }
//            
//        } catch {
//            print(error)
//        }
//        
//    }
//    
//    @objc func saveToCoreData(){
//        
//        self.clearCoreData()
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let books = self.books else {
//            return
//            
//        }
//        
//        let managedContext = appDelegate.persistentContainer.viewContext
//        
//        
//        if let bookEntityDescription = NSEntityDescription.entity(forEntityName: "BookModel", in: managedContext){
//            for book in books {
//                let bookEntity = NSManagedObject(entity: bookEntityDescription, insertInto: managedContext)
//                bookEntity.setValue(book.title, forKey: "title")
//                bookEntity.setValue(book.author, forKey: "author")
//                bookEntity.setValue(book.pages, forKey: "pages")
//                bookEntity.setValue(book.year, forKey: "year")
//            }
//            
//            do {
//                try managedContext.save()
//            } catch {
//                print(error)
//            }
//            
//        }
//        
//    }
//
//    
//    func clearCoreData(){
//        self.books = [Book]()
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//            return
//            
//        }
//        let managedContext = appDelegate.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BookModel")
//        
//        do {
//            let results = try managedContext.fetch(fetchRequest)
//            if let resultsArray = results as? [NSManagedObject] {
//                for bookData in resultsArray {
//                    managedContext.delete(bookData)
//                }
//            }
//            
//        } catch {
//            print(error)
//        }
//        
//    }
//
//
//}
//
