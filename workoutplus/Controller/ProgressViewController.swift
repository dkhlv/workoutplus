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
    
    var categoryDictionary = [
        "Full Body Workout": "numWorkoutsFullBody",
        "Core & Legs": "numWorkoutsLegs",
        "Upper Body Strength": "numWorkoutsUpper",
        "Yoga": "numWorkoutsYoga",
        "Total Workouts": "numWorkoutsTotal"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTableData()
        CoreDataHelper.instance.fetchStatsData()
        workoutNames = getWorkoutNames(categories: categories)
        sectionsList = [
            workoutNames,
            ["Total Workouts", "Avg Calories Burned"]
        ]
        
        tableView.delegate = self
        tableView.dataSource = self
        
        userAvatarImage.image = self.loadImage()
        userAvatarImage.layer.cornerRadius = userAvatarImage.frame.size.height/2
        
        userNameLabel.text = self.loadUserName()

    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        tableView.reloadData()
        userAvatarImage.image = self.loadImage()
        userNameLabel.text = self.loadUserName()
        
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
            case "Total Workouts":
                cell.iconImage.image = UIImage(systemName: "star")
                cell.workoutCountLabel.text = CoreDataHelper.instance.retrieveStatsData(key: categoryDictionary[category]!)
            case "Avg Calories Burned":
                cell.workoutCountLabel.text = self.computeCaloriesAvg()
                cell.iconImage.image = UIImage(systemName: "flame")
            default:
                cell.workoutCountLabel.text = CoreDataHelper.instance.retrieveStatsData(key: categoryDictionary[category]!)
                let iconImage = categories![indexPath.row].icon
                cell.iconImage.image = UIImage(named: iconImage)
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
    
    func loadImage() -> UIImage {
        let arr = CoreDataHelper.instance.fetchImage()
        let defaultImage = UIImage(named: "profile_icon")!
        
        if arr.capacity == 0 {
            return defaultImage
        } else {
            return UIImage(data: arr[0].img!)!
        }
    }
    
    func loadUserName() -> String {
        let arr = CoreDataHelper.instance.fetchUserInfo()
        let defaultName = "User"
        
        if arr.capacity == 0 {
            return defaultName
        } else {
            return arr[0].name!
        }
    }
    
    func computeCaloriesAvg() -> String {
        return "0"
    }

}
