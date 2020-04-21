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
    var categories: [String]?
    var totals: [String]?
    
    let headerSections = ["Workouts", "Activity"]
    let sectionsList = [
        ["Full Body Workout", "Core & Legs", "Upper Body Strength", "Yoga"],
        ["Total Workouts", "Current Streak", "Longest Streak", "Avg Calories Burned"]
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        userAvatarImage.image = UIImage(named: "2")
        userAvatarImage.layer.cornerRadius = 25

    }
    
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
                cell.workoutCountLabel.text = computeTotalWorkouts()
            default:
                cell.workoutCountLabel.text = "0"
                cell.iconImage.image = UIImage(named: "icons8-warmup-50")
            }
            
            // Make cells with value 0 to be greyed out

            cell.workoutTypeLabel.tintColor = UIColor(named: "lightGray")
            cell.workoutCountLabel.tintColor = UIColor(named: "lightGray")
            cell.iconImage.tintColor = UIColor(named: "red")

            
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
    
    // MARK: - Helper methods

    func computeTotalWorkouts() -> String {
       
        return "0"
    }
    
    func computeCurrentStreak() -> String {
        return ""
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
    
    

}
