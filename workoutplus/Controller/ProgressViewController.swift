//
//  ProgressViewController.swift
//  workoutplus
//
//  Created by Diana Koval on 2020-04-09.
//  Copyright © 2020 Diana Koval. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
    @IBOutlet weak var userAvatarImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var categories: [String]?
    var totals: [String]?
    
    let  headerSections = ["Workouts", "Activity"]
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
                cell.workoutCountLabel.text = "\(UserStatistics.numWorkoutsFullBody)"
                cell.iconImage.image = UIImage(named: "icons8-exercise-50")
            case "Core & Legs":
                cell.workoutCountLabel.text = "\(UserStatistics.numWorkoutsLegs)"
                cell.iconImage.image = UIImage(named: "icons8-pilates-50")
            case "Upper Body Strength":
                cell.workoutCountLabel.text = "\(UserStatistics.numWorkoutsUpper)"
                cell.iconImage.image = UIImage(named: "icons8-deadlift-50")
            case "Yoga":
                cell.workoutCountLabel.text = "0"
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
        let total = UserStatistics.numWorkoutsUpper + UserStatistics.numWorkoutsFullBody + UserStatistics.numWorkoutsLegs
        return "\(total)"
    }
    
    func computeCurrentStreak() -> String {
        return ""
    }
    

}
