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
    var headerSections: [String]?
    
    let sectionsList = [
        ["Full Body Workout", "Core & Legs", "Upper Body Strength", "Yoga"],
        ["Total Workouts", "Current Streak", "Longest Streak"]
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        userAvatarImage.image = UIImage(named: "2")
        userAvatarImage.layer.cornerRadius = 25
        categories = ["Full Body Workout", "Core & Legs", "Upper Body Strength", "Yoga"]
        headerSections = ["Workouts", "Activity"]
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
            case "Core & Legs":
                cell.workoutCountLabel.text = "\(UserStatistics.numWorkoutsLegs)"
            case "Upper Body Strength":
                cell.workoutCountLabel.text = "\(UserStatistics.numWorkoutsUpper)"
            default:
                cell.workoutCountLabel.text = "0"
            }

            cell.iconImage.image = UIImage(named: "icons8-barbell-50")
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
        return "\(headerSections![section])"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

}
