//
//  ProgressViewController.swift
//  workoutplus
//
//  Created by Diana Koval on 2020-04-09.
//  Copyright © 2020 Diana Koval. All rights reserved.
//

import UIKit
import CoreData

class ProgressViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
    @IBOutlet weak var userAvatarImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var categories: [Category]?
    var totals: [String]?
    
    var numWorkoutsFullBody = 0
    var numWorkoutsLegs = 0
    var numWorkoutsUpper = 0
    var numWorkoutsYoga = 0
    var numWorkoutsTotal = 0
    
    let headerSections = ["Workouts", "Activity"]
    var workoutNames = [String]()
    var sectionsList = [[String]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTableData()
        self.fetchStatsData()
        workoutNames = getWorkoutNames(categories: categories)
        sectionsList = [
            workoutNames,
            ["Total Workouts", "Avg Calories Burned"]
        ]
        
        tableView.delegate = self
        tableView.dataSource = self
        
        userAvatarImage.image = UIImage(named: "2")
        userAvatarImage.layer.cornerRadius = 25

    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        // 1
//        let nav = self.navigationController?.navigationBar
//      
//        // 2
//        nav?.barStyle = UIBarStyle.black
//        nav?.tintColor = UIColor.yellow
//      
//        // 3
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//        imageView.contentMode = .scaleAspectFit
//          
//        // 4
//        let image = UIImage(named: "2")
//        imageView.image = image
//          
//        // 5
//        navigationItem.titleView = imageView
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table View methods
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionsList[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ProgressCell") as? ProgressCell {
            let category = sectionsList[indexPath.section][indexPath.row]

            cell.workoutTypeLabel.text = category
            switch category {
            case "Full Body Workout":
                cell.workoutCountLabel.text = self.retrieveStatsData(key: "numWorkoutsFullBody")
                cell.iconImage.image = UIImage(named: "icons8-exercise-50")
            case "Core & Legs":
                cell.workoutCountLabel.text = self.retrieveStatsData(key: "numWorkoutsLegs")
                cell.iconImage.image = UIImage(named: "icons8-pilates-50")
            case "Upper Body Strength":
                cell.workoutCountLabel.text = self.retrieveStatsData(key: "numWorkoutsUpper")
                cell.iconImage.image = UIImage(named: "icons8-deadlift-50")
            case "Yoga":
                cell.workoutCountLabel.text = self.retrieveStatsData(key: "numWorkoutsYoga")
                cell.iconImage.image = UIImage(named: "icons8-yoga-50")
            case "Total Workouts":
                cell.workoutCountLabel.text = self.retrieveStatsData(key: "numWorkoutsTotal")
                cell.iconImage.image = UIImage(systemName: "star")
            case "Avg Calories Burned":
                cell.workoutCountLabel.text = "0"
                cell.iconImage.image = UIImage(systemName: "flame")
            default:
                cell.workoutCountLabel.text = "0"
                cell.iconImage.image = UIImage(named: "icons8-warmup-50")
            }
            
            return cell
            
        }

        return UITableViewCell()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsList.count
    }
    
    // Create a standard header that includes the returned text.
    func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {
        return "\(headerSections[section])"
    }
    
    // MARK: - Helper functions
    
    func loadTableData()
    {
        var categoryData: JSON?
        self.categories = [Category]()
        categoryData = readJSONFromFile(fileName: "workout_data")
            
            if let category = categoryData {
                for (_, json) in category {
                    self.categories?.append(Category(data: json))
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
    }
    
    func getWorkoutNames(categories: [Category]?)-> [String] {
        var names = [String]()
        if let categoryArray = categories {
            for category in categoryArray {
                names.append(category.categoryName)
            }
        }
        return names
    }

    

    // MARK: - Core Data functions
    
    func retrieveStatsData(key: String) -> String {
        
        var queryResult = ""
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return queryResult }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StatsModel")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                queryResult = "\(data.value(forKey: key) as! Int)"
                
//                print("Full body: \(data.value(forKey: "numWorkoutsFullBody") as! Int)")
//                print("Legs: \(data.value(forKey: "numWorkoutsLegs") as! Int)")
//                print("Upper: \(data.value(forKey: "numWorkoutsUpper") as! Int)")
//                print("Yoga \(data.value(forKey: "numWorkoutsYoga") as! Int)")
            }
        } catch {
            print("Fail")
        }
        return queryResult
    }
    
    func fetchStatsData() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StatsModel")
        do {
            let test = try managedContext.fetch(fetchRequest)
            if test.capacity == 0 {
                self.saveStatsData()
            }
        } catch {
            print(error)
        }
    }
    
    func saveStatsData(){
        
        self.clearStatsData()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext

        let stats = StatsModel(context: managedContext)


        stats.setValue(numWorkoutsFullBody, forKey: "numWorkoutsFullBody")
        stats.setValue(numWorkoutsLegs, forKey: "numWorkoutsLegs")
        stats.setValue(numWorkoutsUpper, forKey: "numWorkoutsUpper")
        stats.setValue(numWorkoutsYoga, forKey: "numWorkoutsYoga")
        stats.setValue(numWorkoutsTotal, forKey: "numWorkoutsTotal")
        
        do {
            try managedContext.save()
        } catch {
           print("Failed to save data")
        }
    }
    
    func clearStatsData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
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
        
    }
    
    

}
